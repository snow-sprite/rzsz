# iterm2 rz与sz的功能

本文主要介绍`mac`环境下使用`iterm2`的`rzsz`功能的安装流程（可适配M1🎉）。

## 1. 安装lrzsz

```bash
brew install lrzsz #可以在等待安装的过程中执行第2步
```
> brew的安装很简单，请自行百度

## 2. 安装执行脚本

将``iterm2-send-zmodem.sh``和``iterm2-recv-zmodem.sh``保存到`/usr/local/bin`目录下。





## 3. 给这两个文件可执行权限（必须）

```bash
chmod 777 /usr/local/bin/iterm2-*
```

## 4. 设置Iterm2的Tirgger特性

设置Iterm2的Tirgger特性，profiles->default->editProfiles->Advanced中的Tirgger

添加两条trigger，分别设置 Regular expression，Action，Parameters，Instant如下：

```bash
Regular expression: rz waiting to receive.\*\*B0100
Action: Run Silent Coprocess
Parameters: /usr/local/bin/iterm2-send-zmodem.sh
Instant: checked

Regular expression: \*\*B00000000000000
Action: Run Silent Coprocess
Parameters: /usr/local/bin/iterm2-recv-zmodem.sh
Instant: checked
```

示例图：

<img src="https://raw.githubusercontent.com/snow-sprite/rzsz/master/triggers.jpg">

## 5. 在服务器端使用

- 上传文件：rz
- 下载文件：sz file1 file2 file(n)...

参考：

- https://www.robberphex.com/use-zmodem-at-macos/
- https://github.com/RobberPhex/iterm2-zmodem
