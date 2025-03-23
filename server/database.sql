CREATE TABLE hotel_chain (
  HC_id INT NOT NULL,
  address VARCHAR(150) NOT NULL,
  num_hotels INT NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  PRIMARY KEY (HC_id)
);

CREATE TABLE hotel (
  hotel_id INT NOT NULL,
  rating NUMERIC(3,2) NOT NULL CHECK (rating >= 0 AND rating <= 5),
  num_rooms INT NOT NULL,
  address VARCHAR(150) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  HC_id INT NOT NULL,
  manager_SSN INT(9) NOT NULL CHECK (SSN BETWEEN 100000000 AND 999999999),
  PRIMARY KEY (hotel_id),
  FOREIGN KEY (HC_id) REFERENCES hotel_chain(HC_id)
    ON DELETE CASCADE
);

CREATE TABLE room (
  room_id INT NOT NULL,
  room_num INT NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  capacity VARCHAR(30) NOT NULL,
  outside_view VARCHAR(100),
  can_be_extended BOOLEAN NOT NULL,
  has_damage BOOLEAN NOT NULL,
  is_rented BOOLEAN NOT NULL,
  hotel_id INT NOT NULL,
  PRIMARY KEY (room_id),
  FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id)
    ON DELETE CASCADE
);

CREATE TABLE employee (
  SSN INT(9) NOT NULL CHECK (SSN BETWEEN 100000000 AND 999999999),
  name VARCHAR(50) NOT NULL,
  address VARCHAR(150) NOT NULL,
  role_pos VARCHAR(100),
  hotel_id INT NOT NULL,
  PRIMARY KEY (SSN),
  FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id)
    ON DELETE SET NULL
);

CREATE TABLE amenity (
  amenity_id INT NOT NULL,
  amenity_name VARCHAR(100) NOT NULL,
  PRIMARY KEY(amenity_id)
);

CREATE TABLE room_amenity (
  room_id INT NOT NULL,
  amenity_id INT NOT NULL,
  PRIMARY KEY (room_id, amenity_id),
  FOREIGN KEY (room_id) REFERENCES room(room_id)
    ON DELETE CASCADE,
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
    ON DELETE CASCADE
);

CREATE TABLE customer (
  SSN INT(9) NOT NULL CHECK (SSN BETWEEN 100000000 AND 999999999),
  name VARCHAR(50) NOT NULL,
  address VARCHAR(150) NOT NULL,
  reg_date DATE NOT NULL,
  PRIMARY KEY (SSN)
);

CREATE TABLE booking (
  booking_id SERIAL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  room_id INT NOT NULL,
  SSN INT(9) NOT NULL CHECK (SSN BETWEEN 100000000 AND 999999999),
  PRIMARY KEY (booking_id),
  FOREIGN KEY (room_id) REFERENCES room(room_id)
    ON DELETE CASCADE,
  FOREIGN KEY (SSN) REFERENCES customer(SSN)
    ON DELETE SET NULL
);

CREATE TABLE renting (
  renting_id SERIAL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  booking_id INT,
  room_id INT NOT NULL,
  SSN INT(9) NOT NULL CHECK (SSN BETWEEN 100000000 AND 999999999),
  total_cost DECIMAL(10,2),
  PRIMARY KEY (renting_id),
  FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
    ON DELETE SET NULL,
  FOREIGN KEY (room_id) REFERENCES room(room_id)
    ON DELETE CASCADE,
  FOREIGN KEY (SSN) REFERENCES customer(SSN)
    ON DELETE SET NULL
);

-- inserting hotel chain
INSERT INTO hotel_chain VALUES (1,  '777 Carling Avenue, Montreal', 	8,  	'info@nyhotels.com',   '(212) 555-1234');
INSERT INTO hotel_chain VALUES (2,  '2626 Yonge Street, Ottawa',    	8,  	'contact@Ottawahotels.com', '(312) 555-5678');
INSERT INTO hotel_chain VALUES (3,  '3928 Glover Road, Toronto',   	8,  	'support@sfhotels.com',    '(415) 555-9101');
INSERT INTO hotel_chain VALUES (4,  '321 MacLaren Street, Calgary',	8,  	'hello@Calgaryhotels.com',  '(305) 555-1122');
INSERT INTO hotel_chain VALUES (5,  '2391 Bayfield St, Vancouver',  	8, 	'info@vancouverhotels.com',  '(206) 555-3344');

-- inserting hotels (I MANUALLY CHANGED THE NUMBER OF ROOMS EACH HOTEL HAS)
-- Hotels for Hotel Chain 1 (Montreal)
INSERT INTO hotel VALUES (1, 4, 45, '123 Saint-Catherine St, Montreal', 'montrealhotel1@nyhotels.com', '(514) 555-1001', 1, 100000001);
INSERT INTO hotel VALUES (2, 3, 38, '456 Sherbrooke St, Montreal', 'montrealhotel2@nyhotels.com', '(514) 555-1002', 1, 100000002);
INSERT INTO hotel VALUES (3, 5, 50, '789 Peel St, Montreal', 'montrealhotel3@nyhotels.com', '(514) 555-1003', 1, 100000003);
INSERT INTO hotel VALUES (4, 2, 30, '321 Rue Saint-Denis, Montreal', 'montrealhotel4@nyhotels.com', '(514) 555-1004', 1, 100000004);
INSERT INTO hotel VALUES (5, 4, 42, '654 Rue de la Montagne, Montreal', 'montrealhotel5@nyhotels.com', '(514) 555-1005', 1, 100000005);
INSERT INTO hotel VALUES (6, 3, 35, '123 Rue Saint-Paul, Montreal', 'montrealhotel6@nyhotels.com', '(514) 555-1006', 1, 100000006);
INSERT INTO hotel VALUES (7, 4, 48, '456 Avenue du Parc, Montreal', 'montrealhotel7@nyhotels.com', '(514) 555-1007', 1, 100000007);
INSERT INTO hotel VALUES (8, 5, 40, '789 Rue Sainte-Catherine E, Montreal', 'montrealhotel8@nyhotels.com', '(514) 555-1008', 1, 100000008);

-- Hotels for Hotel Chain 2 (Ottawa)
INSERT INTO hotel VALUES (9, 3, 37, '123 Wellington St, Ottawa', 'ottawahotel1@Ottawahotels.com', '(613) 555-2001', 2, 200000001);
INSERT INTO hotel VALUES (10, 4, 45, '456 Rideau St, Ottawa', 'ottawahotel2@Ottawahotels.com', '(613) 555-2002', 2, 200000002);
INSERT INTO hotel VALUES (11, 5, 50, '789 Sussex Dr, Ottawa', 'ottawahotel3@Ottawahotels.com', '(613) 555-2003', 2, 200000003);
INSERT INTO hotel VALUES (12, 2, 32, '321 Bank St, Ottawa', 'ottawahotel4@Ottawahotels.com', '(613) 555-2004', 2, 200000004);
INSERT INTO hotel VALUES (13, 3, 40, '654 Elgin St, Ottawa', 'ottawahotel5@Ottawahotels.com', '(613) 555-2005', 2, 200000005);
INSERT INTO hotel VALUES (14, 4, 38, '123 Laurier Ave, Ottawa', 'ottawahotel6@Ottawahotels.com', '(613) 555-2006', 2, 200000006);
INSERT INTO hotel VALUES (15, 5, 47, '456 Preston St, Ottawa', 'ottawahotel7@Ottawahotels.com', '(613) 555-2007', 2, 200000007);
INSERT INTO hotel VALUES (16, 3, 41, '789 Bronson Ave, Ottawa', 'ottawahotel8@Ottawahotels.com', '(613) 555-2008', 2, 200000008);

-- Hotels for Hotel Chain 3 (Toronto)
INSERT INTO hotel VALUES (17, 4, 44, '123 Yonge St, Toronto', 'torontohotel1@sfhotels.com', '(416) 555-3001', 3, 300000001);
INSERT INTO hotel VALUES (18, 5, 50, '456 Bay St, Toronto', 'torontohotel2@sfhotels.com', '(416) 555-3002', 3, 300000002);
INSERT INTO hotel VALUES (19, 3, 36, '789 Queen St W, Toronto', 'torontohotel3@sfhotels.com', '(416) 555-3003', 3, 300000003);
INSERT INTO hotel VALUES (20, 4, 42, '321 King St E, Toronto', 'torontohotel4@sfhotels.com', '(416) 555-3004', 3, 300000004);
INSERT INTO hotel VALUES (21, 2, 30, '654 Dundas St W, Toronto', 'torontohotel5@sfhotels.com', '(416) 555-3005', 3, 300000005);
INSERT INTO hotel VALUES (22, 4, 39, '123 Spadina Ave, Toronto', 'torontohotel6@sfhotels.com', '(416) 555-3006', 3, 300000006);
INSERT INTO hotel VALUES (23, 5, 48, '456 Bloor St W, Toronto', 'torontohotel7@sfhotels.com', '(416) 555-3007', 3, 300000007);
INSERT INTO hotel VALUES (24, 3, 37, '789 College St, Toronto', 'torontohotel8@sfhotels.com', '(416) 555-3008', 3, 300000008);

-- Hotels for Hotel Chain 4 (Calgary)
INSERT INTO hotel VALUES (25, 5, 50, '123 8th Ave SW, Calgary', 'calgaryhotel1@Calgaryhotels.com', '(403) 555-4001', 4, 400000001);
INSERT INTO hotel VALUES (26, 4, 45, '456 4th St SW, Calgary', 'calgaryhotel2@Calgaryhotels.com', '(403) 555-4002', 4, 400000002);
INSERT INTO hotel VALUES (27, 3, 38, '789 17th Ave SW, Calgary', 'calgaryhotel3@Calgaryhotels.com', '(403) 555-4003', 4, 400000003);
INSERT INTO hotel VALUES (28, 2, 33, '321 1st St SE, Calgary', 'calgaryhotel4@Calgaryhotels.com', '(403) 555-4004', 4, 400000004);
INSERT INTO hotel VALUES (29, 4, 41, '654 10th Ave NW, Calgary', 'calgaryhotel5@Calgaryhotels.com', '(403) 555-4005', 4, 400000005);
INSERT INTO hotel VALUES (30, 3, 37, '123 14th St NW, Calgary', 'calgaryhotel6@Calgaryhotels.com', '(403) 555-4006', 4, 400000006);
INSERT INTO hotel VALUES (31, 5, 49, '456 11th Ave SW, Calgary', 'calgaryhotel7@Calgaryhotels.com', '(403) 555-4007', 4, 400000007);
INSERT INTO hotel VALUES (32, 4, 42, '789 5th Ave SW, Calgary', 'calgaryhotel8@Calgaryhotels.com', '(403) 555-4008', 4, 400000008);

-- Hotels for Hotel Chain 5 (Vancouver)
INSERT INTO hotel VALUES (33, 4, 43, '123 Robson St, Vancouver', 'vancouverhotel1@vancouverhotels.com', '(604) 555-5001', 5, 500000001);
INSERT INTO hotel VALUES (34, 3, 37, '456 Granville St, Vancouver', 'vancouverhotel2@vancouverhotels.com', '(604) 555-5002', 5, 500000002);
INSERT INTO hotel VALUES (35, 5, 50, '789 Davie St, Vancouver', 'vancouverhotel3@vancouverhotels.com', '(604) 555-5003', 5, 500000003);
INSERT INTO hotel VALUES (36, 2, 31, '321 Hastings St, Vancouver', 'vancouverhotel4@vancouverhotels.com', '(604) 555-5004', 5, 500000004);
INSERT INTO hotel VALUES (37, 4, 44, '654 Main St, Vancouver', 'vancouverhotel5@vancouverhotels.com', '(604) 555-5005', 5, 500000005);
INSERT INTO hotel VALUES (38, 3, 39, '123 Commercial Dr, Vancouver', 'vancouverhotel6@vancouverhotels.com', '(604) 555-5006', 5, 500000006);
INSERT INTO hotel VALUES (39, 5, 47, '456 Broadway, Vancouver', 'vancouverhotel7@vancouverhotels.com', '(604) 555-5007', 5, 500000007);
INSERT INTO hotel VALUES (40, 4, 41, '789 Cambie St, Vancouver', 'vancouverhotel8@vancouverhotels.com', '(604) 555-5008', 5, 500000008);

-- inserting amenities
INSERT INTO amenity VALUES (1, 'Free Wi-Fi');
INSERT INTO amenity VALUES (2, 'Swimming pool');
INSERT INTO amenity VALUES (3, 'Fitness center');
INSERT INTO amenity VALUES (4, 'Breakfast included');
INSERT INTO amenity VALUES (5, 'Room service');
INSERT INTO amenity VALUES (6, 'Spa');

-- inserting rooms
--NEW ROOM INSERTS
DO $$
DECLARE
	r_id INTEGER := 1;
	r_nb INTEGER := 1;
	h_id INTEGER := 1;
	max_rooms INTEGER := 0;
BEGIN
	WHILE h_id <= 40 LOOP
		max_rooms := (SELECT num_rooms FROM hotel WHERE hotel_id = h_id)::int;
		
		WHILE r_nb <= max_rooms LOOP
			INSERT INTO room (room_id, room_num, price, capacity, outside_view, can_be_extended, has_damage, is_rented, hotel_id)
			VALUES(r_id,
				   r_nb,
				   (r_id%5+2)*100,
				   CASE
				   WHEN r_id%5=0 THEN 'suites'
				   WHEN r_id%5=1 THEN 'deluxe'
				   WHEN r_id%5=2 THEN 'studio'
				   WHEN r_id%5=3 THEN 'double'
				   WHEN r_id%5=4 THEN 'single'
				   ELSE 'single'
				   END,
				   
				   CASE
				   WHEN r_id%3=0 THEN 'mountain view'
				   WHEN r_id%3=1 THEN 'bay view'
				   WHEN r_id%3=2 THEN 'city view'
				   ELSE 'city view'
				   END,
				   
				   r_id%2=0,
				   false,
				   false,
				   h_id
				  );
				  r_id := r_id + 1;
				  r_nb := r_nb + 1;
		END LOOP;
		r_nb := 1;
		h_id := h_id + 1;
	END LOOP;
END $$;


-- inserting employees (managers)
-- Managers for Hotel Chain 1 (Montreal)
INSERT INTO employee VALUES(100000001, 'John Doe', '123 Manager St, Montreal', 'manager', 1);
INSERT INTO employee VALUES(100000002, 'Jane Smith', '456 Manager Ave, Montreal', 'manager', 2);
INSERT INTO employee VALUES(100000003, 'Michael Brown', '789 Manager Blvd, Montreal', 'manager', 3);
INSERT INTO employee VALUES(100000004, 'Emily Davis', '321 Manager Rd, Montreal', 'manager', 4);
INSERT INTO employee VALUES(100000005, 'David Wilson', '654 Manager Lane, Montreal', 'manager', 5);
INSERT INTO employee VALUES(100000006, 'Sarah Johnson', '987 Manager Way, Montreal', 'manager', 6);
INSERT INTO employee VALUES(100000007, 'James Miller', '123 Manager Circle, Montreal', 'manager', 7);
INSERT INTO employee VALUES(100000008, 'Olivia Garcia', '456 Manager Square, Montreal', 'manager', 8);

-- Managers for Hotel Chain 2 (Ottawa)
INSERT INTO employee VALUES(200000001, 'Daniel Martinez', '123 Manager St, Ottawa', 'manager', 9);
INSERT INTO employee VALUES(200000002, 'Sophia Rodriguez', '456 Manager Ave, Ottawa', 'manager', 10);
INSERT INTO employee VALUES(200000003, 'Alexander Hernandez', '789 Manager Blvd, Ottawa', 'manager', 11);
INSERT INTO employee VALUES(200000004, 'Isabella Lopez', '321 Manager Rd, Ottawa', 'manager', 12);
INSERT INTO employee VALUES(200000005, 'William Gonzalez', '654 Manager Lane, Ottawa', 'manager', 13);
INSERT INTO employee VALUES(200000006, 'Mia Perez', '987 Manager Way, Ottawa', 'manager', 14);
INSERT INTO employee VALUES(200000007, 'Ethan Torres', '123 Manager Circle, Ottawa', 'manager', 15);
INSERT INTO employee VALUES(200000008, 'Charlotte Flores', '456 Manager Square, Ottawa', 'manager', 16);

-- Managers for Hotel Chain 3 (Toronto)
INSERT INTO employee VALUES(300000001, 'Benjamin Ramirez', '123 Manager St, Toronto', 'manager', 17);
INSERT INTO employee VALUES(300000002, 'Amelia Reyes', '456 Manager Ave, Toronto', 'manager', 18);
INSERT INTO employee VALUES(300000003, 'Lucas Cruz', '789 Manager Blvd, Toronto', 'manager', 19);
INSERT INTO employee VALUES(300000004, 'Harper Morales', '321 Manager Rd, Toronto', 'manager', 20);
INSERT INTO employee VALUES(300000005, 'Logan Rivera', '654 Manager Lane, Toronto', 'manager', 21);
INSERT INTO employee VALUES(300000006, 'Evelyn Gomez', '987 Manager Way, Toronto', 'manager', 22);
INSERT INTO employee VALUES(300000007, 'Oliver Ortiz', '123 Manager Circle, Toronto', 'manager', 23);
INSERT INTO employee VALUES(300000008, 'Avery Diaz', '456 Manager Square, Toronto', 'manager', 24);

-- Managers for Hotel Chain 4 (Calgary)
INSERT INTO employee VALUES(400000001, 'Scarlett Reyes', '123 Manager St, Calgary', 'manager', 25);
INSERT INTO employee VALUES(400000002, 'Jackson Cruz', '456 Manager Ave, Calgary', 'manager', 26);
INSERT INTO employee VALUES(400000003, 'Aria Morales', '789 Manager Blvd, Calgary', 'manager', 27);
INSERT INTO employee VALUES(400000004, 'Liam Rivera', '321 Manager Rd, Calgary', 'manager', 28);
INSERT INTO employee VALUES(400000005, 'Luna Gomez', '654 Manager Lane, Calgary', 'manager', 29);
INSERT INTO employee VALUES(400000006, 'Mason Ortiz', '987 Manager Way, Calgary', 'manager', 30);
INSERT INTO employee VALUES(400000007, 'Ella Diaz', '123 Manager Circle, Calgary', 'manager', 31);
INSERT INTO employee VALUES(400000008, 'Noah Martinez', '456 Manager Square, Calgary', 'manager', 32);

-- Managers for Hotel Chain 5 (Vancouver)
INSERT INTO employee VALUES(500000001, 'Grace Rodriguez', '123 Manager St, Vancouver', 'manager', 33);
INSERT INTO employee VALUES(500000002, 'Elijah Hernandez', '456 Manager Ave, Vancouver', 'manager', 34);
INSERT INTO employee VALUES(500000003, 'Chloe Lopez', '789 Manager Blvd, Vancouver', 'manager', 35);
INSERT INTO employee VALUES(500000004, 'Caleb Gonzalez', '321 Manager Rd, Vancouver', 'manager', 36);
INSERT INTO employee VALUES(500000005, 'Victoria Perez', '654 Manager Lane, Vancouver', 'manager', 37);
INSERT INTO employee VALUES(500000006, 'Samuel Torres', '987 Manager Way, Vancouver', 'manager', 38);
INSERT INTO employee VALUES(500000007, 'Addison Flores', '123 Manager Circle, Vancouver', 'manager', 39);
INSERT INTO employee VALUES(500000008, 'Matthew Ramirez', '456 Manager Square, Vancouver', 'manager', 40);

-- View 1: Number of available rooms per area
CREATE VIEW available_rooms_per_area AS
SELECT h.address, COUNT(r.room_id) AS available_rooms
FROM room r
JOIN hotel h ON r.hotel_id = h.hotel_id
WHERE r.is_rented = FALSE
GROUP BY h.address;

-- View 2: Aggregated capacity of all rooms in a specific hotel
CREATE VIEW hotel_room_capacity AS
SELECT h.hotel_id, SUM(CASE 
                        WHEN r.capacity = 'single' THEN 1
                        WHEN r.capacity = 'double' THEN 2
                        WHEN r.capacity = 'suite' THEN 4
                        ELSE 1
                      END) AS total_capacity
FROM room r
JOIN hotel h ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id;

-- indexing. B-trees are the default index type in PostgreSQL (ordered data access)
CREATE INDEX idx_room_id ON room (room_id);
CREATE INDEX idx_booking_id_start_end ON booking (booking_id,start_date, end_date);
CREATE INDEX idx_renting_id_start_end ON renting (renting_id,start_date, end_date);

-- TRIGGER to update total renting price
CREATE FUNCTION total_renting_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    room_price FLOAT;
BEGIN
	room_price := (SELECT price FROM room WHERE room_id = new.room_id)::float;
	UPDATE renting
	SET total_cost = (SELECT SUM(room_price * (end_date - start_date))
					  FROM renting
					  WHERE renting_id = NEW.renting_id)
	WHERE renting_id = NEW.renting_id;
	RETURN NEW;
END;
$$;
CREATE TRIGGER total_renting_price_trigger
AFTER INSERT ON renting
FOR EACH ROW EXECUTE FUNCTION total_renting_price();

-- trigger to change room availability
CREATE FUNCTION update_room_rental_status()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE room SET is_rented = TRUE WHERE room_id = NEW.room_id;
	ELSIF TG_OP = 'UPDATE' AND NEW.end_date IS NOT NULL AND NEW.end_date < NOW() THEN
		UPDATE room SET is_rented = FALSE WHERE room_id = OLD.room_id;
	END IF;
	RETURN NEW;
END;
$$;
CREATE TRIGGER rental_status_trigger
AFTER INSERT OR UPDATE ON renting
FOR EACH ROW
EXECUTE FUNCTION update_room_rental_status();
