# DoveMusic(白鸽音乐)

DoveMusic是一个基于Flutter、Go开发个人音乐服务，支持私有化部署、全平台客户端支持

![](https://github.com/gstory0404/DoveMusic/blob/master/doc/app.png)

## 功能
- 多用户
- 读取本地.mp3、.flac文件中的tag属性存入表，不对源文件做任何操作
- 支持歌单
- 自动合并同一专辑的数据
- 自动合并同一歌手的数据
- 支持多语言
- 歌词
- 支持Android、iOS、MacOS、Windows、Linux等操作系统

## 说明
- 服务端会读取mp3、flac文件中的以下数据，在同步数据前，请确保以下数据没问题,防止数据错乱
  
|  参数   | 说明  |
|  :----:  | :----:  |
| Title  | 歌曲名称 |
| Format  | Tag格式 |
| FileType  | 文件类型 |
| Artist  | 歌手 |
| Album  | 专辑 |
| Year  | 发行年份 |
| Genre  | 流派 |
| Picture  | 封面 |
| Lyrics  | 歌词 |

## 安装
- docker
```
docker run --name dovemusic -v ./Music/:/app/data -v ./cache/:/app/cache -v ./.env/:/app/web/assets/assets/.env -p 9191:9191 --privileged -d gstory404/dovemusic:latest
```
- docker compose
```
version: "3.4"
services:
  dovemusic:
    image: gstory404/dovemusic:latest
    container_name: dovemusic
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
ADMIN_USER=admin
ADMIN_PWD=dovemusic
```
> 部署好访问 http://127.0.0.1:9191

> 默认管理员账号 admin  dovemusic

> 首次启动需要到设置-控制台 同步音乐资源

# 说明
- 由于[插件原因](https://github.com/bdlukaa/just_audio_windows/issues/26)，Windows暂时无法播放名称带空格的歌曲

# 声明
本项目禁止任何形式的商业用途，包括但不仅限于售卖/打赏/获利，不得使用本代码进行任何形式的牟利/贩卖/传播。  
本项目不提供任何音乐本体！对用户的行为及内容毫不知情，使用本软件产生的任何责任需由使用者本人承担。   
本项目仅以纯粹的技术目的去学习研究，如有侵犯到任何人的合法权利，请联系gstory0404@gmail.com。  
任何基于本项目的二开请标明来源，感谢！  

本项目基于[Apache License 2.0](https://github.com/gstory0404/DoveMusic/blob/master/LICENSE)许可证发行


