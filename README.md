# LarkMusic（云雀音乐）

云雀音乐是一个基于FLutter、Go开发个人音乐服务，支持私有化部署、全平台客户端支持

## 功能
- 多用户
- 读取本地.mp3、.flac文件中的tag属性存入表，不对源文件做任何操作
- 支持歌单
- 自动合并同一专辑的数据
- 自动合并同一歌手的数据
- 支持多语言
- 支持Android、iOS、MacOS、Windows、Linux等操作系统

## 安装
- docker
```
docker run --name larkmusic -v ./Music/:/app/data -v ./cache/:/app/cache -v ./.env/:/app/web/assets/assets/.env -p 9191:9191 --privileged -d gstory404/larkmusic:0.0.1
```
- docker compose
```
version: "3.4"
services:
  larkmusic:
    image: gstory404/larkmusic:0.0.1
    container_name: larkmusic
    ports:
      - 9191:9191
    volumes:
      - ./Music/:/app/data
      - ./cache/:/app/cache
      - ./.env/:/app/web/assets/assets/.env
    privileged: true
    restart: always
```
> /app/data 音乐文件目录  
> /app/cache 缓存文件  
> /app/web/assets/assets/.env 配置文件

- .env
```
BASE_URL=http://127.0.0.1:9191
```
> 默认账号 admin  admin