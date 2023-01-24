##Script to update all inv discarded_by by picking the whoddunit from Inv versions after adding invoice
arr = []
Invoice.all.discarded.where(discarded_by: nil).each do |inv|
  inv.versions.each do |ver|
    if ver.created_at.to_i == inv.discarded_at.to_i
      inv.discarded_by = ver.whodunnit
      inv.save!
      arr << [inv.id,ver.whodunnit]
    end
  end
end