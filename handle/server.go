package handle

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
	"github.com/wyx2685/UniProxy/v2b"
)

var servers map[string]*v2b.ServerInfo
var orderservers []string
var updateTime time.Time

func GetServers(c *gin.Context) {
	if len(servers) != 0 && time.Now().Before(updateTime) {
		orderedJSON := buildOrderedJSON()
		c.Data(200, "application/json", []byte(orderedJSON))
		return
	}
	r, err := v2b.GetServers()
	if err != nil {
		log.Error("get server list error: ", err)
		c.JSON(400, Rsp{Success: false, Message: err.Error()})
		return
	}
	updateTime = time.Now().Add(180 * time.Hour)

	servers = make(map[string]*v2b.ServerInfo, len(r))
	orderservers = make([]string, 0, len(r))
	for i := range r {
		key := fmt.Sprintf("%s_%d", r[i].Type, r[i].Id)
		servers[key] = &r[i]
		orderservers = append(orderservers, key)
	}
	orderedJSON := buildOrderedJSON()
	c.Data(200, "application/json", []byte(orderedJSON))
}

func buildOrderedJSON() string {
	var sb strings.Builder

	sb.WriteString(`{"success": true, "data": {`)
	for i, key := range orderservers {
		server := servers[key]
		serverJSON, err := json.Marshal(server)
		if err != nil {
			continue
		}
		sb.WriteString(fmt.Sprintf(`"%s": %s`, key, serverJSON))
		if i < len(orderservers)-1 {
			sb.WriteString(",")
		}
	}
	sb.WriteString("}}")
	return sb.String()
}