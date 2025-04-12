# Top

The top command is a powerful tool that allows you to see which programs are using the most resources on your computer.

I use the top command all the time, both on my local machine and on remote servers to diagnose performance issues. If you've ever opened up your task manager on Windows or Activity Monitor on macOS, top is similar, but for the command line.

Notice that the top command runs in a loop, updating the information every few seconds.

By default, top sorts the processes by CPU usage, with the most CPU-intensive processes at the top. Another useful resource to sort by is memory (RAM) usage. To sort by memory usage, press M (uppercase) while top is running. MacOS users may need to use o mem <enter>.

Exit the top command by pressing q.
