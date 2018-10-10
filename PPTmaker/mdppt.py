#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Usage: Combine this with Reveal.js on Github

# ## Usage:

# ```
# git clone https://github.com/hakimel/reveal.js
# python ./mdppy.py yourfile.md
# # Then move yourfile.md.html to root dir of reveal.js
# ```

# ***

# Huaqiang Wang (c) 2018

# TODO: title
# TODO: theme
# TODO: vertical-slides
# TODO: learn-the-md-html-converer

import subprocess
import sys

#read file in line
#建立全局变量
paper=""
insection=[0]
insubsection=0
file_to_open="1.md"
_encoding="utf-8"

outputencoding="utf-8"

#在输出缓冲区paper中加入新内容
def add(addon):
    global paper
    paper=paper+addon

#正文逐行处理函数
def convertline(line):
    global paper
    global insection

    #在此处添加针对语法的特殊处理
    #对于单行语法    
    if ("---" in line) and (len(line)<=4):
        add(r'''
        </textarea>
        </section>
        </section>
        <section>
        <section data-markdown>
        <textarea data-template>
        ''')
        return 0
    else: 
        if ("--" in line)and(len(line)<=3):
            add(r'''
                </textarea>
                </section>
                <section data-markdown>
                <textarea data-template>
                ''')
            return 0

    #对于块语法
        # if "@" in line:

        #定义
            # if "定义" in line:
            #     insection.append("定义")
            #     name=line[4:]
            #     add(r'''2333''')
            #     return 0

            # if insection[-1]=="定义":
            #     add(r'''2333''')
            #     insection.pop()
            #     return 0


    #若不属于任何特殊情况(没有@)
    add(line)
            
            


#读取文件
if(len(sys.argv)>1):
    file_to_open=sys.argv[1]
else:
    pass
    # file_to_open="note.md"

if(len(sys.argv)>2):
    _encoding=sys.argv[2]
else:
    pass
    # _encoding="utf-8"
    
outputfilename=file_to_open+".html"

file=open(file_to_open,encoding=_encoding)

#获取附加参数
# name=input("name:")

#设置默认参数
# if(name==""):
    # name="Augustus Wang"

# head=open('filehead.dat','r',encoding='utf-8').read()
# paper=paper+head

#写文件头
add(r'''<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <title>reveal.js</title>

        <link rel="stylesheet" href="css/reveal.css">
        <link rel="stylesheet" href="css/theme/black.css">

        <!-- Theme used for syntax highlighting of code -->
        <link rel="stylesheet" href="lib/css/zenburn.css">

        <!-- Printing and PDF exports -->
        <script>
            var link = document.createElement( 'link' );
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
            document.getElementsByTagName( 'head' )[0].appendChild( link );
        </script>
    </head>
    <body>
        <div class="reveal">
            <div class="slides">

                <section id="themes">
                    <h2>Settings</h2>
                    <h6>Original code from reveal.js</h6>
                    <h6>Converter by AW</h6>
                    <h6>ESC to show general view.</h6>
                    <h6>S to use speecher's mode.</h6>
                    <p>
                        You can select from different transitions, like: <br>
                        <a href="?transition=none#/transitions">None</a> -
                        <a href="?transition=fade#/transitions">Fade</a> -
                        <a href="?transition=slide#/transitions">Slide</a> -
                        <a href="?transition=convex#/transitions">Convex</a> -
                        <a href="?transition=concave#/transitions">Concave</a> -
                        <a href="?transition=zoom#/transitions">Zoom</a>
                    </p>
                </section>
                <section>
                <section data-markdown>
                    <textarea data-template>
''')

#逐行处理
while True:
    line =file.readline()
    if not line:
        break
    convertline(line)

#写文件尾
add(r'''                        
                    </textarea>
                </section>
                </section>
                
            </div>
        </div>

        <script src="lib/js/head.min.js"></script>
        <script src="js/reveal.js"></script>

        <script>
            // More info about config & dependencies:
            // - https://github.com/hakimel/reveal.js#configuration
            // - https://github.com/hakimel/reveal.js#dependencies
            Reveal.initialize({
                dependencies: [
                    { src: 'plugin/markdown/marked.js' },
                    { src: 'plugin/markdown/markdown.js' },
                    { src: 'plugin/notes/notes.js', async: true },
                    { src: 'plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } }
                ]
            });
        </script>
    </body>
</html>
''')


output=open(outputfilename,'w',encoding=outputencoding)
output.write(paper)

output.close()
file.close()

# #结束后调用命令行命令
# # os.system('pdflatex output.tex %DOC%')

# # log=subprocess.call(r"pdflatex output.tex %DOC%",shell=True)
# # print(log)
# command="xcopy reveal.js .\\"+file_to_open+"_ppt"+" /S /Y"
# print(outputfilename)
# command2="xcopy "+outputfilename+" "+".\\"+file_to_open+"_ppt"+" /Y"
# print(command2)
# subprocess.call(command)
# subprocess.call(command2)
print("Convert finished.")
input()

