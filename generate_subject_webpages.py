#!/usr/bin/env python3

import sys
import os
import re
import yaml
import threading
from pathlib import Path

def gen_files_list(files, prefix=""):
    files_link_content=""
    template_link_content= \
"""\t<a href=\"<url>\"><name></a>
\t<p>(<description>)</p>"""
    for file in files:
        print(" file : ", file)
        darkmode_pdf = False
        if file[len(file)-9:] == "-dark.pdf":
        	config_file = file[:-9]+'.yaml'
        	darkmode_pdf = True
        else: config_file = file[:-4]+'.yaml'
        print("config file yaml : ",config_file)
        config = load_config(config_file)
        name = "Unknown file"
        desc = "Empty description"

        if config:
            name = config["name"]
            desc = config["description"]
        if darkmode_pdf:
        	name += " (dark)"
        	desc += " - dark mode"
        buff = template_link_content
        buff = re.sub('<url>', prefix+file.split('/')[-1], buff)
        buff = re.sub('<name>', name, buff)
        buff = re.sub('<description>', desc, buff)
        files_link_content += buff +'\n'
    return files_link_content 

def generate_content(matiere, pdfs, images, file_path, configs=None):
    content = Path("sample_subject_webpage.html").read_text() 

    auth = "The author"
    desc = "The description"
    title = "The Title"
    print("config : ",configs)
    if configs != None:
        auth = configs["author"]
        desc = configs["description"]
        title = configs["title"]
    content = re.sub('<thedescription>',desc, content)
    content = re.sub('<theauthor>',auth, content)
    content = re.sub('<thetitle>',title, content)
    
    files_link_content = gen_files_list(pdfs)
    images_link_content = gen_files_list(images, "images/")

    content = re.sub('<thefiles>', files_link_content, content)
    content = re.sub('<theimages>', images_link_content, content)

    file = open(file_path, "w+")
    file.write(content)
    

def load_config(yaml_configfile):
    try:
        content = open(yaml_configfile)
    except:
        return None
    return yaml.load(content, Loader=yaml.SafeLoader)
    

def list_pdfs(path):
    files = []
    for file in os.listdir(path):
        if file.endswith(".pdf"):
            files.append(os.path.join(path, file))

    return files

def list_images(path):
    files = []
    try:
        for file in os.listdir(path):
            if file.endswith(".jpg") or file.endswith(".jpeg"):
                files.append(os.path.join(path, file))
    except:
        print("No images")
    return files

threads = []

for line in sys.stdin:
    mat = line.strip()
    print("args : ", mat)
    file_path = "./"+mat+"/index.html"
    pdfs = list_pdfs("./"+mat)
    images = list_images("./"+mat+"/images")
    thread = threading.Thread(target=generate_content, args=(mat, pdfs, images, file_path, load_config("./"+mat+"/info.yaml")))
    thread.start()
    threads.append(thread)

for thread in threads:
    thread.join()