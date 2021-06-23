require 'sqlite3'

$db
$runner_1 = ""
$runner_2 = ""
$runner_3 = ""
$runner_4 = ""
$time_stamps = []

class FtQueryController < ApplicationController
  def index
   
  end

  def create_db
    $db = SQLite3::Database.new "ft_sql.db"
    redirect_to '/'
  end

  def create_table
    clock_watch = $db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS clock_watch (
      ts_id INTEGER PRIMARY KEY AUTOINCREMENT,
      day INTEGER,
      month INTEGER,
      year INTEGER,
      hour INTEGER,
      min INTEGER,
      sec INTEGER,
      race INTEGER,
      name varchar(50) default 'anonymous',
      lap INTEGER
    );
    SQL
    race = $db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS race (
      r_id INTEGER PRIMARY KEY AUTOINCREMENT,
      start varchar(50)
    );
    SQL
    # $db.execute "INSERT INTO clock_watch VALUES(0, DATETIME('now'))"
    # $db.execute "INSERT INTO race VALUES(0, 'test start')"

    redirect_to '/'
  end

  # TODO: 테이블이 있다면, 지우기
  def drop_table
    query1 = "DROP TABLE IF EXISTS clock_watch;"
    query2 = "DROP TABLE IF EXISTS race;"
    $db.execute(query1)
    $db.execute(query2)
    redirect_to '/'
  end

  def start_race
    $runner_1 = params[:name_1]
    $runner_2 = params[:name_2]
    $runner_3 = params[:name_3]
    $runner_4 = params[:name_4]
    $runner_1 = 'anonymous' if $runner_1.empty?
    $runner_2 = 'anonymous' if $runner_2.empty?
    $runner_3 = 'anonymous' if $runner_3.empty?
    $runner_4 = 'anonymous' if $runner_4.empty?
    puts puts
    puts "------"
    puts "'#{$runner_1}', '#{$runner_2}', '#{$runner_3}', '#{$runner_4}'"
    @lap = 0
    @race = 0
    $time_stamps[@race] = Time.now
    clock_watch_query1 = "INSERT INTO clock_watch (day, month, year, hour, min, sec, race, name, lap) VALUES (#{$time_stamps.day}, #{$time_stamps.month}, #{$time_stamps.year}, #{$time_stamps.hour}, #{$time_stamps.min}, #{$time_stamps.sec}, #{@race}, \"#{$runner_1.to_s}\", #{@lap});"
    clock_watch_query2 = "INSERT INTO clock_watch (day, month, year, hour, min, sec, race, name, lap) VALUES (#{$time_stamps.day}, #{$time_stamps.month}, #{$time_stamps.year}, #{$time_stamps.hour}, #{$time_stamps.min}, #{$time_stamps.sec}, #{@race}, \"#{$runner_2.to_s}\", #{@lap});"
    clock_watch_query3 = "INSERT INTO clock_watch (day, month, year, hour, min, sec, race, name, lap) VALUES (#{$time_stamps.day}, #{$time_stamps.month}, #{$time_stamps.year}, #{$time_stamps.hour}, #{$time_stamps.min}, #{$time_stamps.sec}, #{@race}, \"#{$runner_3.to_s}\", #{@lap});"
    clock_watch_query4 = "INSERT INTO clock_watch (day, month, year, hour, min, sec, race, name, lap) VALUES (#{$time_stamps.day}, #{$time_stamps.month}, #{$time_stamps.year}, #{$time_stamps.hour}, #{$time_stamps.min}, #{$time_stamps.sec}, #{@race}, \"#{$runner_4.to_s}\", #{@lap});"
    race_query = "INSERT INTO race (start) VALUES (\"#{$time_stamps.to_s}\")"
    $db.execute(clock_watch_query1)
    $db.execute(clock_watch_query2)
    $db.execute(clock_watch_query3)
    $db.execute(clock_watch_query4)
    $db.execute(race_query)
    $runner_1 = ""
    $runner_2 = ""
    $runner_3 = ""
    $runner_4 = ""
    redirect_to '/'
  end

  def insert_time_stamp
    
  end

  def delete_last

  end

  def destroy_all
   
  end

  def all_by_name
 
  end

  def all_by_race
   
  end

  def update_time_stamp
  
  end

  private


end
