#!/bin/zsh

# Memory usage test for ZSH plugins
echo "Testing memory usage..."

# Get process memory before loading
pid_before=$$
mem_before=$(ps -o rss= -p $pid_before)

# Load plugins
source zsh-plugins.plugin.zsh

# Get memory after loading
mem_after=$(ps -o rss= -p $$)

echo "Memory usage:"
echo "  Before: ${mem_before} KB"
echo "  After:  ${mem_after} KB"
echo "  Diff:   $((mem_after - mem_before)) KB"

# Show ZSH statistics
echo ""
echo "ZSH Statistics:"
echo "  Functions: $(functions | wc -l)"
echo "  Variables: $(typeset | wc -l)" 
echo "  Aliases: $(alias | wc -l)"
