d = Day.today
for x in 15..24 do
  slot = d.slotAs[x]
  slot.user_id = 63
  slot.save!
  slot = d.slotBs[x]
  slot.user_id = 63
  slot.save!
  slot = d.slotCs[x]
  slot.user_id = 63
  slot.save!
  slot = d.slotDs[x]
  slot.user_id = 63
  slot.save!
end
