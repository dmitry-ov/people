# config/initializers/delayed_job_config.rb
# Для того что бы упавшую задачу было видно в интерфейсе DJ_Mon, мы не удаляем ее из очереди
Delayed::Worker.destroy_failed_jobs = false

Delayed::Worker.sleep_delay = 1
Delayed::Worker.max_attempts = 5
Delayed::Worker.max_run_time = 15.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.delay_jobs = !Rails.env.test?