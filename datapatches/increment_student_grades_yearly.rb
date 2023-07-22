start_dt = Time.zone.parse("01-05-2023")
end_dt = Time.zone.now
update_grades = {    
    "Nursery" => "PP-1",
    "PP-1" => "PP-2",
    "PP-2" => "1",
    "1" => "2",
    "2" => "3",
    "3" => "4",
    "4" => "5",
    "5" => "6",
    "6" => "7",
    "7" => "8",
    "8" => "9",
    "9" => "10",
    "10" => "11",
    "11" => "12"
}
stats = {}
ids = Hash.new { |h, k| h[k] = [] }
arr = update_grades.keys.reverse
begin
    arr.each do |key|
        students = Student.where.not(created_at: start_dt .. end_dt).where(grade: key.to_s).kept
        stats.merge!(key => students.count)
        updated = []
        students.each do |x| 
            x.update_column(:grade, update_grades[key.to_s])
            ids[key] << x.id
            updated << x.id
        end
        puts "Total #{updated.count} students updated for class #{key} to #{update_grades[key.to_s]}"
        puts "------------------ Next -------------- -----"
    end
rescue StandardError => e
   puts e.message
ensure
    puts "Completed with update. Here are is the data"
    puts "Updated students - #{stats}"
    puts "Updated students ids - #{ids}"
end

# arr.each do |key|
#     students = Student.where.not(created_at: start_dt .. end_dt).where(grade: key.to_s).kept
#     stats.merge!(key => students.count)
#     students.map { |x| x.update!(grade: update_grades[key.to_s]) }
#     ids.merge!(key => students.pluck(:id))
#     puts "Total #{students.count} students updated for class #{key} to #{update_grades[key.to_s]}"
#     puts "------------------ Next -------------- -----"
# end
# puts "Completed with update. Here are is the data"
# puts "Updated students - #{stats}"
# puts "Updated students ids - #{ids}"
 ----------------------------------------------------------- $$$$ -----------------------------------

 # Output
# irb(main):411:0>
# irb(main):412:0> start_dt = Time.zone.parse("01-05-2023")
# nd_dt ==> Mon, 01 May 2023 00:00:00 IST +05:30
# irb(main):413:0> end_dt = Time.zone.now
# => Sat, 22 Jul 2023 03:57:14 IST +05:30
# irb(main):414:0> update_grades = {
# irb(main):415:1*     "Nursery" => "PP-1",
# irb(main):416:1*     "PP-1" => "PP-2",
# irb(main):417:1*     "PP-2" => "1",
# irb(main):418:1*     "1" => "2",
# irb(main):419:1*     "2" => "3",
# irb(main):420:1*     "3" => "4",
# irb(main):421:1*     "4" => "5",
# irb(main):422:1*     "5" => "6",
# irb(main):423:1*     "6" => "7",
# irb(main):424:1*     "7" => "8",
# irb(main):425:1*     "8" => "9",
# irb(main):426:1*     "9" => "10",
# irb(main):427:1*     "10" => "11",
# irb(main):428:1*     "11" => "12"
# irb(main):429:1> }
# => {"Nursery"=>"PP-1", "PP-1"=>"PP-2", "PP-2"=>"1", "1"=>"2", "2"=>"3", "3"=>"4", "4"=>"5", "5"=>"6", "6"=>"7", "7"=>"8", "8"=>"9", "9"=>"10", "10"=>"11", "11"=>"12"}
# irb(main):430:0> stats = {}
# => {}
# irb(main):431:0> ids = Hash.new { |h, k| h[k] = [] }
# => {}
# irb(main):432:0> arr = update_grades.keys.reverse
# => ["11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "PP-2", "PP-1", "Nursery"]
# irb(main):433:0> begin
# irb(main):434:1>     arr.each do |key|
# irb(main):435:2*         students = Student.where.not(created_at: start_dt .. end_dt).where(grade: key.to_s).kept
#  e
#    puts e.message
# ensure
#     puts "Completed with update. Here are is the data"
#     puts "Updated students - #{stats}"
#     puts "Updated students ids - #{ids}"
# end

# # arr.each do |key|
# #     students = Student.where.not(created_at: start_dt .. end_dt).where(grade: key.to_s).kept
# #     stats.merge!(key => students.count)
# #     students.map { |x| x.update!(grade: update_grades[key.to_s]) }
# #     ids.merge!(key => students.pluck(:id))
# #     puts "Totirb(main):436:2>         stats.merge!(key => students.count)
# al #{students.count} students updated for class #{key} to #{update_grades[key.to_s]}"
# #     puts "------------------ Next -------------- -----"
# # end
# # puts "Completed with update. Here are is the data"
# # puts "Updated students - #{stats}"
# # puts "Updated students ids - #{ids}"irb(main):437:2>         updated = []
# irb(main):438:2>         students.each do |x|
# irb(main):439:3*             x.update_column(:grade, update_grades[key.to_s])
# irb(main):440:3>             ids[key] << x.id
# irb(main):441:3>             updated << x.id
# irb(main):442:3>         end
# irb(main):443:2>         puts "Total #{updated.count} students updated for class #{key} to #{update_grades[key.to_s]}"
# irb(main):444:2>         puts "------------------ Next -------------- -----"
# irb(main):445:2>     end
# irb(main):446:1> rescue StandardError => e
# irb(main):447:1>    puts e.message
# irb(main):448:1> ensure
# irb(main):449:1*     puts "Completed with update. Here are is the data"
# irb(main):450:1>     puts "Updated students - #{stats}"
# irb(main):451:1>     puts "Updated students ids - #{ids}"
# irb(main):452:1> end
# D, [2023-07-21T22:27:15.140155 #4275] DEBUG -- :    (1.1ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "11"]]
# D, [2023-07-21T22:27:15.141199 #4275] DEBUG -- :   Student Load (0.6ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "11"]]
# D, [2023-07-21T22:27:15.143149 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "12"], ["id", 563]]
# D, [2023-07-21T22:27:15.144843 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "12"], ["id", 561]]
# D, [2023-07-21T22:27:15.146318 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "12"], ["id", 559]]
# D, [2023-07-21T22:27:15.147862 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "12"], ["id", 562]]
# D, [2023-07-21T22:27:15.149264 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "12"], ["id", 560]]
# Total 5 students updated for class 11 to 12
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.151442 #4275] DEBUG -- :    (0.8ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "10"]]
# D, [2023-07-21T22:27:15.152528 #4275] DEBUG -- :   Student Load (0.6ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "10"]]
# D, [2023-07-21T22:27:15.154389 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 554]]
# D, [2023-07-21T22:27:15.155841 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 558]]
# D, [2023-07-21T22:27:15.157315 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 553]]
# D, [2023-07-21T22:27:15.158753 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 555]]
# D, [2023-07-21T22:27:15.160193 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 556]]
# D, [2023-07-21T22:27:15.161650 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "11"], ["id", 557]]
# Total 6 students updated for class 10 to 11
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.163637 #4275] DEBUG -- :    (0.8ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "9"]]
# D, [2023-07-21T22:27:15.164710 #4275] DEBUG -- :   Student Load (0.7ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "9"]]
# D, [2023-07-21T22:27:15.166808 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 549]]
# D, [2023-07-21T22:27:15.168269 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 548]]
# D, [2023-07-21T22:27:15.169583 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 551]]
# D, [2023-07-21T22:27:15.171051 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 537]]
# D, [2023-07-21T22:27:15.172416 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 541]]
# D, [2023-07-21T22:27:15.173844 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 540]]
# D, [2023-07-21T22:27:15.175280 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 539]]
# D, [2023-07-21T22:27:15.176623 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 546]]
# D, [2023-07-21T22:27:15.178076 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 543]]
# D, [2023-07-21T22:27:15.179615 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 536]]
# D, [2023-07-21T22:27:15.181219 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 538]]
# D, [2023-07-21T22:27:15.182643 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 550]]
# D, [2023-07-21T22:27:15.184022 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 545]]
# D, [2023-07-21T22:27:15.185457 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 621]]
# D, [2023-07-21T22:27:15.187083 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 542]]
# D, [2023-07-21T22:27:15.188556 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 547]]
# D, [2023-07-21T22:27:15.190006 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "10"], ["id", 544]]
# Total 17 students updated for class 9 to 10
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.192550 #4275] DEBUG -- :    (1.4ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "8"]]
# D, [2023-07-21T22:27:15.193849 #4275] DEBUG -- :   Student Load (0.9ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "8"]]
# D, [2023-07-21T22:27:15.196015 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 516]]
# D, [2023-07-21T22:27:15.197401 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 513]]
# D, [2023-07-21T22:27:15.198769 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 533]]
# D, [2023-07-21T22:27:15.200098 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 530]]
# D, [2023-07-21T22:27:15.201445 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 529]]
# D, [2023-07-21T22:27:15.202837 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 511]]
# D, [2023-07-21T22:27:15.204227 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 519]]
# D, [2023-07-21T22:27:15.205624 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 515]]
# D, [2023-07-21T22:27:15.207012 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 520]]
# D, [2023-07-21T22:27:15.208365 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 528]]
# D, [2023-07-21T22:27:15.209748 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 523]]
# D, [2023-07-21T22:27:15.211055 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 517]]
# D, [2023-07-21T22:27:15.212423 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 532]]
# D, [2023-07-21T22:27:15.213806 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 522]]
# D, [2023-07-21T22:27:15.215173 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 510]]
# D, [2023-07-21T22:27:15.216552 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 527]]
# D, [2023-07-21T22:27:15.217942 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 524]]
# D, [2023-07-21T22:27:15.219425 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 512]]
# D, [2023-07-21T22:27:15.220871 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 535]]
# D, [2023-07-21T22:27:15.222257 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 518]]
# D, [2023-07-21T22:27:15.223592 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "9"], ["id", 514]]
# Total 21 students updated for class 8 to 9
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.225590 #4275] DEBUG -- :    (0.9ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "7"]]
# D, [2023-07-21T22:27:15.278168 #4275] DEBUG -- :   Student Load (52.1ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "7"]]
# D, [2023-07-21T22:27:15.281315 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 485]]
# D, [2023-07-21T22:27:15.282711 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 484]]
# D, [2023-07-21T22:27:15.284206 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 496]]
# D, [2023-07-21T22:27:15.285632 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 463]]
# D, [2023-07-21T22:27:15.287072 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 461]]
# D, [2023-07-21T22:27:15.288595 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 492]]
# D, [2023-07-21T22:27:15.290031 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 476]]
# D, [2023-07-21T22:27:15.291742 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 458]]
# D, [2023-07-21T22:27:15.293079 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 460]]
# D, [2023-07-21T22:27:15.294536 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 500]]
# D, [2023-07-21T22:27:15.296169 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 456]]
# D, [2023-07-21T22:27:15.297508 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 478]]
# D, [2023-07-21T22:27:15.298872 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 472]]
# D, [2023-07-21T22:27:15.300336 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 487]]
# D, [2023-07-21T22:27:15.301778 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 494]]
# D, [2023-07-21T22:27:15.303166 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 489]]
# D, [2023-07-21T22:27:15.304515 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 457]]
# D, [2023-07-21T22:27:15.305888 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 469]]
# D, [2023-07-21T22:27:15.307201 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 504]]
# D, [2023-07-21T22:27:15.308678 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 508]]
# D, [2023-07-21T22:27:15.309988 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 509]]
# D, [2023-07-21T22:27:15.311410 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 488]]
# D, [2023-07-21T22:27:15.312747 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 468]]
# D, [2023-07-21T22:27:15.314110 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 454]]
# D, [2023-07-21T22:27:15.315430 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 498]]
# D, [2023-07-21T22:27:15.316838 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 453]]
# D, [2023-07-21T22:27:15.318166 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 502]]
# D, [2023-07-21T22:27:15.319538 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 467]]
# D, [2023-07-21T22:27:15.321090 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 474]]
# D, [2023-07-21T22:27:15.322735 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 473]]
# D, [2023-07-21T22:27:15.324319 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 506]]
# D, [2023-07-21T22:27:15.325936 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 455]]
# D, [2023-07-21T22:27:15.327476 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 466]]
# D, [2023-07-21T22:27:15.328888 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 501]]
# D, [2023-07-21T22:27:15.378316 #4275] DEBUG -- :   Student Update (49.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 465]]
# D, [2023-07-21T22:27:15.380111 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 479]]
# D, [2023-07-21T22:27:15.381541 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 503]]
# D, [2023-07-21T22:27:15.383093 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 486]]
# D, [2023-07-21T22:27:15.384641 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 481]]
# D, [2023-07-21T22:27:15.386093 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 477]]
# D, [2023-07-21T22:27:15.387657 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 462]]
# D, [2023-07-21T22:27:15.389079 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 499]]
# D, [2023-07-21T22:27:15.390607 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 491]]
# D, [2023-07-21T22:27:15.392073 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 470]]
# D, [2023-07-21T22:27:15.393511 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 495]]
# D, [2023-07-21T22:27:15.394996 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 480]]
# D, [2023-07-21T22:27:15.396474 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 483]]
# D, [2023-07-21T22:27:15.397886 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "8"], ["id", 490]]
# Total 48 students updated for class 7 to 8
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.399923 #4275] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "6"]]
# D, [2023-07-21T22:27:15.401086 #4275] DEBUG -- :   Student Load (0.8ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "6"]]
# D, [2023-07-21T22:27:15.403472 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 442]]
# D, [2023-07-21T22:27:15.404859 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 430]]
# D, [2023-07-21T22:27:15.406271 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 423]]
# D, [2023-07-21T22:27:15.407701 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 426]]
# D, [2023-07-21T22:27:15.409018 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 422]]
# D, [2023-07-21T22:27:15.410340 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 419]]
# D, [2023-07-21T22:27:15.411780 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 452]]
# D, [2023-07-21T22:27:15.413056 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 449]]
# D, [2023-07-21T22:27:15.414369 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 448]]
# D, [2023-07-21T22:27:15.415706 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 424]]
# D, [2023-07-21T22:27:15.417080 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 427]]
# D, [2023-07-21T22:27:15.418460 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 421]]
# D, [2023-07-21T22:27:15.419957 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 420]]
# D, [2023-07-21T22:27:15.421389 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 451]]
# D, [2023-07-21T22:27:15.422762 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 441]]
# D, [2023-07-21T22:27:15.424122 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 438]]
# D, [2023-07-21T22:27:15.425545 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 450]]
# D, [2023-07-21T22:27:15.426867 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 436]]
# D, [2023-07-21T22:27:15.428396 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 416]]
# D, [2023-07-21T22:27:15.429861 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 437]]
# D, [2023-07-21T22:27:15.431244 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 417]]
# D, [2023-07-21T22:27:15.477414 #4275] DEBUG -- :   Student Update (45.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 418]]
# D, [2023-07-21T22:27:15.479429 #4275] DEBUG -- :   Student Update (1.4ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 433]]
# D, [2023-07-21T22:27:15.480847 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 434]]
# D, [2023-07-21T22:27:15.482256 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 444]]
# D, [2023-07-21T22:27:15.483604 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 428]]
# D, [2023-07-21T22:27:15.484878 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 432]]
# D, [2023-07-21T22:27:15.486270 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 440]]
# D, [2023-07-21T22:27:15.487636 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 443]]
# D, [2023-07-21T22:27:15.488984 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 435]]
# D, [2023-07-21T22:27:15.490356 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 439]]
# D, [2023-07-21T22:27:15.491773 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 425]]
# D, [2023-07-21T22:27:15.493322 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "7"], ["id", 429]]
# Total 33 students updated for class 6 to 7
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.495486 #4275] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "5"]]
# D, [2023-07-21T22:27:15.496784 #4275] DEBUG -- :   Student Load (0.9ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "5"]]
# D, [2023-07-21T22:27:15.499563 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 371]]
# D, [2023-07-21T22:27:15.500924 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 365]]
# D, [2023-07-21T22:27:15.502328 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 378]]
# D, [2023-07-21T22:27:15.503753 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 387]]
# D, [2023-07-21T22:27:15.505107 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 368]]
# D, [2023-07-21T22:27:15.506420 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 377]]
# D, [2023-07-21T22:27:15.507776 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 385]]
# D, [2023-07-21T22:27:15.509066 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 384]]
# D, [2023-07-21T22:27:15.510477 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 369]]
# D, [2023-07-21T22:27:15.511941 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 379]]
# D, [2023-07-21T22:27:15.513301 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 366]]
# D, [2023-07-21T22:27:15.514804 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 375]]
# D, [2023-07-21T22:27:15.516149 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 415]]
# D, [2023-07-21T22:27:15.517472 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 370]]
# D, [2023-07-21T22:27:15.518918 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 393]]
# D, [2023-07-21T22:27:15.520458 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 394]]
# D, [2023-07-21T22:27:15.521867 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 404]]
# D, [2023-07-21T22:27:15.523219 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 399]]
# D, [2023-07-21T22:27:15.524640 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 400]]
# D, [2023-07-21T22:27:15.526067 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 397]]
# D, [2023-07-21T22:27:15.578301 #4275] DEBUG -- :   Student Update (51.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 401]]
# D, [2023-07-21T22:27:15.580011 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 403]]
# D, [2023-07-21T22:27:15.581487 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 391]]
# D, [2023-07-21T22:27:15.583184 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 405]]
# D, [2023-07-21T22:27:15.584785 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 395]]
# D, [2023-07-21T22:27:15.586341 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 414]]
# D, [2023-07-21T22:27:15.587904 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 411]]
# D, [2023-07-21T22:27:15.589434 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 410]]
# D, [2023-07-21T22:27:15.590964 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 409]]
# D, [2023-07-21T22:27:15.592629 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 408]]
# D, [2023-07-21T22:27:15.594020 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 413]]
# D, [2023-07-21T22:27:15.595426 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 372]]
# D, [2023-07-21T22:27:15.596764 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 386]]
# D, [2023-07-21T22:27:15.598160 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 396]]
# D, [2023-07-21T22:27:15.599470 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 412]]
# D, [2023-07-21T22:27:15.600838 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 398]]
# D, [2023-07-21T22:27:15.602141 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 367]]
# D, [2023-07-21T22:27:15.603431 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 407]]
# D, [2023-07-21T22:27:15.604677 #4275] DEBUG -- :   Student Update (0.9ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 389]]
# D, [2023-07-21T22:27:15.606050 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 406]]
# D, [2023-07-21T22:27:15.607426 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 381]]
# D, [2023-07-21T22:27:15.608987 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 388]]
# D, [2023-07-21T22:27:15.610310 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 374]]
# D, [2023-07-21T22:27:15.611642 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 376]]
# D, [2023-07-21T22:27:15.613041 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 383]]
# D, [2023-07-21T22:27:15.614330 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "6"], ["id", 382]]
# Total 46 students updated for class 5 to 6
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.616236 #4275] DEBUG -- :    (0.9ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "4"]]
# D, [2023-07-21T22:27:15.617549 #4275] DEBUG -- :   Student Load (0.9ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "4"]]
# D, [2023-07-21T22:27:15.620627 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 337]]
# D, [2023-07-21T22:27:15.621965 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 332]]
# D, [2023-07-21T22:27:15.623280 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 352]]
# D, [2023-07-21T22:27:15.624665 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 333]]
# D, [2023-07-21T22:27:15.626027 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 312]]
# D, [2023-07-21T22:27:15.627562 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 315]]
# D, [2023-07-21T22:27:15.628945 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 329]]
# D, [2023-07-21T22:27:15.630268 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 328]]
# D, [2023-07-21T22:27:15.677479 #4275] DEBUG -- :   Student Update (46.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 307]]
# D, [2023-07-21T22:27:15.679338 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 340]]
# D, [2023-07-21T22:27:15.680748 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 296]]
# D, [2023-07-21T22:27:15.682080 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 313]]
# D, [2023-07-21T22:27:15.683499 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 325]]
# D, [2023-07-21T22:27:15.684779 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 321]]
# D, [2023-07-21T22:27:15.686199 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 322]]
# D, [2023-07-21T22:27:15.687805 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 331]]
# D, [2023-07-21T22:27:15.689099 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 298]]
# D, [2023-07-21T22:27:15.690408 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 359]]
# D, [2023-07-21T22:27:15.691898 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 336]]
# D, [2023-07-21T22:27:15.693265 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 354]]
# D, [2023-07-21T22:27:15.694609 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 344]]
# D, [2023-07-21T22:27:15.696046 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 308]]
# D, [2023-07-21T22:27:15.697421 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 347]]
# D, [2023-07-21T22:27:15.698909 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 314]]
# D, [2023-07-21T22:27:15.700384 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 318]]
# D, [2023-07-21T22:27:15.701889 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 316]]
# D, [2023-07-21T22:27:15.703397 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 319]]
# D, [2023-07-21T22:27:15.704871 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 351]]
# D, [2023-07-21T22:27:15.706253 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 302]]
# D, [2023-07-21T22:27:15.707608 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 303]]
# D, [2023-07-21T22:27:15.708985 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 363]]
# D, [2023-07-21T22:27:15.710405 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 309]]
# D, [2023-07-21T22:27:15.711731 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 335]]
# D, [2023-07-21T22:27:15.713049 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 338]]
# D, [2023-07-21T22:27:15.714364 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 339]]
# D, [2023-07-21T22:27:15.715782 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 334]]
# D, [2023-07-21T22:27:15.717133 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 350]]
# D, [2023-07-21T22:27:15.718559 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 353]]
# D, [2023-07-21T22:27:15.719930 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 358]]
# D, [2023-07-21T22:27:15.721394 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 356]]
# D, [2023-07-21T22:27:15.722831 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 341]]
# D, [2023-07-21T22:27:15.724290 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 346]]
# D, [2023-07-21T22:27:15.725585 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 348]]
# D, [2023-07-21T22:27:15.726921 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 311]]
# D, [2023-07-21T22:27:15.728223 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 345]]
# D, [2023-07-21T22:27:15.729565 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 323]]
# D, [2023-07-21T22:27:15.731050 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 317]]
# D, [2023-07-21T22:27:15.777395 #4275] DEBUG -- :   Student Update (45.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 361]]
# D, [2023-07-21T22:27:15.779180 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 357]]
# D, [2023-07-21T22:27:15.780659 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 362]]
# D, [2023-07-21T22:27:15.782190 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 355]]
# D, [2023-07-21T22:27:15.783543 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 304]]
# D, [2023-07-21T22:27:15.784959 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 349]]
# D, [2023-07-21T22:27:15.786509 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 320]]
# D, [2023-07-21T22:27:15.788056 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 305]]
# D, [2023-07-21T22:27:15.789616 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 342]]
# D, [2023-07-21T22:27:15.791205 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 613]]
# D, [2023-07-21T22:27:15.792779 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 326]]
# D, [2023-07-21T22:27:15.794158 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 300]]
# D, [2023-07-21T22:27:15.795643 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 324]]
# D, [2023-07-21T22:27:15.797011 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 327]]
# D, [2023-07-21T22:27:15.798357 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 360]]
# D, [2023-07-21T22:27:15.799716 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "5"], ["id", 330]]
# Total 63 students updated for class 4 to 5
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.801784 #4275] DEBUG -- :    (0.9ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "3"]]
# D, [2023-07-21T22:27:15.803313 #4275] DEBUG -- :   Student Load (1.1ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "3"]]
# D, [2023-07-21T22:27:15.807252 #4275] DEBUG -- :   Student Update (1.4ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 274]]
# D, [2023-07-21T22:27:15.808958 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 244]]
# D, [2023-07-21T22:27:15.810573 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 236]]
# D, [2023-07-21T22:27:15.812046 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 265]]
# D, [2023-07-21T22:27:15.813445 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 268]]
# D, [2023-07-21T22:27:15.814829 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 250]]
# D, [2023-07-21T22:27:15.816259 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 254]]
# D, [2023-07-21T22:27:15.817733 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 251]]
# D, [2023-07-21T22:27:15.819407 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 273]]
# D, [2023-07-21T22:27:15.820841 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 253]]
# D, [2023-07-21T22:27:15.822354 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 238]]
# D, [2023-07-21T22:27:15.823947 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 233]]
# D, [2023-07-21T22:27:15.825605 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 232]]
# D, [2023-07-21T22:27:15.827150 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 276]]
# D, [2023-07-21T22:27:15.828567 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 262]]
# D, [2023-07-21T22:27:15.830116 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 240]]
# D, [2023-07-21T22:27:15.877533 #4275] DEBUG -- :   Student Update (47.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 282]]
# D, [2023-07-21T22:27:15.879825 #4275] DEBUG -- :   Student Update (1.5ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 292]]
# D, [2023-07-21T22:27:15.881554 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 295]]
# D, [2023-07-21T22:27:15.883224 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 277]]
# D, [2023-07-21T22:27:15.884786 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 284]]
# D, [2023-07-21T22:27:15.886425 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 285]]
# D, [2023-07-21T22:27:15.888020 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 275]]
# D, [2023-07-21T22:27:15.889552 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 288]]
# D, [2023-07-21T22:27:15.891178 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 286]]
# D, [2023-07-21T22:27:15.892732 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 230]]
# D, [2023-07-21T22:27:15.894385 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 239]]
# D, [2023-07-21T22:27:15.895992 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 243]]
# D, [2023-07-21T22:27:15.897411 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 269]]
# D, [2023-07-21T22:27:15.898812 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 237]]
# D, [2023-07-21T22:27:15.900166 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 227]]
# D, [2023-07-21T22:27:15.901525 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 266]]
# D, [2023-07-21T22:27:15.903200 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 267]]
# D, [2023-07-21T22:27:15.904659 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 270]]
# D, [2023-07-21T22:27:15.906196 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 287]]
# D, [2023-07-21T22:27:15.907709 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 280]]
# D, [2023-07-21T22:27:15.909241 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 247]]
# D, [2023-07-21T22:27:15.910774 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 263]]
# D, [2023-07-21T22:27:15.912425 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 264]]
# D, [2023-07-21T22:27:15.914268 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 259]]
# D, [2023-07-21T22:27:15.915855 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 294]]
# D, [2023-07-21T22:27:15.917501 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 241]]
# D, [2023-07-21T22:27:15.919327 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 229]]
# D, [2023-07-21T22:27:15.920950 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 290]]
# D, [2023-07-21T22:27:15.922550 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 279]]
# D, [2023-07-21T22:27:15.924455 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 260]]
# D, [2023-07-21T22:27:15.926342 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 289]]
# D, [2023-07-21T22:27:15.928116 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 248]]
# D, [2023-07-21T22:27:15.929941 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 256]]
# D, [2023-07-21T22:27:15.931648 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 258]]
# D, [2023-07-21T22:27:15.933417 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 281]]
# D, [2023-07-21T22:27:15.935122 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 261]]
# D, [2023-07-21T22:27:15.936676 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 252]]
# D, [2023-07-21T22:27:15.938088 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 291]]
# D, [2023-07-21T22:27:15.978349 #4275] DEBUG -- :   Student Update (39.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 293]]
# D, [2023-07-21T22:27:15.980221 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 231]]
# D, [2023-07-21T22:27:15.981982 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 228]]
# D, [2023-07-21T22:27:15.983679 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 235]]
# D, [2023-07-21T22:27:15.985252 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 245]]
# D, [2023-07-21T22:27:15.986841 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 242]]
# D, [2023-07-21T22:27:15.988394 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "4"], ["id", 249]]
# Total 61 students updated for class 3 to 4
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:15.990850 #4275] DEBUG -- :    (1.1ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "2"]]
# D, [2023-07-21T22:27:15.992413 #4275] DEBUG -- :   Student Load (1.0ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "2"]]
# D, [2023-07-21T22:27:15.996337 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 619]]
# D, [2023-07-21T22:27:15.997930 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 217]]
# D, [2023-07-21T22:27:15.999578 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 200]]
# D, [2023-07-21T22:27:16.001109 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 190]]
# D, [2023-07-21T22:27:16.002983 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 181]]
# D, [2023-07-21T22:27:16.004646 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 158]]
# D, [2023-07-21T22:27:16.006317 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 223]]
# D, [2023-07-21T22:27:16.008071 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 219]]
# D, [2023-07-21T22:27:16.009746 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 225]]
# D, [2023-07-21T22:27:16.011617 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 213]]
# D, [2023-07-21T22:27:16.013526 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 171]]
# D, [2023-07-21T22:27:16.015249 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 224]]
# D, [2023-07-21T22:27:16.017055 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 165]]
# D, [2023-07-21T22:27:16.019113 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 170]]
# D, [2023-07-21T22:27:16.020999 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 195]]
# D, [2023-07-21T22:27:16.022918 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 191]]
# D, [2023-07-21T22:27:16.024651 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 212]]
# D, [2023-07-21T22:27:16.026329 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 204]]
# D, [2023-07-21T22:27:16.028005 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 221]]
# D, [2023-07-21T22:27:16.029579 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 167]]
# D, [2023-07-21T22:27:16.031144 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 193]]
# D, [2023-07-21T22:27:16.032596 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 222]]
# D, [2023-07-21T22:27:16.034177 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 168]]
# D, [2023-07-21T22:27:16.035668 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 196]]
# D, [2023-07-21T22:27:16.037289 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 211]]
# D, [2023-07-21T22:27:16.077529 #4275] DEBUG -- :   Student Update (39.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 198]]
# D, [2023-07-21T22:27:16.079440 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 197]]
# D, [2023-07-21T22:27:16.080944 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 164]]
# D, [2023-07-21T22:27:16.082432 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 218]]
# D, [2023-07-21T22:27:16.083912 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 209]]
# D, [2023-07-21T22:27:16.085384 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 179]]
# D, [2023-07-21T22:27:16.086981 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 199]]
# D, [2023-07-21T22:27:16.088499 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 174]]
# D, [2023-07-21T22:27:16.089963 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 183]]
# D, [2023-07-21T22:27:16.091557 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 185]]
# D, [2023-07-21T22:27:16.093116 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 207]]
# D, [2023-07-21T22:27:16.094490 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 192]]
# D, [2023-07-21T22:27:16.096030 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 203]]
# D, [2023-07-21T22:27:16.097468 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 186]]
# D, [2023-07-21T22:27:16.099083 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 169]]
# D, [2023-07-21T22:27:16.100619 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 215]]
# D, [2023-07-21T22:27:16.102056 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 173]]
# D, [2023-07-21T22:27:16.103480 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 161]]
# D, [2023-07-21T22:27:16.105029 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 162]]
# D, [2023-07-21T22:27:16.106326 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 182]]
# D, [2023-07-21T22:27:16.107714 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 202]]
# D, [2023-07-21T22:27:16.109043 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 226]]
# D, [2023-07-21T22:27:16.110412 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 210]]
# D, [2023-07-21T22:27:16.111715 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 177]]
# D, [2023-07-21T22:27:16.113072 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 187]]
# D, [2023-07-21T22:27:16.114412 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 184]]
# D, [2023-07-21T22:27:16.115921 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 156]]
# D, [2023-07-21T22:27:16.117486 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 206]]
# D, [2023-07-21T22:27:16.118995 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 178]]
# D, [2023-07-21T22:27:16.120578 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 208]]
# D, [2023-07-21T22:27:16.122046 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 155]]
# D, [2023-07-21T22:27:16.123469 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 159]]
# D, [2023-07-21T22:27:16.124877 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 163]]
# D, [2023-07-21T22:27:16.126247 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 214]]
# D, [2023-07-21T22:27:16.127555 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 160]]
# D, [2023-07-21T22:27:16.128964 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 194]]
# D, [2023-07-21T22:27:16.130330 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 157]]
# D, [2023-07-21T22:27:16.131630 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 188]]
# D, [2023-07-21T22:27:16.177453 #4275] DEBUG -- :   Student Update (45.4ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 166]]
# D, [2023-07-21T22:27:16.179461 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 216]]
# D, [2023-07-21T22:27:16.180961 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 180]]
# D, [2023-07-21T22:27:16.182437 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "3"], ["id", 189]]
# Total 67 students updated for class 2 to 3
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:16.184474 #4275] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "1"]]
# D, [2023-07-21T22:27:16.185945 #4275] DEBUG -- :   Student Load (1.0ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "1"]]
# D, [2023-07-21T22:27:16.189622 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 591]]
# D, [2023-07-21T22:27:16.190991 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 135]]
# D, [2023-07-21T22:27:16.192363 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 117]]
# D, [2023-07-21T22:27:16.193671 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 143]]
# D, [2023-07-21T22:27:16.195152 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 594]]
# D, [2023-07-21T22:27:16.196408 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 597]]
# D, [2023-07-21T22:27:16.197763 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 127]]
# D, [2023-07-21T22:27:16.199058 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 589]]
# D, [2023-07-21T22:27:16.200417 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 606]]
# D, [2023-07-21T22:27:16.201838 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 103]]
# D, [2023-07-21T22:27:16.203151 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 95]]
# D, [2023-07-21T22:27:16.204481 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 107]]
# D, [2023-07-21T22:27:16.205842 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 121]]
# D, [2023-07-21T22:27:16.207236 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 140]]
# D, [2023-07-21T22:27:16.208614 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 116]]
# D, [2023-07-21T22:27:16.210149 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 144]]
# D, [2023-07-21T22:27:16.211446 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 98]]
# D, [2023-07-21T22:27:16.212669 #4275] DEBUG -- :   Student Update (0.9ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 100]]
# D, [2023-07-21T22:27:16.214054 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 93]]
# D, [2023-07-21T22:27:16.215446 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 126]]
# D, [2023-07-21T22:27:16.216897 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 115]]
# D, [2023-07-21T22:27:16.218280 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 123]]
# D, [2023-07-21T22:27:16.219720 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 122]]
# D, [2023-07-21T22:27:16.221238 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 119]]
# D, [2023-07-21T22:27:16.222655 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 588]]
# D, [2023-07-21T22:27:16.224047 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 94]]
# D, [2023-07-21T22:27:16.225467 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 102]]
# D, [2023-07-21T22:27:16.278384 #4275] DEBUG -- :   Student Update (52.5ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 108]]
# D, [2023-07-21T22:27:16.280155 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 106]]
# D, [2023-07-21T22:27:16.281750 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 595]]
# D, [2023-07-21T22:27:16.283270 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 105]]
# D, [2023-07-21T22:27:16.284618 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 104]]
# D, [2023-07-21T22:27:16.286015 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 582]]
# D, [2023-07-21T22:27:16.287421 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 598]]
# D, [2023-07-21T22:27:16.288767 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 592]]
# D, [2023-07-21T22:27:16.290153 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 600]]
# D, [2023-07-21T22:27:16.291580 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 590]]
# D, [2023-07-21T22:27:16.292939 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 596]]
# D, [2023-07-21T22:27:16.294383 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 581]]
# D, [2023-07-21T22:27:16.295764 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 601]]
# D, [2023-07-21T22:27:16.297141 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 136]]
# D, [2023-07-21T22:27:16.298540 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 114]]
# D, [2023-07-21T22:27:16.299870 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 142]]
# D, [2023-07-21T22:27:16.301199 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 603]]
# D, [2023-07-21T22:27:16.302547 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 141]]
# D, [2023-07-21T22:27:16.303848 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 607]]
# D, [2023-07-21T22:27:16.305149 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 109]]
# D, [2023-07-21T22:27:16.306491 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 111]]
# D, [2023-07-21T22:27:16.307874 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 604]]
# D, [2023-07-21T22:27:16.309210 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 112]]
# D, [2023-07-21T22:27:16.310657 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 124]]
# D, [2023-07-21T22:27:16.312041 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 605]]
# D, [2023-07-21T22:27:16.313453 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 118]]
# D, [2023-07-21T22:27:16.314817 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 128]]
# D, [2023-07-21T22:27:16.316089 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 120]]
# D, [2023-07-21T22:27:16.317325 #4275] DEBUG -- :   Student Update (0.9ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 139]]
# D, [2023-07-21T22:27:16.318764 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 137]]
# D, [2023-07-21T22:27:16.320098 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 113]]
# D, [2023-07-21T22:27:16.321387 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 99]]
# D, [2023-07-21T22:27:16.322875 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 134]]
# D, [2023-07-21T22:27:16.324228 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 110]]
# D, [2023-07-21T22:27:16.325549 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 132]]
# D, [2023-07-21T22:27:16.327002 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 131]]
# D, [2023-07-21T22:27:16.328315 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 129]]
# D, [2023-07-21T22:27:16.329606 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 586]]
# D, [2023-07-21T22:27:16.330942 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 585]]
# D, [2023-07-21T22:27:16.332232 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 138]]
# D, [2023-07-21T22:27:16.333558 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 96]]
# D, [2023-07-21T22:27:16.334806 #4275] DEBUG -- :   Student Update (0.9ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 130]]
# D, [2023-07-21T22:27:16.378317 #4275] DEBUG -- :   Student Update (43.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 125]]
# D, [2023-07-21T22:27:16.380111 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 602]]
# D, [2023-07-21T22:27:16.381509 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 133]]
# D, [2023-07-21T22:27:16.382828 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 593]]
# D, [2023-07-21T22:27:16.384161 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 617]]
# D, [2023-07-21T22:27:16.385499 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 615]]
# D, [2023-07-21T22:27:16.386976 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "2"], ["id", 101]]
# Total 76 students updated for class 1 to 2
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:16.388886 #4275] DEBUG -- :    (0.8ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "PP-2"]]
# D, [2023-07-21T22:27:16.390169 #4275] DEBUG -- :   Student Load (0.9ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "PP-2"]]
# D, [2023-07-21T22:27:16.394104 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 67]]
# D, [2023-07-21T22:27:16.395486 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 10]]
# D, [2023-07-21T22:27:16.396859 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 56]]
# D, [2023-07-21T22:27:16.398221 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 25]]
# D, [2023-07-21T22:27:16.399682 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 87]]
# D, [2023-07-21T22:27:16.401034 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 86]]
# D, [2023-07-21T22:27:16.402344 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 61]]
# D, [2023-07-21T22:27:16.403784 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 79]]
# D, [2023-07-21T22:27:16.405135 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 22]]
# D, [2023-07-21T22:27:16.406548 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 29]]
# D, [2023-07-21T22:27:16.407858 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 45]]
# D, [2023-07-21T22:27:16.409223 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 39]]
# D, [2023-07-21T22:27:16.410595 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 63]]
# D, [2023-07-21T22:27:16.411924 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 32]]
# D, [2023-07-21T22:27:16.413291 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 60]]
# D, [2023-07-21T22:27:16.414684 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 69]]
# D, [2023-07-21T22:27:16.416054 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 62]]
# D, [2023-07-21T22:27:16.417339 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 7]]
# D, [2023-07-21T22:27:16.418829 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 46]]
# D, [2023-07-21T22:27:16.420224 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 40]]
# D, [2023-07-21T22:27:16.421606 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 41]]
# D, [2023-07-21T22:27:16.423050 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 42]]
# D, [2023-07-21T22:27:16.424444 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 85]]
# D, [2023-07-21T22:27:16.425896 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 47]]
# D, [2023-07-21T22:27:16.427222 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 55]]
# D, [2023-07-21T22:27:16.428615 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 90]]
# D, [2023-07-21T22:27:16.429972 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 81]]
# D, [2023-07-21T22:27:16.431285 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 59]]
# D, [2023-07-21T22:27:16.432601 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 78]]
# D, [2023-07-21T22:27:16.433971 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 58]]
# D, [2023-07-21T22:27:16.477432 #4275] DEBUG -- :   Student Update (43.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 83]]
# D, [2023-07-21T22:27:16.479419 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 614]]
# D, [2023-07-21T22:27:16.480822 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 5]]
# D, [2023-07-21T22:27:16.482320 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 82]]
# D, [2023-07-21T22:27:16.483822 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 608]]
# D, [2023-07-21T22:27:16.485422 #4275] DEBUG -- :   Student Update (1.3ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 27]]
# D, [2023-07-21T22:27:16.487107 #4275] DEBUG -- :   Student Update (1.4ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 19]]
# D, [2023-07-21T22:27:16.488665 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 4]]
# D, [2023-07-21T22:27:16.490213 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 35]]
# D, [2023-07-21T22:27:16.491662 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 57]]
# D, [2023-07-21T22:27:16.493092 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 609]]
# D, [2023-07-21T22:27:16.494440 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 71]]
# D, [2023-07-21T22:27:16.495873 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 618]]
# D, [2023-07-21T22:27:16.497136 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 28]]
# D, [2023-07-21T22:27:16.498498 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 50]]
# D, [2023-07-21T22:27:16.499895 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 21]]
# D, [2023-07-21T22:27:16.501183 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 92]]
# D, [2023-07-21T22:27:16.502659 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 17]]
# D, [2023-07-21T22:27:16.504053 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 620]]
# D, [2023-07-21T22:27:16.505556 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 611]]
# D, [2023-07-21T22:27:16.506957 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 72]]
# D, [2023-07-21T22:27:16.508278 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 38]]
# D, [2023-07-21T22:27:16.509663 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 612]]
# D, [2023-07-21T22:27:16.511062 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 18]]
# D, [2023-07-21T22:27:16.512411 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 622]]
# D, [2023-07-21T22:27:16.513939 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 91]]
# D, [2023-07-21T22:27:16.515239 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 77]]
# D, [2023-07-21T22:27:16.577439 #4275] DEBUG -- :   Student Update (61.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 31]]
# D, [2023-07-21T22:27:16.579237 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 52]]
# D, [2023-07-21T22:27:16.580677 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 616]]
# D, [2023-07-21T22:27:16.582013 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 76]]
# D, [2023-07-21T22:27:16.583545 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 23]]
# D, [2023-07-21T22:27:16.584951 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 16]]
# D, [2023-07-21T22:27:16.586280 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 1]]
# D, [2023-07-21T22:27:16.587591 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 2]]
# D, [2023-07-21T22:27:16.588992 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 11]]
# D, [2023-07-21T22:27:16.590376 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 3]]
# D, [2023-07-21T22:27:16.591764 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 24]]
# D, [2023-07-21T22:27:16.593159 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 30]]
# D, [2023-07-21T22:27:16.594545 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 14]]
# D, [2023-07-21T22:27:16.595895 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 34]]
# D, [2023-07-21T22:27:16.597208 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 6]]
# D, [2023-07-21T22:27:16.598621 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 20]]
# D, [2023-07-21T22:27:16.600035 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 74]]
# D, [2023-07-21T22:27:16.601426 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 13]]
# D, [2023-07-21T22:27:16.602866 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 15]]
# D, [2023-07-21T22:27:16.604341 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 73]]
# D, [2023-07-21T22:27:16.605766 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 26]]
# D, [2023-07-21T22:27:16.607338 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 64]]
# D, [2023-07-21T22:27:16.608674 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 84]]
# D, [2023-07-21T22:27:16.610144 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 88]]
# D, [2023-07-21T22:27:16.611614 #4275] DEBUG -- :   Student Update (1.2ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 36]]
# D, [2023-07-21T22:27:16.612915 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 44]]
# D, [2023-07-21T22:27:16.614300 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 51]]
# D, [2023-07-21T22:27:16.615569 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 8]]
# D, [2023-07-21T22:27:16.616857 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 37]]
# D, [2023-07-21T22:27:16.618444 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 49]]
# D, [2023-07-21T22:27:16.619867 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 53]]
# D, [2023-07-21T22:27:16.621267 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 43]]
# D, [2023-07-21T22:27:16.622666 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 54]]
# D, [2023-07-21T22:27:16.623955 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 9]]
# D, [2023-07-21T22:27:16.625310 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 68]]
# D, [2023-07-21T22:27:16.626683 #4275] DEBUG -- :   Student Update (1.1ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 65]]
# D, [2023-07-21T22:27:16.628052 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 66]]
# D, [2023-07-21T22:27:16.629335 #4275] DEBUG -- :   Student Update (1.0ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 75]]
# D, [2023-07-21T22:27:16.677487 #4275] DEBUG -- :   Student Update (47.8ms)  UPDATE "students" SET "grade" = $1 WHERE "students"."id" = $2  [["grade", "1"], ["id", 89]]
# Total 96 students updated for class PP-2 to 1
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:16.680072 #4275] DEBUG -- :    (1.2ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "PP-1"]]
# D, [2023-07-21T22:27:16.681157 #4275] DEBUG -- :   Student Load (0.7ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "PP-1"]]
# Total 0 students updated for class PP-1 to PP-2
# ------------------ Next -------------- -----
# D, [2023-07-21T22:27:16.683157 #4275] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "Nursery"]]
# D, [2023-07-21T22:27:16.684195 #4275] DEBUG -- :   Student Load (0.7ms)  SELECT "students".* FROM "students" WHERE NOT ("students"."created_at" BETWEEN $1 AND $2) AND "students"."grade" = $3 AND "students"."discarded_at" IS NULL  [["created_at", "2023-04-30 18:30:00"], ["created_at", "2023-07-21 22:27:14.941834"], ["grade", "Nursery"]]
# Total 0 students updated for class Nursery to PP-1
# ------------------ Next -------------- -----
# Completed with update. Here are is the data
# Updated students - {"11"=>5, "10"=>6, "9"=>17, "8"=>21, "7"=>48, "6"=>33, "5"=>46, "4"=>63, "3"=>61, "2"=>67, "1"=>76, "PP-2"=>96, "PP-1"=>0, "Nursery"=>0}
# Updated students ids - {"11"=>[563, 561, 559, 562, 560], "10"=>[554, 558, 553, 555, 556, 557], "9"=>[549, 548, 551, 537, 541, 540, 539, 546, 543, 536, 538, 550, 545, 621, 542, 547, 544], "8"=>[516, 513, 533, 530, 529, 511, 519, 515, 520, 528, 523, 517, 532, 522, 510, 527, 524, 512, 535, 518, 514], "7"=>[485, 484, 496, 463, 461, 492, 476, 458, 460, 500, 456, 478, 472, 487, 494, 489, 457, 469, 504, 508, 509, 488, 468, 454, 498, 453, 502, 467, 474, 473, 506, 455, 466, 501, 465, 479, 503, 486, 481, 477, 462, 499, 491, 470, 495, 480, 483, 490], "6"=>[442, 430, 423, 426, 422, 419, 452, 449, 448, 424, 427, 421, 420, 451, 441, 438, 450, 436, 416, 437, 417, 418, 433, 434, 444, 428, 432, 440, 443, 435, 439, 425, 429], "5"=>[371, 365, 378, 387, 368, 377, 385, 384, 369, 379, 366, 375, 415, 370, 393, 394, 404, 399, 400, 397, 401, 403, 391, 405, 395, 414, 411, 410, 409, 408, 413, 372, 386, 396, 412, 398, 367, 407, 389, 406, 381, 388, 374, 376, 383, 382], "4"=>[337, 332, 352, 333, 312, 315, 329, 328, 307, 340, 296, 313, 325, 321, 322, 331, 298, 359, 336, 354, 344, 308, 347, 314, 318, 316, 319, 351, 302, 303, 363, 309, 335, 338, 339, 334, 350, 353, 358, 356, 341, 346, 348, 311, 345, 323, 317, 361, 357, 362, 355, 304, 349, 320, 305, 342, 613, 326, 300, 324, 327, 360, 330], "3"=>[274, 244, 236, 265, 268, 250, 254, 251, 273, 253, 238, 233, 232, 276, 262, 240, 282, 292, 295, 277, 284, 285, 275, 288, 286, 230, 239, 243, 269, 237, 227, 266, 267, 270, 287, 280, 247, 263, 264, 259, 294, 241, 229, 290, 279, 260, 289, 248, 256, 258, 281, 261, 252, 291, 293, 231, 228, 235, 245, 242, 249], "2"=>[619, 217, 200, 190, 181, 158, 223, 219, 225, 213, 171, 224, 165, 170, 195, 191, 212, 204, 221, 167, 193, 222, 168, 196, 211, 198, 197, 164, 218, 209, 179, 199, 174, 183, 185, 207, 192, 203, 186, 169, 215, 173, 161, 162, 182, 202, 226, 210, 177, 187, 184, 156, 206, 178, 208, 155, 159, 163, 214, 160, 194, 157, 188, 166, 216, 180, 189], "1"=>[591, 135, 117, 143, 594, 597, 127, 589, 606, 103, 95, 107, 121, 140, 116, 144, 98, 100, 93, 126, 115, 123, 122, 119, 588, 94, 102, 108, 106, 595, 105, 104, 582, 598, 592, 600, 590, 596, 581, 601, 136, 114, 142, 603, 141, 607, 109, 111, 604, 112, 124, 605, 118, 128, 120, 139, 137, 113, 99, 134, 110, 132, 131, 129, 586, 585, 138, 96, 130, 125, 602, 133, 593, 617, 615, 101], "PP-2"=>[67, 10, 56, 25, 87, 86, 61, 79, 22, 29, 45, 39, 63, 32, 60, 69, 62, 7, 46, 40, 41, 42, 85, 47, 55, 90, 81, 59, 78, 58, 83, 614, 5, 82, 608, 27, 19, 4, 35, 57, 609, 71, 618, 28, 50, 21, 92, 17, 620, 611, 72, 38, 612, 18, 622, 91, 77, 31, 52, 616, 76, 23, 16, 1, 2, 11, 3, 24, 30, 14, 34, 6, 20, 74, 13, 15, 73, 26, 64, 84, 88, 36, 44, 51, 8, 37, 49, 53, 43, 54, 9, 68, 65, 66, 75, 89]}
# => ["11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "PP-2", "PP-1", "Nursery"]