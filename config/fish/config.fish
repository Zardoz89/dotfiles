# Bootstrap fisherman
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher install hauleth/agnoster
    agnoster powerline
end

function most_pager --description 'sets most as man pager if is installed'
  if type -q most
    echo "Setting most as pagger"
    set -g -x MANPAGER most
  end
end

function ssh_agent --description 'launch the ssh-agent and add the id_rsa identity'
    if begin
            set -q SSH_AGENT_PID
            and kill -0 $SSH_AGENT_PID
            and grep -q '^ssh-agent' /proc/$SSH_AGENT_PID/cmdline
          end
        echo "ssh-agent running on pid $SSH_AGENT_PID"
    else
        eval (command ssh-agent -c | sed 's/^setenv/set -Ux/')
    end
    if test -f $HOME/.ssh/id_rsa
      set -l identity $HOME/.ssh/id_rsa
      set -l fingerprint (ssh-keygen -lf $identity | awk '{print $2}')
      ssh-add -l | grep -q $fingerprint
          or ssh-add $identity
    end
    if test -f $HOME/.ssh/id_ecdsa
      set -l identity $HOME/.ssh/id_ecdsa
      set -l fingerprint (ssh-keygen -lf $identity | awk '{print $2}')
      ssh-add -l | grep -q $fingerprint
          or ssh-add $identity
    end
end

if test -d $HOME/.cargo/env
  source $HOME/.cargo/env
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
  end
end

function JAVA_14 --description 'Sets JAVA_HOME to Java OpenJDK 14'
  if test -d /usr/lib/jvm/java-14-openjdk-amd64/
    echo "Setting OpenJDK Java 14"
    set -gx JAVA_HOME /usr/lib/jvm/java-14-openjdk-amd64/
    alias java "/usr/lib/jvm/java-14-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-14-openjdk-amd64/bin/javac"
  end
end

function JAVA_17 --description 'Sets JAVA_HOME to Java OpenJDK 17'
  if test -d /usr/lib/jvm/java-17-openjdk-amd64/
    echo "Setting OpenJDK Java 17"
    set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
    alias java "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"
    alias javac "/usr/lib/jvm/java-17-openjdk-amd64/bin/javac"
  end
end

if status --is-interactive
  most_pager
  ssh_agent
  JAVA_11
end
# Alias                                                                                                           

