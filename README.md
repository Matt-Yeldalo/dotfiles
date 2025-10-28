# Setup

Check [sources](/doc/sources.md)

1. Clone into `~/dotfiles`
2. install stow
3. `cd ~/dotfiles/`
3. `stow -v -R -t ~ */`

## NVIM

```ruby
bundle add ruby-lsp rubocop
bundle add ruby-lsp-rails --group development
bundle add erb-formatter htmlbeautifier --group development
```
