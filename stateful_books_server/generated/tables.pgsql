--
-- Class Author as table author
--

CREATE TABLE "author" (
  "id" serial,
  "name" text NOT NULL
);

ALTER TABLE ONLY "author"
  ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Class Book as table book
--

CREATE TABLE "book" (
  "id" serial,
  "title" text NOT NULL,
  "authorId" integer NOT NULL,
  "isPopular" boolean NOT NULL,
  "isNew" boolean NOT NULL
);

ALTER TABLE ONLY "book"
  ADD CONSTRAINT book_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "book"
  ADD CONSTRAINT book_fk_0
    FOREIGN KEY("authorId")
      REFERENCES author(id)
        ON DELETE CASCADE;

