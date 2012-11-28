namespace :passenger do 
	
	# desc "Setup Passenger"
	task :setup do
		run "gem install passenger"
	end
<<<<<<< HEAD
	# task :start do
	# 	run "passenger start"
	# end
	# task :stop do
	# 	run "passenger stop"
	# end
	# task :test do 
	# 	run "ls -a #{current_path}"
	# end
end      
=======
	
	task :start do
		run "cd #{current_path}" 
		run "passenger start -p 80"
	end
	
	task :stop do
		run "passenger stop"
	end
	
	task :showpath do 
		run "echo #{current_path}"
	end

end 
>>>>>>> f23d5fea36483fe90deaf4fbb6d1dfb438c8ad86
