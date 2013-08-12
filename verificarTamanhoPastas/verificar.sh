du -k * | sort -nr | cut -f2 | xargs -d "\n" du -sh | head
