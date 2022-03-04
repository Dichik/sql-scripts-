create user if not exists tutor with password 'tutor';
grant all privileges on database coursework to tutor;

CREATE ROLE student WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'md550d9482e20934ce6df0bf28941f885bc';