# config/initializers/delayed_job_config.rb
# Для того что бы упавшую задачу было видно в интерфейсе DJ_Mon, мы не удаляем ее из очереди
Delayed::Worker.destroy_failed_jobs = true

Delayed::Worker.sleep_delay = 1
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 25.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.delay_jobs = !Rails.env.test?