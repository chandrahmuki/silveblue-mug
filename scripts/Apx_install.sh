#!/bin/bash

 Download the precompiled binary  
curl -LO https://github.com/Vanilla-OS/apx/releases/download/1.8.2/apx_Linux_x86_64.tar.gz  

# Extract the binary  
tar -xzvf apx_Linux_x86_64.tar.gz  
#create the directory as it doesnt exist yet on a new system
mkdir -p $HOME/.local/bin
# Move the binary to the local bin directory
mv apx_Linux_x86_64/apx $HOME/.local/bin

# Remove the downloaded tar file and the extracted directory
rm -rf apx_Linux_x86_64.tar.gz apx_Linux_x86_64

# Check if the path is already in the PATH variable
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  # Add the path to the shell config file
  shell_config_file=""

  case $SHELL in
    *bash*)
      shell_config_file="$HOME/.bashrc"
      ;;
    *zsh*)
      shell_config_file="$HOME/.zshrc"
      ;;
    *fish*)
      shell_config_file="$HOME/.config/fish/config.fish"
      ;;
    *)
      echo "Unsupported shell. Please add the following line manually to your shell config file:"
      echo "export PATH=\$PATH:\$HOME/.local/bin:\$HOME/.local/share/apx/bin"
      exit 1
      ;;
  esac

  if [[ $SHELL == *fish* ]]; then
    echo "set -gx PATH \$PATH \$HOME/.local/bin \$HOME/.local/share/apx/bin" >> $shell_config_file
  else
    echo "export PATH=\$PATH:\$HOME/.local/bin:\$HOME/.local/share/apx/bin" >> $shell_config_file
  fi

  echo "Path added to $shell_config_file"
else
  echo "The path is already in your PATH variable."
fi
