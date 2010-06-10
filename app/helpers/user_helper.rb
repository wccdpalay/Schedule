module UserHelper

  def to_block(arr)
    str = ""
    if arr.length == 0
      str += "Nothing"
    end
    for block in arr
      str += "From #{ALL_TIMES[block[0]]} to #{ALL_TIMES[block[1]]} <br />"
    end
    str
  end
end
