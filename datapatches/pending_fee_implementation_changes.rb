#Check before if any students missing in prod
#Also check given students shouldn't have any invoices currently in system
first_name = ["Ayansh","Jainik","Swarna","Aayansh","Pratima","V. Viraj","Astha","Sheikh","Garv R","Rudra","Kavya","Rishit","Anay Kumar","Naksh","Bhavyansh","Swara","Giyana","Pratik","Varun","Chirag","Adrit","Lukesh Kumar","Aman Kumar","Kavya","Aradhya Giri","Tejas","Y. Sai","Diksha","Sanhavi","Reyansh","Lovina","V. Vedansh","Sonali","Purvi","Rajan","Priya","Tusharika","Lavany","Aryan","Vedika","Bhoumik","Deena","Udhyam","Vedant","Aadarsh","Saransh","Harshita","Gaargi","Shushant","Nidhi","Humza","Shourya","Bhumika","Chirag","Hanshika","Chahak","Shraddha","Tanish","Gaurav Singh","Daksh Singh","Prakhar","Rachna","Vivaan","Gulshan Kumar","Arun Kumar","Khushi","Rachit","Himanshi Chetan","Aarav","Kritika","Aditya","Deepak","Kamini","Devkumar","Ankita","Jayanti Singh","Rounak","Namrata","Tuleshwar","Kavya","Kumari Viya","Bantu Uttej","Gitika Mukesh","Hosanna","Mohini","Khilesh","Abhay Singh","Mansi","Sudarsen","Arya","Pavitra","Ruchika","Sithlesh","Rudra","Preeti"]
last_name = ["Verma","Meshram","Agarwal","Milan","Singh","","Tandi","Mahenoor","Sahu","Vaishnav","Kumari","Baral","Jagne","Sahu","Sharma","","Sahu","Sahu","Dewangan","Banjare","Sarkar","Sahu","Singh","Kaushal","Goswami","Agrawal","Loukya","Gajraj","Pandey","Dewangan","Koshale","","Kumbhar","Parihar","Kumar","Sahu","Sahu","Mandal","Tiwari","Verma","Sonwani","Nishad","Mishra","Mate","Kumar","Kurve","Gupta","Arya","Pandey","Gaure","Ali","Patle","Sahu","Ukey","Barle","Dewangan","Tandekar","Debnath","Kushwaha","Rana","Bansal","Kumari","Shrivastava","Sahu","Yadav","Yadav","Gupta","Khanwani","Kumar","Mankar","Nandeshwar","Sagar","Sahu","Verma","Singh","Saini","Gajraj","Barle","Nirmalkar","Mishra","Goswami","Kumar","Wadhwani","John","Turakne","Yadav","Rana","Tiwari","Sahu","Dahate","Tiwari","Nandeshwar","Yadav","Singh","Puri"]
grade = ["Playgroup","Nursery","Nursery","Nursery","Nursery","Nursery","Nursery","Nursery","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-1","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","PP-2","1","1","1","1","1","1","1","1","2","2","2","2","2","2","2","2","2","2","2","2","2","2","2","3","3","3","4","4","4","4","4","4","4","4","4","5","5","5","5","5","5","5","5","5","5","5","5","6","6","6","6","6","6","7","7","7","8","8","9","9","10","10","11"]
from = ["08","12","12","12","10","10","12","11","09","12","11","09","12","08","11","11","12","11","12","12","11","11","11","10","11","12","11","08","12","12","09","11","09","12","12","12","08","12","11","08","12","12","12","12","11","11","12","12","11","11","08","12","11","11","11","11","11","12","12","12","12","12","11","12","11","12","10","12","11","11","12","10","12","12","12","11","07","11","08","12","11","11","11","09","11","11","12","11","11","11","11","12","11","12","11"]
same_name_stu = []
updated = []
student_nt_found = []
first_name.each_with_index do |fn, id|
  if last_name[id].present?
    stu = Student.where(first_name: fn, last_name: last_name[id],grade: grade[id])
  else
    stu = Student.where(first_name: fn, grade: grade[id])
  end
  if stu.present?
    if stu.count > 1
      same_name_stu << stu.map { |x| x.id }
      next
    else
      st = stu.first
      inv = Invoice.create!(total: 0, user_id: 1, payment_mode: 'Online',student_id: st.id, class_no: st.grade, status: 'Paid', month_from: '2022-01', month_to: '2022-'.concat((from[id].to_i-1).to_s.rjust(2,"0")), notes: 'Dummy invoice for pending_fee logic')
      updated << st.id
    end
  else
    student_nt_found << fn
  end
end

done = []
Student.where(id: updated, fee_pending: true).each do |stu|
  fee = stu.pending_fees
  fee["2023"] = ["01"]
  stu.pending_fees = fee
  stu.save(validate: false)
  done << stu.id
end


#Check in prod -> [Aarav Gupta]