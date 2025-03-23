-- searching by city
SELECT * FROM hotel WHERE address LIKE '%Montreal%' OR address LIKE '%Ottawa%';

-- important details about ONLY hotel chains
SELECT HC_id, address, email, phone FROM hotel_chain

-- important details about ONLY hotel
SELECT hc_id, hotel_id, rating, address, email, phone FROM hotel

-- surface details of room
SELECT price, capacity, room.hotel_id, hotel.address
FROM room 
INNER JOIN hotel ON hotel.hotel_id = room.hotel_id
WHERE (NOT is_rented);

-- join hotel chain id, HC address, hotel id, hotel address
SELECT  hotel_chain.HC_id, hotel_chain.address, hotel.hotel_id, hotel.address
FROM hotel
INNER JOIN hotel_chain ON hotel.HC_id = hotel_chain.HC_id;

-- retrieve all rooms that can be extended
SELECT room_id
FROM room
WHERE can_be_extended;

-- Retrieve all rooms and their booking history
SELECT room.room_id, booking.date, customer.name
FROM room
LEFT JOIN booking ON room.room_id = booking.room_id
LEFT JOIN customer ON booking.SSN = customer.SSN;

--customer can view their bookings
SELECT booking.booking_id, customer.name
FROM booking
LEFT JOIN customer ON booking.SSN = customer.SSN;

--retrieve all rooms and their amenities
SELECT room.room_id, amenity.amenity_name
FROM room
INNER JOIN room_amenity ON room.room_id = room_amenity.room_id
INNER JOIN amenity ON room_amenity.amenity_id = amenity.amenity_id;

--Retrieve all customers who have rented a room
SELECT customer.name, renting.renting_id
FROM customer
INNER JOIN renting ON customer.SSN = renting.SSN;

-- SAMPLE FOR REGISTRING A CUSTOMER, MAKING A BOOKING, THEN RENTING
INSERT INTO customer VALUES(123456789, 'Eric', '123 Laurier St', CURRENT_DATE);
INSERT INTO booking(start_date, end_date, room_id, SSN) VALUES(CURRENT_DATE, CURRENT_DATE+5, 1, 123456789);

-- AFTER RENTING, IT CHANGES THE BOOLEAN OF THE ROOM
INSERT INTO renting(start_date, end_date, booking_id, room_id, SSN) VALUES(CURRENT_DATE, CURRENT_DATE+5, 'booking_id','room_id', 'existing customer s ssn');


-- Retrieving free rooms
WITH roomID(id) 
as (SELECT DISTINCT room.room_id 
    FROM room LEFT JOIN booking ON room.room_id = booking.room_id 
    WHERE NOT EXISTS (SELECT 1 FROM booking WHERE booking.room_id = room.room_id AND booking.start_date < $1 AND booking.end_date > $2)) 
SELECT * 
FROM room, hotel, roomID 
WHERE room.hotel_id = hotel.hotel_id AND roomID.id = room.room_id


-- retrieves bookings for a customer 
SELECT b.start_date, b.end_date, r.room_num, r.price, r.capacity, r.outside_view, c.name, c.address, c.SSN
FROM booking b
JOIN room r ON b.room_id = r.room_id
JOIN customer c ON b.SSN = c.SSN
WHERE b.SSN = 'ssn input';

-- Test View 1: Number of available rooms per area
SELECT * FROM available_rooms_per_area;

-- Test View 2: Aggregated capacity of all rooms in a specific hotel
SELECT * FROM hotel_room_capacity;