# sorts the content of a file based on lines order
path = "./Post_Install_Scripts/"
fileName = "fedora.packages"
data = sorted([lines.strip('\n') for lines in open(path+fileName,'r').readlines()])
with open(path+fileName, 'w') as f:
    for line in data:
        f.write("%s\n" % line)
