#Archive a given week
def archweek(w)
	#for each day of the week
		for day in w.days
			
		#for each slotA of day
			for slot in day.slotAs
				#archive
				archive(slot)
			end
			
		#for each slotB of day
			for slot in day.slotBs
				#archive
				archive(slot)
			end
			
		#for each slotC of day
			for slot in day.slotCs
				#archive
				archive(slot)
			end
			
		#for each slotD of day
			for slot in day.slotDs
				#archive
				archive(slot)
			end
			
		#archive day
		archive(day)
	end
	#archive week
	archive(w)
end

def archive(obj)
if obj.class == (SlotA || SlotB || SlotC || SlotD)
	oldobjclass = ArcSlot
else
	oldobjclass = eval('Arc'+obj.class.to_s)
end
newobj = oldobjclass.new(obj.attributes)
newobj.id = obj.id
newobj.save!
#obj.destroy
end
