# jw — jj workspace wrapper that mimics worktrunk's post-start hooks
#
# Usage:
#   jw new <name> [rev]   Create a jj workspace, copy ignored files, mise trust
#   jw ls                 List jj workspaces
#   jw rm  <name>         Remove a jj workspace and its directory
#
# Why: jj has no native hook system for `workspace add`. This wraps it to
# replicate the worktrunk post-start chain (copy-ignored / env / mise trust)
# that the arena project relies on for fast cold starts.

jw() {
  local cmd="$1"

  case "$cmd" in
    new)
      local name="$2"
      local rev="${3:-trunk()}"

      if [[ -z "$name" ]]; then
        echo "usage: jw new <name> [rev]"
        return 1
      fi

      local root parent dest src_name
      root="$(jj workspace root 2>/dev/null)" || { echo "not in a jj repo"; return 1; }
      parent="$(dirname "$root")"
      dest="$parent/$name"
      src_name="$(basename "$root")"

      if [[ -e "$dest" ]]; then
        echo "destination exists: $dest"
        return 1
      fi

      jj workspace add "$dest" --name "$name" -r "$rev" || return 1
      cd "$dest" || return 1

      # post-start: copy gitignored files (node_modules, .next, .turbo, .env*, etc.)
      if command -v wt >/dev/null 2>&1; then
        wt step copy-ignored --from "$src_name" --to "$name" 2>/dev/null \
          || wt -C "$dest" step copy-ignored --from "$src_name" 2>/dev/null \
          || echo "warn: wt step copy-ignored failed — copy ignored files manually if needed"
      fi

      # post-start: env file
      local git_common
      git_common="$(git rev-parse --git-common-dir 2>/dev/null)"
      if [[ -n "$git_common" && -f "$git_common/../.env.local" ]]; then
        cp "$git_common/../.env.local" .env.current
      fi

      # post-start: mise trust
      command -v mise >/dev/null 2>&1 && mise trust >/dev/null 2>&1

      echo "✓ workspace '$name' ready at $dest"
      ;;

    ls|list)
      jj workspace list
      ;;

    rm|remove)
      local name="$2"
      if [[ -z "$name" ]]; then
        echo "usage: jw rm <name>"
        return 1
      fi

      local root parent
      root="$(jj workspace root 2>/dev/null)" || { echo "not in a jj repo"; return 1; }
      parent="$(dirname "$root")"

      if [[ "$(basename "$root")" == "$name" ]]; then
        echo "refusing to remove the current workspace — cd elsewhere first"
        return 1
      fi

      rm -rf "$parent/$name"
      jj workspace forget "$name"
      echo "✓ removed workspace '$name'"
      ;;

    ""|-h|--help|help)
      echo "usage: jw {new|ls|rm} <name> [rev]"
      echo "  new <name> [rev]   create workspace at ../<name>, default rev = trunk()"
      echo "  ls                 list workspaces"
      echo "  rm  <name>         remove workspace directory and forget it"
      ;;

    *)
      echo "jw: unknown command '$cmd'"
      echo "usage: jw {new|ls|rm} <name> [rev]"
      return 1
      ;;
  esac
}
