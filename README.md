# ZSH Plugins v2.0

> A modern, high-performance collection of essential ZSH enhancements combining the best features from popular ZSH plugins into one optimized package.

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![ZSH Version](https://img.shields.io/badge/ZSH-5.0%2B-green.svg)](https://www.zsh.org/)
[![Performance](https://img.shields.io/badge/Performance-Optimized-orange.svg)](#-performance)

## ✨ Features

### 🎯 Core Components

- **🔍 Autosuggestions** - Fish-like command suggestions based on history
- **🎨 Syntax Highlighting** - Real-time command syntax highlighting
- **📝 Autocomplete** - Enhanced tab completion with smart matching
- **🔄 History Substring Search** - Navigate command history with partial matches

### ⚡ Performance Features

- **Async Loading** - Background component initialization
- **Lazy Loading** - Load components only when needed
- **Smart Caching** - Intelligent metadata and configuration caching
- **System Detection** - Automatic performance optimization based on system resources
- **Minimal Overhead** - Optimized for fast startup times

### 🛠️ Advanced Features

- **Progress Indicators** - Visual feedback during plugin loading
- **Debug Mode** - Comprehensive troubleshooting capabilities
- **Configuration Profiles** - Support for different environment setups
- **Performance Monitoring** - Real-time load time tracking
- **Memory Optimization** - Efficient resource utilization

## 🚀 Quick Start

### Prerequisites

- ZSH 5.0 or newer
- Git (for installation)

### Installation

#### Method 1: Direct Clone

```bash
# Clone the repository
git clone https://github.com/mohdismailmatasin/zsh-plugins.git ~/.config/zsh-plugins

# Add to your ~/.zshrc
echo 'source ~/.config/zsh-plugins/zsh-plugins.plugin.zsh' >> ~/.zshrc

# Reload your shell
source ~/.zshrc
```

#### Method 2: Oh My Zsh Plugin

```bash
# Clone to Oh My Zsh custom plugins directory
git clone https://github.com/mohdismailmatasin/zsh-plugins.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-plugins

# Add to plugins array in ~/.zshrc
plugins=(... zsh-plugins)
```

#### Method 3: Manual Download

```bash
# Download and extract
curl -L https://github.com/mohdismailmatasin/zsh-plugins/archive/main.zip -o zsh-plugins.zip
unzip zsh-plugins.zip -d ~/.config/
mv ~/.config/zsh-plugins-main ~/.config/zsh-plugins

# Source in ~/.zshrc
echo 'source ~/.config/zsh-plugins/zsh-plugins.plugin.zsh' >> ~/.zshrc
```

## ⚙️ Configuration

### Basic Configuration

Add these variables to your `~/.zshrc` before sourcing the plugin:

```bash
# Performance mode (auto|high|medium|low)
export ZSH_PLUGINS_PERFORMANCE_MODE=auto

# Enable debug output
export ZSH_PLUGINS_DEBUG=false

# Show loading progress
export ZSH_PLUGINS_SHOW_PROGRESS=true

# Enable lazy loading
export ZSH_PLUGINS_LAZY_LOAD=false

# Enable async loading (experimental)
export ZSH_PLUGINS_ASYNC_LOAD=false

# Custom cache directory
export ZSH_PLUGINS_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-plugins"

# Configuration profile
export ZSH_PLUGINS_CONFIG_PROFILE=default
```

### Performance Modes

| Mode | CPU Cores | RAM | Features | Best For |
|------|-----------|-----|----------|----------|
| `auto` | Any | Any | Detected automatically | Most users (recommended) |
| `high` | 4+ | 4GB+ | All features, aggressive settings | High-end systems |
| `medium` | 2+ | 2GB+ | Balanced performance | Mid-range systems |
| `low` | 1+ | <2GB | Conservative, lazy loading | Low-end systems |

### Advanced Configuration

For detailed configuration options, see [`config-enhanced.zsh`](config-enhanced.zsh) which includes:

- Component-specific settings
- Custom key bindings
- Theme integration
- Performance tuning
- Memory optimization

## 📊 Performance

### Benchmarks

Run the included performance test:

```bash
# Run performance benchmark
./performance-test.zsh
```

### Typical Performance Metrics

| System Type | Startup Time | Memory Usage | Functions Loaded |
|-------------|--------------|--------------|------------------|
| High-end | ~15ms | 2-3MB | 150+ |
| Mid-range | ~25ms | 1-2MB | 120+ |
| Low-end | ~40ms | <1MB | 80+ |

### Memory Testing

```bash
# Run memory usage test
./test-memory.zsh
```

## 🔧 Components

### 1. Autosuggestions

- **Source**: Based on [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- **Features**: History-based suggestions, configurable highlighting
- **Configuration**: Customizable suggestion strategies

### 2. Syntax Highlighting

- **Source**: Based on [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- **Features**: Real-time syntax highlighting, multiple highlighters
- **Highlighters**: Main, brackets, pattern, regexp, cursor, line, root

### 3. Autocomplete

- **Source**: Based on [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
- **Features**: Enhanced tab completion, fuzzy matching
- **Configuration**: Smart completion behavior

### 4. History Substring Search

- **Source**: Based on [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- **Features**: Navigate history with Up/Down arrows using substring matching
- **Keybindings**: Customizable key bindings

## 🎮 Usage

### Key Bindings

| Key | Action |
|-----|--------|
| `→` or `Ctrl+F` | Accept autosuggestion |
| `Alt+F` | Accept next word of suggestion |
| `↑` | History substring search (up) |
| `↓` | History substring search (down) |
| `Tab` | Enhanced completion |
| `Ctrl+R` | Fuzzy history search |

### Commands

```bash
# Check plugin status
zsh-plugins-status

# Show performance info
zsh-plugins-info

# Reload plugins
zsh-plugins-reload

# Debug mode toggle
zsh-plugins-debug

# Cache management
zsh-plugins-cache-clear
```

## 🐛 Troubleshooting

### Common Issues

1. **Slow startup times**

   ```bash
   export ZSH_PLUGINS_PERFORMANCE_MODE=low
   export ZSH_PLUGINS_LAZY_LOAD=true
   ```

2. **Memory issues**

   ```bash
   export ZSH_PLUGINS_PERFORMANCE_MODE=low
   export ZSH_PLUGINS_ASYNC_LOAD=false
   ```

3. **Debugging problems**

   ```bash
   export ZSH_PLUGINS_DEBUG=true
   source ~/.zshrc
   ```

### Debug Mode

Enable comprehensive debugging:

```bash
export ZSH_PLUGINS_DEBUG=true
export ZSH_PLUGINS_SHOW_PROGRESS=true
source ~/.zshrc
```

## 📁 Project Structure

```
zsh-plugins/
├── zsh-plugins.plugin.zsh      # Main plugin file
├── config-enhanced.zsh         # Advanced configuration examples
├── performance-test.zsh        # Performance benchmarking
├── test-memory.zsh            # Memory usage testing
├── README.md                  # This file
├── LICENSE                    # MIT License
├── autocomplete/              # Autocomplete component
│   ├── zsh-autocomplete.plugin.zsh
│   ├── Functions/
│   └── Completions/
├── autosuggestions/           # Autosuggestions component
│   ├── autosuggestions.zsh
│   └── src/
├── history-substring-search/  # History search component
│   ├── history-substring-search.plugin.zsh
│   └── history-substring-search.zsh
└── syntax-highlighting/       # Syntax highlighting component
    ├── syntax-highlighting.plugin
    ├── syntax-highlighting.zsh
    ├── highlighters/
    └── docs/
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test with `./performance-test.zsh`
5. Commit: `git commit -am 'Add feature'`
6. Push: `git push origin feature-name`
7. Submit a pull request

### Development Guidelines

- Follow existing code style
- Test on multiple systems
- Document configuration options
- Maintain performance benchmarks
- Update README for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This project combines and enhances several excellent ZSH plugins:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) by Eric Freese
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) by ZSH Users
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) by Marlon Richert
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) by ZSH Users

## 📈 Roadmap

- [ ] Plugin manager integration (Antigen, Antibody, Zinit)
- [ ] Theme compatibility testing
- [ ] Configuration GUI
- [ ] Cloud sync for settings
- [ ] AI-powered suggestions
- [ ] Custom completion generators

## 📞 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/mohdismailmatasin/zsh-plugins/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/mohdismailmatasin/zsh-plugins/discussions)
- 📧 **Email**: <mohdismailmatasin@gmail.com>

---

<div align="center">

**[⬆ Back to Top](#zsh-plugins-v20)**

Made with ❤️ for the ZSH community

</div>
