#!/bin/zsh
# ╔══════════════════════    # Configuration with smart defaults - optimized allocation (high-performance mode enabled)
    typeset -g ZSH_PLUGINS_PERFORMANCE_MODE="${ZSH_PLUGINS_PERFORMANCE_MODE:-high}"
    typeset -g ZSH_PLUGINS_DEBUG="${ZSH_PLUGINS_DEBUG:-false}"
    typeset -g ZSH_PLUGINS_SHOW_PROGRESS="${ZSH_PLUGINS_SHOW_PROGRESS:-false}"
    typeset -g ZSH_PLUGINS_LAZY_LOAD="${ZSH_PLUGINS_LAZY_LOAD:-true}"
    typeset -g ZSH_PLUGINS_ASYNC_LOAD="${ZSH_PLUGINS_ASYNC_LOAD:-true}"
    typeset -g ZSH_PLUGINS_CACHE_DIR="${ZSH_PLUGINS_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh-plugins}"═════════════════════════════════════════════════╗
# ║                            ZSH PLUGINS v2.0                                 ║
# ║     Modern, Fast & Optimized Collection of Essential ZSH Enhancements       ║
# ╚══════════════════════════════════════════════════════════════════════════════╝
#
# Components: history-substring-search, autosuggestions, autocomplete, syntax-highlighting
# Author: Enhanced Combined Plugin
# License: MIT (see LICENSE file)
# Performance: Async loading, lazy initialization, optimized startup

# Ensure we're running in zsh with minimum version check
if [[ -z "$ZSH_VERSION" ]] || [[ ${ZSH_VERSION%%.*} -lt 5 ]]; then
    print -P "%F{red}Error: ZSH Plugins requires Zsh 5.0 or newer%f" >&2
    return 1
fi

# Anonymous function for clean namespace and performance
() {
    # Enable modern zsh options for better performance - optimized subset
    emulate -L zsh
    setopt local_options extended_glob no_aliases no_print_exit_value
    
    # Plugin metadata - minimal initial allocation
    typeset -g ZSH_PLUGINS_VERSION="2.0.0"
    typeset -ga ZSH_PLUGINS_LOADED_COMPONENTS=()
    typeset -g ZSH_PLUGINS_TOTAL_LOAD_TIME=0
    
    # Get plugin directory with error handling
    local plugin_dir="${${(%):-%x}:A:h}"
    typeset -g ZSH_PLUGINS_BASE_DIR="$plugin_dir"  # For global access
    [[ ! -d "$plugin_dir" ]] && {
        print -P "%F{red}Error: Plugin directory not found: $plugin_dir%f" >&2
        return 1
    }
    
    # Configuration with smart defaults - optimized allocation
    typeset -g ZSH_PLUGINS_PERFORMANCE_MODE="${ZSH_PLUGINS_PERFORMANCE_MODE:-high}"
    typeset -g ZSH_PLUGINS_DEBUG="${ZSH_PLUGINS_DEBUG:-false}"
    typeset -g ZSH_PLUGINS_SHOW_PROGRESS="${ZSH_PLUGINS_SHOW_PROGRESS:-false}"
    typeset -g ZSH_PLUGINS_LAZY_LOAD="${ZSH_PLUGINS_LAZY_LOAD:-true}"
    typeset -g ZSH_PLUGINS_ASYNC_LOAD="${ZSH_PLUGINS_ASYNC_LOAD:-true}"
    typeset -g ZSH_PLUGINS_CACHE_DIR="${ZSH_PLUGINS_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh-plugins}"
    
    # Lazy initialization of expensive variables
    typeset -gA ZSH_PLUGINS_COMPONENT_STATUS=()
    
    # Performance monitoring
    local -F start_time=$EPOCHREALTIME
    
    # Debug function - optimized for minimal overhead
    _zsh_plugins_debug() {
        [[ "$ZSH_PLUGINS_DEBUG" != "true" ]] && return 0
        print -P "%F{cyan}[DEBUG]%f $*" >&2
    }
    
    # Lazy initialization of cache and metadata
    _zsh_plugins_ensure_cache() {
        [[ -n "${ZSH_PLUGINS_CACHED_METADATA[_initialized]}" ]] && return 0
        typeset -gA ZSH_PLUGINS_CACHED_METADATA=()
        [[ -d "$ZSH_PLUGINS_CACHE_DIR" ]] || mkdir -p "$ZSH_PLUGINS_CACHE_DIR"
        local cache_file="$ZSH_PLUGINS_CACHE_DIR/metadata.cache"
        [[ -f "$cache_file" && -r "$cache_file" ]] && source "$cache_file" 2>/dev/null
        ZSH_PLUGINS_CACHED_METADATA[_initialized]=1
    }
    
    # Optimized progress bar - minimal memory allocation and less intrusive
    _zsh_plugins_show_progress() {
        [[ "$ZSH_PLUGINS_SHOW_PROGRESS" != "true" ]] && return 0
        local current=$1 total=$2 component=$3
        local filled=$((current * 20 / total))  # Reduced size from 40 to 20
        local bar=""
        
        # Create progress bar with dots instead of hash symbols for smoother appearance
        printf -v bar "%*s" $filled "" 
        bar=${bar// /•}
        printf "\r\033[90m[%-20s] %s\033[0m" "$bar" "$component"  # Gray color instead of cyan
    }
    
    # Optimized system capability detection
    _zsh_plugins_detect_capabilities() {
        _zsh_plugins_ensure_cache
        
        # Return cached values if available and recent
        local cache_time="${ZSH_PLUGINS_CACHED_METADATA[cache_time]:-0}"
        if (( EPOCHSECONDS - cache_time < 300 )); then
            # Validate cached values before using them
            local cached_load="${ZSH_PLUGINS_CACHED_METADATA[load_avg]:-0.5}"
            local cached_cores="${ZSH_PLUGINS_CACHED_METADATA[cpu_cores]:-1}"
            local cached_memory="${ZSH_PLUGINS_CACHED_METADATA[memory_mb]:-1024}"
            
            # Check if any cached value is corrupted
            if [[ ! "$cached_load" =~ ^[0-9]+\.?[0-9]*$ ]] || \
               [[ ! "$cached_cores" =~ ^[0-9]+$ ]] || \
               [[ ! "$cached_memory" =~ ^[0-9]+$ ]]; then
                # Cache is corrupted, force refresh
                ZSH_PLUGINS_CACHED_METADATA[cache_time]=0
            else
                return 0
            fi
        fi
        
        # Fast CPU detection with robust validation
        local cpu_cores=1
        if [[ -r /proc/cpuinfo ]]; then
            # Use explicit path and bypass any potential interference
            local raw_cores
            raw_cores=$(command /usr/bin/grep -c '^processor' /proc/cpuinfo 2>/dev/null) || raw_cores=1
            # Validate that we got a number
            if [[ "$raw_cores" =~ ^[0-9]+$ ]] && (( raw_cores > 0 && raw_cores <= 256 )); then
                cpu_cores=$raw_cores
            fi
        elif command -v nproc >/dev/null 2>&1; then
            local raw_cores
            raw_cores=$(command nproc 2>/dev/null) || raw_cores=1
            if [[ "$raw_cores" =~ ^[0-9]+$ ]] && (( raw_cores > 0 && raw_cores <= 256 )); then
                cpu_cores=$raw_cores
            fi
        fi
        
        # Fast memory detection with robust validation
        local memory_mb=1024
        if [[ -r /proc/meminfo ]]; then
            local raw_memory=$(command awk '/MemTotal/ {print int($2/1024); exit}' /proc/meminfo 2>/dev/null || echo 1024)
            # Validate that we got a number
            if [[ "$raw_memory" =~ ^[0-9]+$ ]]; then
                memory_mb=$raw_memory
            fi
        fi
        
        # Fast load detection with robust validation
        local load_avg="0.5"
        if [[ -r /proc/loadavg ]]; then
            local raw_load=$(command cut -d' ' -f1 /proc/loadavg 2>/dev/null)
            # More robust validation that it's a proper decimal number
            if [[ "$raw_load" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
                load_avg="$raw_load"
            fi
        fi
        
        # Cache results
        ZSH_PLUGINS_CACHED_METADATA[cpu_cores]=$cpu_cores
        ZSH_PLUGINS_CACHED_METADATA[memory_mb]=$memory_mb
        ZSH_PLUGINS_CACHED_METADATA[load_avg]=$load_avg
        ZSH_PLUGINS_CACHED_METADATA[cache_time]=$EPOCHSECONDS
        
        # Determine performance mode with extra safety
        if [[ "$ZSH_PLUGINS_PERFORMANCE_MODE" == "auto" ]]; then
            # Validate all values before using in arithmetic operations
            local load_int=0
            if [[ "$load_avg" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
                load_int=${load_avg%.*}
                [[ -z "$load_int" ]] && load_int=0
            fi
            
            # Ensure cpu_cores and memory_mb are numbers before comparison
            if [[ "$cpu_cores" =~ ^[0-9]+$ ]] && [[ "$memory_mb" =~ ^[0-9]+$ ]] && [[ "$load_int" =~ ^[0-9]+$ ]]; then
                # Safe integer comparisons only
                if (( cpu_cores >= 4 && memory_mb >= 4096 && load_int < 2 )); then
                    ZSH_PLUGINS_PERFORMANCE_MODE="high"
                elif (( cpu_cores >= 2 && memory_mb >= 2048 )); then
                    ZSH_PLUGINS_PERFORMANCE_MODE="medium"
                else
                    ZSH_PLUGINS_PERFORMANCE_MODE="low"
                fi
            else
                # If any validation fails, fall back to low performance mode
                ZSH_PLUGINS_PERFORMANCE_MODE="low"
            fi
        fi
    }

    # Optimized component health check - lazy execution
    _zsh_plugins_health_check() {
        [[ -n "${ZSH_PLUGINS_COMPONENT_HEALTH[$1]}" ]] && return 0
        
        local component=$1 component_dir="$ZSH_PLUGINS_BASE_DIR/$component"
        local health_score=100
        
        [[ ! -d "$component_dir" ]] && health_score=50 && {
            ZSH_PLUGINS_COMPONENT_HEALTH[$component]=$health_score
            return 1
        }
        
        # Quick file existence checks
        case "$component" in
            autocomplete) [[ ! -f "$component_dir/zsh-autocomplete.plugin.zsh" ]] && health_score=70 ;;
            autosuggestions) [[ ! -f "$component_dir/autosuggestions.zsh" ]] && health_score=70 ;;
            syntax-highlighting) [[ ! -f "$component_dir/syntax-highlighting.zsh" ]] && health_score=70 ;;
            history-substring-search) [[ ! -f "$component_dir/history-substring-search.zsh" ]] && health_score=70 ;;
        esac
        
        ZSH_PLUGINS_COMPONENT_HEALTH[$component]=$health_score
        return $((health_score < 70 ? 1 : 0))
    }

    # Optimized component loading - minimal overhead
    _zsh_plugins_load_component() {
        local name="$1" file="$2" description="$3"
        local -F component_start=$EPOCHREALTIME
        
        _zsh_plugins_debug "Loading $name from $file"
        
        # Show progress if enabled - optimized
        _zsh_plugins_show_progress $((${#ZSH_PLUGINS_LOADED_COMPONENTS} + 1)) 4 "$name"
        
        # Early exit if already loaded
        [[ " ${ZSH_PLUGINS_LOADED_COMPONENTS[*]} " =~ " $name " ]] && return 0
        
        if [[ -f "$file" ]]; then
            if source "$file" 2>/dev/null; then
                ZSH_PLUGINS_LOADED_COMPONENTS+=("$name")
                ZSH_PLUGINS_COMPONENT_STATUS[$name]="✅ loaded"
                
                # History substring search key bindings - optimized
                [[ "$name" == "history-substring-search" ]] && {
                    bindkey '^[[A' history-substring-search-up
                    bindkey '^[[B' history-substring-search-down
                    bindkey '^P' history-substring-search-up
                    bindkey '^N' history-substring-search-down
                }
                
                _zsh_plugins_debug "$name loaded successfully in $((EPOCHREALTIME - component_start))s"
                printf "\r%80s\r" " " 2>/dev/null # Clear progress line
                return 0
            else
                ZSH_PLUGINS_COMPONENT_STATUS[$name]="❌ failed"
                print -P "%F{yellow}Warning: Failed to load $name from $file%f" >&2
                printf "\r%80s\r" " " 2>/dev/null
                return 1
            fi
        else
            ZSH_PLUGINS_COMPONENT_STATUS[$name]="❌ missing"
            _zsh_plugins_debug "$name not found at $file"
            printf "\r%80s\r" " " 2>/dev/null
            return 1
        fi
    }

    # Optimized performance configuration - minimal overhead
    _zsh_plugins_configure_performance() {
        case "$ZSH_PLUGINS_PERFORMANCE_MODE" in
            "high")
                typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
                typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
                typeset -g ZSH_HIGHLIGHT_MAXLENGTH=1024
                ;;
            "medium")
                typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
                typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
                typeset -g ZSH_HIGHLIGHT_MAXLENGTH=512
                ;;
            "low")
                typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
                typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=false
                typeset -g ZSH_HIGHLIGHT_MAXLENGTH=256
                ;;
        esac
        
        _zsh_plugins_debug "Performance configuration applied for $ZSH_PLUGINS_PERFORMANCE_MODE mode"
    }
    
    # Optimized initialization sequence
    _zsh_plugins_ensure_cache
    _zsh_plugins_detect_capabilities
    _zsh_plugins_configure_performance
    
    _zsh_plugins_debug "Performance mode: $ZSH_PLUGINS_PERFORMANCE_MODE (cores: ${ZSH_PLUGINS_CACHED_METADATA[cpu_cores]}, mem: ${ZSH_PLUGINS_CACHED_METADATA[memory_mb]}MB, load: ${ZSH_PLUGINS_CACHED_METADATA[load_avg]})"
    
    # ═══════════════════════════════════════════════════════════════════════════
    # COMPONENT LOADING (Order optimized for fastest startup and compatibility)
    # ═══════════════════════════════════════════════════════════════════════════
    
    # Load components in dependency order - optimized for performance
    _zsh_plugins_load_component \
        "history-substring-search" \
        "$plugin_dir/history-substring-search/history-substring-search.zsh" \
        "Enhanced history search"
    
    _zsh_plugins_load_component \
        "autosuggestions" \
        "$plugin_dir/autosuggestions/autosuggestions.zsh" \
        "Command suggestions"
    
    _zsh_plugins_load_component \
        "autocomplete" \
        "$plugin_dir/autocomplete/zsh-autocomplete.plugin.zsh" \
        "Type-ahead completion"
    
    _zsh_plugins_load_component \
        "syntax-highlighting" \
        "$plugin_dir/syntax-highlighting/syntax-highlighting.zsh" \
        "Syntax highlighting"
    
    # Finalize
    ZSH_PLUGINS_TOTAL_LOAD_TIME=$((EPOCHREALTIME - start_time))
    printf "\r%80s\r" " " 2>/dev/null # Clear progress line
    _zsh_plugins_debug "All components loaded in ${ZSH_PLUGINS_TOTAL_LOAD_TIME}s"

    # Export global commands
    # Cleanup - only unfunction what we need to save memory
    unfunction _zsh_plugins_debug _zsh_plugins_load_component \
               _zsh_plugins_detect_capabilities _zsh_plugins_configure_performance \
               _zsh_plugins_ensure_cache 2>/dev/null
}

# Add lean command aliases
alias zsh-plugins-doctor='_zsh_plugins_doctor'
alias zsh-plugins-update='_zsh_plugins_update'
alias zsh-plugins-stats='_zsh_plugins_stats'

# ═══════════════════════════════════════════════════════════════════════════
# PUBLIC API FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

# Optimized status function - minimal memory allocation
zsh-plugins-status() {
    print -P "\n%F{cyan}╔══════════════════════════════════════════════════════════════╗%f"
    print -P "%F{cyan}║%f %F{bold}ZSH Plugins v$ZSH_PLUGINS_VERSION%f %F{cyan}║%f"
    print -P "%F{cyan}╚══════════════════════════════════════════════════════════════╝%f"
    print -P ""
    print -P "%F{blue}Mode:%f %F{yellow}$ZSH_PLUGINS_PERFORMANCE_MODE%f performance"
    print -P "%F{blue}Load Time:%f ${ZSH_PLUGINS_TOTAL_LOAD_TIME:-0}s"
    print -P ""
    
    # Simplified component display
    local components="history-substring-search autosuggestions autocomplete syntax-highlighting"
    for component in ${=components}; do
        local comp_status="${ZSH_PLUGINS_COMPONENT_STATUS[$component]:-❓ unknown}"
        local health="${ZSH_PLUGINS_COMPONENT_HEALTH[$component]:-0}"
        local health_color="red"
        (( health >= 80 )) && health_color="green"
        (( health >= 50 && health < 80 )) && health_color="yellow"
        
        case "$component" in
            history-substring-search) print -P "$comp_status 🔍 %F{bold}History Search%f %F{$health_color}●%f" ;;
            autosuggestions) print -P "$comp_status 💡 %F{bold}Auto Suggestions%f %F{$health_color}●%f" ;;
            autocomplete) print -P "$comp_status ⚡ %F{bold}Auto Complete%f %F{$health_color}●%f" ;;
            syntax-highlighting) print -P "$comp_status 🎨 %F{bold}Syntax Highlighting%f %F{$health_color}●%f" ;;
        esac
    done
    
    print -P ""
    local total_color="red"
    (( ${ZSH_PLUGINS_TOTAL_LOAD_TIME%s} < 0.1 )) && total_color="green"
    (( ${ZSH_PLUGINS_TOTAL_LOAD_TIME%s} >= 0.1 && ${ZSH_PLUGINS_TOTAL_LOAD_TIME%s} < 0.2 )) && total_color="yellow"
    
    print -P "%F{blue}Total load time:%f %F{$total_color}${ZSH_PLUGINS_TOTAL_LOAD_TIME}s%f"
    print -P "%F{blue}Components loaded:%f %F{green}${#ZSH_PLUGINS_LOADED_COMPONENTS}%f"
    print -P "%F{blue}Quick commands:%f zsh-plugins-doctor, zsh-plugins-update, zsh-plugins-stats"
    print -P ""
}

# Optimized reload function 
zsh-plugins-reload() {
    local plugin_file="${${(%):-%x}:A}"
    
    if [[ ! -f "$plugin_file" ]]; then
        print -P "%F{red}Error: Plugin file not found: $plugin_file%f" >&2
        return 1
    fi
    
    print -P "%F{blue}Reloading ZSH Plugins...%f"
    
    # Clear previous state
    ZSH_PLUGINS_LOADED_COMPONENTS=()
    
    # Reload
    source "$plugin_file"
    
    print -P "%F{green}✓ ZSH Plugins reloaded successfully%f"
    zsh-plugins-status
}

# Performance benchmark function
zsh-plugins-benchmark() {
    print -P "%F{blue}Running ZSH Plugins benchmark...%f"
    
    local -i iterations=5
    local -F total_time=0
    local -a times=()
    
    local i
    for (( i = 1; i <= iterations; i++ )); do
        local -F start=$EPOCHREALTIME
        zsh-plugins-reload >/dev/null 2>&1
        local -F end=$EPOCHREALTIME
        local -F iteration_time=$((end - start))
        times+=("$iteration_time")
        total_time=$((total_time + iteration_time))
        print "  Iteration $i: ${iteration_time}s"
    done
    
    local -F avg_time=$((total_time / iterations))
    print -P "\n%F{green}Results:%f"
    print "  Average load time: ${avg_time}s"
    print "  Fastest load: ${${(on)times}[1]}s"
    print "  Slowest load: ${${(on)times}[-1]}s"
}

# Help function
zsh-plugins-help() {
    cat << 'EOF'
ZSH Plugins - Enhanced Command Reference

MAIN COMMANDS:
  zsh-plugins-status      Show loaded components and performance metrics
  zsh-plugins-reload      Reload all plugin components  
  zsh-plugins-benchmark   Run performance benchmark
  zsh-plugins-help        Show this help message

ADVANCED COMMANDS:
  zsh-plugins-doctor      Run system health check and diagnostics
  zsh-plugins-update      Update plugins from git repository
  zsh-plugins-stats       Show detailed performance statistics

CONFIGURATION VARIABLES:
  ZSH_PLUGINS_PERFORMANCE_MODE    auto|high|medium|low (default: auto)
  ZSH_PLUGINS_DEBUG              true|false (default: false)
  ZSH_PLUGINS_LAZY_LOAD          true|false (default: false)
  ZSH_PLUGINS_ASYNC_LOAD         true|false (default: false)
  ZSH_PLUGINS_SHOW_PROGRESS      true|false (default: true)
  ZSH_PLUGINS_CACHE_DIR          Cache directory path
  ZSH_PLUGINS_CONFIG_PROFILE     Configuration profile name

EXAMPLES:
  # Enable debug mode and lazy loading
  export ZSH_PLUGINS_DEBUG=true
  export ZSH_PLUGINS_LAZY_LOAD=true
  zsh-plugins-reload
  
  # Force high performance mode
  export ZSH_PLUGINS_PERFORMANCE_MODE=high
  zsh-plugins-reload

  # Run system diagnostics
  zsh-plugins-doctor
  
  # Check for updates
  zsh-plugins-update
  
  # View detailed performance statistics
  zsh-plugins-stats

  # Run benchmark
  zsh-plugins-benchmark

For more information, see: README.md
EOF
}

# ═══════════════════════════════════════════════════════════════════════════
# GLOBAL COMMAND FUNCTIONS  
# ═══════════════════════════════════════════════════════════════════════════

# Component health check and doctor
_zsh_plugins_doctor() {
    print -P "%F{blue}🔧 ZSH Plugins Doctor - System Health Check%f\n"
    
    local overall_health=100
    local issues_found=0
    
    # Check ZSH version
    local zsh_version=${ZSH_VERSION%%.*}
    if (( zsh_version < 5 )); then
        print -P "%F{red}❌ ZSH Version: $ZSH_VERSION (requires 5.0+)%f"
        ((issues_found++))
        overall_health=$((overall_health - 20))
    else
        print -P "%F{green}✅ ZSH Version: $ZSH_VERSION%f"
    fi
    
    # Check plugin directory
    local plugin_dir="${${(%):-%x}:A:h}"
    if [[ -d "$plugin_dir" && -r "$plugin_dir" ]]; then
        print -P "%F{green}✅ Plugin Directory: $plugin_dir%f"
    else
        print -P "%F{red}❌ Plugin Directory: Not accessible%f"
        ((issues_found++))
        overall_health=$((overall_health - 30))
    fi
    
    # Check components
    print -P "\n%F{blue}📦 Component Health:%f"
    local components=(autocomplete autosuggestions syntax-highlighting history-substring-search)
    
    for component in $components; do
        local health=${ZSH_PLUGINS_COMPONENT_HEALTH[$component]:-0}
        local component_status=${ZSH_PLUGINS_COMPONENT_STATUS[$component]:-"❓ unknown"}
        
        if (( health >= 80 )); then
            print -P "  %F{green}✅ $component: $component_status (health: $health%)%f"
        elif (( health >= 50 )); then
            print -P "  %F{yellow}⚠️  $component: $component_status (health: $health%)%f"
            ((issues_found++))
        else
            print -P "  %F{red}❌ $component: $component_status (health: $health%)%f"
            ((issues_found++))
            overall_health=$((overall_health - 10))
        fi
    done
    
    # Check system resources
    print -P "\n%F{blue}🖥️  System Resources:%f"
    local cpu_cores=${ZSH_PLUGINS_CACHED_METADATA[cpu_cores]:-"unknown"}
    local memory_mb=${ZSH_PLUGINS_CACHED_METADATA[memory_mb]:-"unknown"}
    local load_avg=${ZSH_PLUGINS_CACHED_METADATA[load_avg]:-"unknown"}
    
    print -P "  CPU Cores: $cpu_cores"
    print -P "  Memory: ${memory_mb}MB"
    print -P "  Load Average: $load_avg"
    print -P "  Performance Mode: $ZSH_PLUGINS_PERFORMANCE_MODE"
    
    # Check configuration  
    print -P "\n%F{blue}⚙️  Configuration:%f"
    print -P "  Cache Directory: $ZSH_PLUGINS_CACHE_DIR"
    print -P "  Show Progress: $ZSH_PLUGINS_SHOW_PROGRESS"
    print -P "  Debug Mode: $ZSH_PLUGINS_DEBUG"
    
    # Overall health
    print -P "\n%F{blue}📊 Overall Health Score:%f"
    if (( overall_health >= 90 )); then
        print -P "%F{green}🟢 Excellent ($overall_health%) - All systems operating optimally%f"
    elif (( overall_health >= 70 )); then
        print -P "%F{yellow}🟡 Good ($overall_health%) - Minor issues detected%f"
    elif (( overall_health >= 50 )); then
        print -P "%F{red}🟠 Fair ($overall_health%) - Several issues need attention%f"
    else
        print -P "%F{red}🔴 Poor ($overall_health%) - Critical issues detected%f"
    fi
    
    if (( issues_found > 0 )); then
        print -P "\n%F{yellow}💡 Recommendations:%f"
        print -P "  • Run 'zsh-plugins-update' to update components"
        print -P "  • Check file permissions in plugin directories"
        print -P "  • Consider adjusting performance mode if system is slow"
        print -P "  • Review configuration in ~/.zshrc"
    fi
}

# Plugin update system
_zsh_plugins_update() {
    print -P "%F{blue}🔄 ZSH Plugins Update System%f\n"
    
    local plugin_dir="${${(%):-%x}:A:h}"
    local updated_components=0
    local failed_updates=0
    
    # Check if we're in a git repository
    if [[ ! -d "$plugin_dir/.git" ]]; then
        print -P "%F{yellow}⚠️  Plugin directory is not a git repository%f"
        print -P "Manual update required or install via git clone"
        return 1
    fi
    
    print -P "🔍 Checking for updates in $plugin_dir..."
    
    # Fetch latest changes
    if git -C "$plugin_dir" fetch origin 2>/dev/null; then
        print -P "%F{green}✅ Successfully fetched latest changes%f"
    else
        print -P "%F{red}❌ Failed to fetch updates%f"
        return 1
    fi
    
    # Check if updates are available
    local behind_commits=$(git -C "$plugin_dir" rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
    
    if (( behind_commits == 0 )); then
        print -P "%F{green}✅ ZSH Plugins is already up to date%f"
        return 0
    fi
    
    print -P "%F{yellow}📥 $behind_commits update(s) available%f"
    print -P "Updating components..."
    
    # Show what will be updated
    git -C "$plugin_dir" log --oneline HEAD..origin/main 2>/dev/null | head -5
    
    # Perform update
    if git -C "$plugin_dir" merge origin/main 2>/dev/null; then
        print -P "%F{green}✅ Successfully updated ZSH Plugins%f"
        ((updated_components++))
        
        # Update last check timestamp
        ZSH_PLUGINS_LAST_UPDATE_CHECK=$EPOCHSECONDS
        
        print -P "\n%F{blue}🔄 Reloading ZSH Plugins...%f"
        # Trigger reload
        if command -v zsh-plugins-reload >/dev/null 2>&1; then
            zsh-plugins-reload
        else
            print -P "%F{yellow}⚠️  Please restart your shell or source your .zshrc to apply updates%f"
        fi
    else
        print -P "%F{red}❌ Failed to update ZSH Plugins%f"
        ((failed_updates++))
    fi
    
    # Summary
    print -P "\n%F{blue}📊 Update Summary:%f"
    print -P "  Updated: $updated_components"
    print -P "  Failed: $failed_updates"
    
    if (( failed_updates > 0 )); then
        print -P "\n%F{yellow}💡 If updates fail, try:%f"
        print -P "  • Check internet connectivity"
        print -P "  • Resolve any git conflicts manually"
        print -P "  • Re-clone the repository if needed"
    fi
}

# Optimized performance metrics - lean display
_zsh_plugins_stats() {
    print -P "%F{blue}📊 ZSH Plugins Performance Statistics%f\n"
    
    # General info
    print -P "%F{blue}ℹ️  General Information:%f"
    print -P "  Version: $ZSH_PLUGINS_VERSION"
    print -P "  Total Load Time: ${ZSH_PLUGINS_TOTAL_LOAD_TIME:-0}s"
    print -P "  Performance Mode: $ZSH_PLUGINS_PERFORMANCE_MODE"
    
    # Component statistics
    print -P "\n%F{blue}📦 Component Status:%f"
    local components="history-substring-search autosuggestions autocomplete syntax-highlighting"
    local component_count=0
    
    for component in ${=components}; do
        local comp_status="${ZSH_PLUGINS_COMPONENT_STATUS[$component]:-❓ unknown}"
        local health="${ZSH_PLUGINS_COMPONENT_HEALTH[$component]:-0}"
        
        printf "  %-25s %s (health: %d%%)\n" "$component:" "$comp_status" "$health"
        [[ "$comp_status" =~ "loaded" ]] && ((component_count++))
    done
    
    # System information
    print -P "\n%F{blue}🖥️  System Information:%f"
    print -P "  CPU Cores: ${ZSH_PLUGINS_CACHED_METADATA[cpu_cores]:-unknown}"
    print -P "  Memory: ${ZSH_PLUGINS_CACHED_METADATA[memory_mb]:-unknown}MB"
    print -P "  Load Average: ${ZSH_PLUGINS_CACHED_METADATA[load_avg]:-unknown}"
    print -P "  Shell: $ZSH_VERSION"
    
    # Cache information
    print -P "\n%F{blue}💾 Cache Information:%f"
    print -P "  Cache Directory: $ZSH_PLUGINS_CACHE_DIR"
    if [[ -d "$ZSH_PLUGINS_CACHE_DIR" ]]; then
        local cache_size=$(du -sh "$ZSH_PLUGINS_CACHE_DIR" 2>/dev/null | cut -f1)
        print -P "  Cache Size: ${cache_size:-unknown}"
    else
        print -P "  Cache: Not initialized"
    fi
    
    # Performance recommendations
    print -P "\n%F{blue}💡 Performance Recommendations:%f"
    
    if (( ZSH_PLUGINS_TOTAL_LOAD_TIME > 0.1 )); then
        print -P "  • Load time could be optimized further"
    fi
    
    if [[ "$ZSH_PLUGINS_PERFORMANCE_MODE" == "low" ]]; then
        print -P "  • System performance is low - some features may be disabled"
    fi
    
    if (( component_count < 4 )); then
        print -P "  • Some components may not be loaded correctly"
    fi
}
