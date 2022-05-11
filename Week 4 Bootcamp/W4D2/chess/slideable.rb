module Slideable #??? where
    def moves
        if move_dirs == 0 #horizontal only
            return horizontal_dirs
        elsif move_dirs == 1 #diagonal only
            return diagonal_dirs
        else
            return horizontal_dirs + diagonal_dirs
        end
    end

    def horizontal_dirs
        #return @HORIZONTAL_DIRS if @HORIZONTAL_DIRS != nil
        ans = []
        x,y = @pos
        i = x - 1
        while i >= 0
            if board[[i,y]].empty?
                ans << [i,y]
            else
                if board[[i,y]].color != self.color
                    ans << [i,y]
                end
                break

            end
            i -= 1
        end
        i = x+1
        while(i<8)
            if board[[i,y]].empty?
                ans << [i,y]
            else
                if board[[i,y]].color != self.color
                    ans << [i,y]
                end
                break
            end
            i += 1
        end

        j = y - 1
        while j >= 0
            if board[[x,j]].empty?
                ans << [x,j]
            else
                if board[[x,j]].color != self.color
                    ans << [x,j]
                end
                break
            end
            j -= 1
        end

        j = y + 1
        while j < 8
            if board[[x,j]].empty?
                ans << [x,j]
            else
                if board[[x,j]].color != self.color
                    ans << [x,j]
                end
                break
            end
            j += 1
        end
        #@HORIZONTAL_DIRS = ans
        return ans
    end

    def diagonal_dirs
        #return @DIAGONAL_DIRS if @DIAGONAL_DIRS != nil
        ans = []
        x,y = @pos
        i = x - 1
        j = y - 1
        while(i>=0 && j >= 0)
            if board[[i,j]].empty?
                ans << [i,j]
            else
                if board[[i,j]].color != self.color
                    ans << [i,j]
                end
                break
            end
            i -= 1
            j -= 1
        end

        i = x + 1
        j = y - 1
        while(i<8&& j >= 0)
            if board[[i,j]].empty?
                ans << [i,j]
            else
                if board[[i,j]].color != self.color
                    ans << [i,j]
                end
                break
            end
            i += 1
            j -= 1
        end

        i = x - 1
        j = y + 1
        while(i>=0&& j < 8)
            if board[[i,j]].empty?
                ans << [i,j]
            else
                if board[[i,j]].color != self.color
                    ans << [i,j]
                end
                break
            end
            i -= 1
            j += 1
        end

        i = x + 1
        j = y + 1
        while(i<8&& j < 8)
            if board[[i,j]].empty?
                ans << [i,j]
            else
                if board[[i,j]].color != self.color
                    ans << [i,j]
                end
                break
            end
            i += 1
            j += 1
        end
        #@DIAGONAL_DIRS = ans
        return ans
    end

    private
    def move_dirs
        #should be overwritten
    end

    #@HORIZONTAL_DIRS = nil
    #@DIAGONAL_DIRS = nil
end
