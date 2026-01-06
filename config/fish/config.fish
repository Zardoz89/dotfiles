# Bootstrap fisherman
function install_fisher --description 'Installs fisher and dependencies'
  if not functions -q fisher
      set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
      curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
      # fisher install hauleth/agnoster
      fisher install jorgebucaran/nvm.fish
      # agnoster powerline
  end
end

function install_starship --description 'Installs starship prompt'
  if not type -q starship
    curl -sS https://starship.rs/install.sh | sh
  end

  # Starship
  if type -q starship
    starship init fish | source
  end
end

function most_pager --description 'sets most as man pager if is installed'
  if type -q most
    echo "Setting most as pagger"
    set -g -x MANPAGER most
  end
end


function ssh_agent --description 'add the ssh keys to the ssh_agent'
  setup_kssaskpass

  for identityFile in (find $HOME/.ssh/ -type f -name "id_*")
    set -l fingerprint (ssh-keygen -lf $identityFile | awk '{print $2}')
    ssh-add -l | grep -q $fingerprint
      or ssh-add $identityFile
  end

  if test -f /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so ;and pkcs11-tool -M &>/dev/null
    set -l pkcs11Registered (ssh-add -l | grep PIV)
    if test -z "$pkcs11Registered"
      ssh-add -s /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so
    end
  end
end

function setup_kssaskpass --description 'sets ksshaskpass to be used to ask ssh passkey'
  if test $XDG_CURRENT_DESKTOP = "KDE"
      and type -q ksshaskpass
    set -g -x SSH_ASKPASS /usr/bin/ksshaskpass
    set -g -x SSH_ASKPASS_REQUIRE "prefer"
  end
end

function ssh_agent_start -d "start a new ssh agent"
  if test -z "$SSH_ENV"
    set -g -x SSH_ENV $HOME/.ssh/environment
  end

  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
end

function JAVA_ORACLE_8 --description 'Sets JAVA_HOME to Java Oracle 8'
  if test -d /usr/lib/jvm/java-8-oracle
    echo "Setting Oracle Java 8"
    set -gx JAVA_HOME /usr/lib/jvm/java-8-oracle
    alias java "/usr/lib/jvm/java-8-oracle/bin/java"
    alias javac "/usr/lib/jvm/java-8-oracle/bin/javac"
  end
end

function JAVA_11 --description 'Sets JAVA_HOME to Java OpenJDK 11'
  if test -d /usr/lib/jvm/java-11-openjdk-amd64/
    echo "Setting OpenJDK Java 11"
    set -gx JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
    alias java "/usr/lib/jvm/java-11-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-11-openjdk-amd64/bin/javac"
    alias jshell "/usr/lib/jvm/java-11-openjdk-amd64/bin/jshell"
    alias jps "/usr/lib/jvm/java-11-openjdk-amd64/bin/jps"
    alias jstat "/usr/lib/jvm/java-11-openjdk-amd64/bin/jstat"
  end
end

function JAVA_17 --description 'Sets JAVA_HOME to Java OpenJDK 17'
  if test -d /usr/lib/jvm/java-17-openjdk-amd64/
    echo "Setting OpenJDK Java 17"
    set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
    alias java "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-17-openjdk-amd64/bin/javac"
    alias jshell "/usr/lib/jvm/java-17-openjdk-amd64/bin/jshell"
    alias jps "/usr/lib/jvm/java-17-openjdk-amd64/bin/jps"
    alias jstat "/usr/lib/jvm/java-17-openjdk-amd64/bin/jstat"
  end
end

function JAVA_21 --description 'Sets JAVA_HOME to Java OpenJDK 21'
  if test -d /usr/lib/jvm/java-21-openjdk-amd64/
    echo "Setting OpenJDK Java 21"
    set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk-amd64/
    alias java "/usr/lib/jvm/java-21-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-21-openjdk-amd64/bin/javac"
    alias jshell "/usr/lib/jvm/java-21-openjdk-amd64/bin/jshell"
    alias jps "/usr/lib/jvm/java-21-openjdk-amd64/bin/jps"
    alias jstat "/usr/lib/jvm/java-21-openjdk-amd64/bin/jstat"
  end
end

function JAVA_22 --description 'Sets JAVA_HOME to Java OpenJDK 22'
  if test -d /usr/lib/jvm/java-22-openjdk-amd64/
    echo "Setting OpenJDK Java 22"
    set -gx JAVA_HOME /usr/lib/jvm/java-22-openjdk-amd64/
    alias java "/usr/lib/jvm/java-22-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-22-openjdk-amd64/bin/javac"
    alias jshell "/usr/lib/jvm/java-22-openjdk-amd64/bin/jshell"
    alias jps "/usr/lib/jvm/java-22-openjdk-amd64/bin/jps"
    alias jstat "/usr/lib/jvm/java-22-openjdk-amd64/bin/jstat"
  end
end

if status --is-interactive
  install_fisher
  install_starship
  most_pager
  ssh_agent
  JAVA_17
end

# Config bun
if test -d $HOME/.bun
  set -gx BUN_INSTALL $HOME/.bun
  fish_add_path -g $BUN_INSTALL/bin
  #PATH="$BUN_INSTALL/bin:$PATH"
end

# Config cargo/rust
if test -d $HOME/.cargo/env
  source $HOME/.cargo/env
  set PATH $PATH "$HOME/.cargo/bin"
end
if test -d $HOME/.cargo/bin
  set PATH $PATH "$HOME/.cargo/bin"
end

# Config NeoVIM local install
if test -d $HOME/opt/nvim-linux64/bin
  fish_add_path -g $HOME/opt/nvim-linux64/bin
else if test -d $HOME/opt/nvim-linux-x86_64/bin
  fish_add_path -g $HOME/opt/nvim-linux-x86_64/bin
end


# Alias


# Cargo

# Created by `pipx` on 2023-09-21 05:53:26
set PATH $PATH "$HOME/.local/bin"
