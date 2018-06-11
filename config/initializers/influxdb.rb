$influxdb = InfluxDB::Client.new("blog", hosts: ["127.0.0.1"], port: 8086, username: "root", password: "root")
