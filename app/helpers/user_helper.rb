module UserHelper

  def to_block(arr)
    str = ""
    if arr.length == 0
      str += "Nothing"
    end
    for block in arr
      unless block.nil?
        if block.empty?
          str += "Nothing"
        else
          unless (block[0].nil? || block[1].nil?)
            str += "From #{ALL_TIMES[block[0]+1]} to #{ALL_TIMES[block[1]+2]} <br />"
          end
        end
      end
    end
    str
  end
end
