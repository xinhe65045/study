

iTerm2是Mac上最好用的终端app，没有之一。使用终端时往往需要连接不同的服务器，通常我们会为每个服务器连接设置一个profile




这样点击一个profile就可以快速连接服务器，但这时可能会出现另一个问题，当我们打开多个标签时，希望能通过标签名字区分每个连接，最好是以profile name来标记，而iTerm2默认会根据你运行的程序自动切换标签的名字，比如我分别连接了“内网开发机55”和“内网开发机57”这两个配置，结果显示出来的是这样



如果要固定标签名字，有如下两个方式

临时修改

修改session title，Edit->Edit Session(cmd+I)，输入session title即可。这种方式只是临时修改了标签名字



永久性修改

先确保Preference->Appearance->Show profile name已经勾选上



再打开Preference->Profiles，选中你要设置的profile，点击右边的Terminal标签，将Terminal
 may set tab/window name前的勾取消掉



这时再重新链接，就是这样的效果了
