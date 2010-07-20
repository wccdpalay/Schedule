d = Date.today +1
d = Day.find_by_date d
as = d.slotAs
bs = d.slotBs
cs = d.slotCs
ds = d.slotDs

def is_blank(slot)
  slot.user_id == nil || slot.user_id == -1
end

for time in ALL_TIMES.index(START_TIME)..ALL_TIMES.index(END_TIME)
  if is_blank(as[time]) && is_blank(bs[time]) && is_blank(cs[time]) && is_blank(ds[time])
    #ALL BLANK!!!  #EMAIL DAN!
  end
end


