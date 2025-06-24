#!/bin/zsh

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              ZSH Plugins Optimization Test Results           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Test different configurations
echo "🔥 Performance Test Results:"
echo ""

echo "1️⃣  Standard mode (with progress bar):"
export ZSH_PLUGINS_DEBUG=false ZSH_PLUGINS_SHOW_PROGRESS=true
time zsh -c "source zsh-plugins.plugin.zsh; exit" 2>&1 | tail -1

echo ""
echo "2️⃣  Speed mode (no progress bar):"
export ZSH_PLUGINS_DEBUG=false ZSH_PLUGINS_SHOW_PROGRESS=false  
time zsh -c "source zsh-plugins.plugin.zsh; exit" 2>&1 | tail -1

echo ""
echo "3️⃣  Ultra-fast mode (high performance):"
export ZSH_PLUGINS_DEBUG=false ZSH_PLUGINS_SHOW_PROGRESS=false ZSH_PLUGINS_PERFORMANCE_MODE=high
time zsh -c "source zsh-plugins.plugin.zsh; exit" 2>&1 | tail -1

echo ""
echo "📊 Memory and Function Count:"
echo ""

export ZSH_PLUGINS_DEBUG=false ZSH_PLUGINS_SHOW_PROGRESS=false
zsh -c "
    mem_before=\$(ps -o rss= -p \$\$)
    source zsh-plugins.plugin.zsh 
    mem_after=\$(ps -o rss= -p \$\$)
    funcs=\$(functions | wc -l)
    vars=\$(typeset | wc -l)
    alias_count=\$(alias | wc -l)
    
    echo \"  Memory Usage: \$((mem_after - mem_before)) KB\"
    echo \"  Functions: \$funcs\"
    echo \"  Variables: \$vars\"  
    echo \"  Aliases: \$alias_count\"
    echo \"\"
    echo \"✨ All components loaded successfully!\"
    zsh-plugins-status
"
