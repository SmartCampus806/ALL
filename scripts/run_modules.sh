docker run -d --name room_booking --network smart-campus -p 8000:8000 roombooking
docker run -d --name email-notification --network smart-campus email-notification
docker run -d --name frontend --network smart-campus -p 5173:5173 frontend
