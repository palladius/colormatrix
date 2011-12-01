
   def fill(x, y, target_color, replacement_color)
        return unless self[y][x]	# valid point?

        return if self[y][x] != target_color
        return if self[y][x] == replacement_color

        (dump; sleep(0.2)) if @options[:animation]

        self[y][x] = replacement_color
        fill(x+1, y, target_color, replacement_color)
        fill(x-1, y, target_color, replacement_color)
        fill(x, y+1, target_color, replacement_color)
        fill(x, y-1, target_color, replacement_color)
    end

