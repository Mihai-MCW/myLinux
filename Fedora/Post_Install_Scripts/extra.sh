# Python versioning with pyenv install https://github.com/pyenv/pyenv
# don't forget to [pyenv rehash] after installing python versions
# then you can use [pyenv global x.x.x] to set the global path
# you can check what the current global version pyenv set with [pyenv shell]
# you can set a local version per folter with [python local x.x.x]
git clone https://github.com/pyenv/pyenv ~/Software/.pyenv
echo '###########################\n# pyenv python versioning #\n###########################\n'
echo 'export PYENV_ROOT="$HOME/Software/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi\n' >> ~/.bashrc
# Install virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo '# pyenv plugin virtualenv' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Install NLTK data
sudo python -m nltk.downloader -d /usr/local/share/nltk_data all

# Install Netbeans
#git clone https://github.com/apache/incubator-netbeans ~/Software/NetBeans
#cd ~/Software/NetBeans
# extra steps needed
#ant

#Install Visual Paradigm (GUI install) https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit
wget https://www.visual-paradigm.com/downloads/vpce/Visual_Paradigm_CE_Linux64.sh -O ~/Downloads/visualParadigm.sh
sh ~/Downloads/visualParadigm.sh
