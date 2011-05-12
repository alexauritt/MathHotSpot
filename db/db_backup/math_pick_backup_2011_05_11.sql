--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    title character varying(255),
    subject_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.categories OWNER TO alexauritt;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO alexauritt;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('categories_id_seq', 1, false);


--
-- Name: instructions; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE instructions (
    id integer NOT NULL,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.instructions OWNER TO alexauritt;

--
-- Name: instructions_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE instructions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instructions_id_seq OWNER TO alexauritt;

--
-- Name: instructions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE instructions_id_seq OWNED BY instructions.id;


--
-- Name: instructions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('instructions_id_seq', 5, false);


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE lessons (
    id integer NOT NULL,
    title character varying(255),
    chapter integer,
    section integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    subject_id integer
);


ALTER TABLE public.lessons OWNER TO alexauritt;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO alexauritt;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE lessons_id_seq OWNED BY lessons.id;


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('lessons_id_seq', 3, false);


--
-- Name: math_problems; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE math_problems (
    id integer NOT NULL,
    problem_level_id integer,
    question_markup text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    answer_markup text
);


ALTER TABLE public.math_problems OWNER TO alexauritt;

--
-- Name: math_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE math_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.math_problems_id_seq OWNER TO alexauritt;

--
-- Name: math_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE math_problems_id_seq OWNED BY math_problems.id;


--
-- Name: math_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('math_problems_id_seq', 23, false);


--
-- Name: problem_levels; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE problem_levels (
    id integer NOT NULL,
    problem_type_id integer,
    difficulty integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.problem_levels OWNER TO alexauritt;

--
-- Name: problem_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE problem_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_levels_id_seq OWNER TO alexauritt;

--
-- Name: problem_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE problem_levels_id_seq OWNED BY problem_levels.id;


--
-- Name: problem_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('problem_levels_id_seq', 13, false);


--
-- Name: problem_types; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE problem_types (
    id integer NOT NULL,
    lesson_id integer,
    instruction_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    display_mode boolean DEFAULT true
);


ALTER TABLE public.problem_types OWNER TO alexauritt;

--
-- Name: problem_types_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE problem_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_types_id_seq OWNER TO alexauritt;

--
-- Name: problem_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE problem_types_id_seq OWNED BY problem_types.id;


--
-- Name: problem_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('problem_types_id_seq', 5, false);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO alexauritt;

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE subjects (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.subjects OWNER TO alexauritt;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_id_seq OWNER TO alexauritt;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('subjects_id_seq', 6, false);


--
-- Name: worksheet_problems; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE worksheet_problems (
    id integer NOT NULL,
    worksheet_id integer,
    math_problem_id integer,
    problem_number integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.worksheet_problems OWNER TO alexauritt;

--
-- Name: worksheet_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE worksheet_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.worksheet_problems_id_seq OWNER TO alexauritt;

--
-- Name: worksheet_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE worksheet_problems_id_seq OWNED BY worksheet_problems.id;


--
-- Name: worksheet_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('worksheet_problems_id_seq', 13, false);


--
-- Name: worksheets; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE worksheets (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.worksheets OWNER TO alexauritt;

--
-- Name: worksheets_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE worksheets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.worksheets_id_seq OWNER TO alexauritt;

--
-- Name: worksheets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE worksheets_id_seq OWNED BY worksheets.id;


--
-- Name: worksheets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('worksheets_id_seq', 2, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE instructions ALTER COLUMN id SET DEFAULT nextval('instructions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE lessons ALTER COLUMN id SET DEFAULT nextval('lessons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE math_problems ALTER COLUMN id SET DEFAULT nextval('math_problems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE problem_levels ALTER COLUMN id SET DEFAULT nextval('problem_levels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE problem_types ALTER COLUMN id SET DEFAULT nextval('problem_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE worksheet_problems ALTER COLUMN id SET DEFAULT nextval('worksheet_problems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE worksheets ALTER COLUMN id SET DEFAULT nextval('worksheets_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY categories (id, title, subject_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: instructions; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY instructions (id, description, created_at, updated_at) FROM stdin;
1	Simplify	2011-05-03 19:10:31.382471	2011-05-03 19:10:31.382471
2	Find the GCF of each pair of monomials	2011-05-03 19:10:31.391329	2011-05-03 19:10:31.391329
3	Simplify. Assume that no denominator equals 0.	2011-05-03 19:10:31.394166	2011-05-03 19:10:31.394166
4	Solve the following word problem.	2011-05-04 16:26:35.626882	2011-05-04 16:26:35.626882
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY lessons (id, title, chapter, section, created_at, updated_at, subject_id) FROM stdin;
1	Dividing Monomials	5	2	2011-05-03 19:10:31.353717	2011-05-03 19:10:31.353717	1
2	Permutations and Combinations	13	2	2011-05-04 16:26:08.070815	2011-05-04 16:26:08.070815	4
\.


--
-- Data for Name: math_problems; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY math_problems (id, problem_level_id, question_markup, created_at, updated_at, answer_markup) FROM stdin;
1	1	<math display="block"><mfrac><mrow><mn>-4</mn><mi>x</mi><mi>y</mi></mrow><mrow><mn>10</mn><mi>x</mi></mrow></mfrac></math>	2011-05-03 19:10:31.538236	2011-05-03 19:15:32.423882	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>5</mn>\r\n    <mn>6</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaI1aaabaGaaGOnaaaaaaa@2FA1@</annotation>\r\n </semantics>\r\n</math>\r\n
2	1	<math display="block"><mfrac><mrow><mn>-2</mn><mi>a</mi><mi>b</mi></mrow><mrow><mn>14</mn><mi>a</mi></mrow></mfrac></math>	2011-05-03 19:10:31.545926	2011-05-03 19:16:15.085969	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><mi>b</mi>\r\n    </mrow>\r\n    <mn>7</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaWGIbaabaGaaG4naaaaaaa@30B7@</annotation>\r\n </semantics>\r\n</math>\r\n
3	2	<math display="block"><mfrac><mrow><msup><mi>c</mi><mn>7</mn></msup></mrow><mrow><msup><mi>c</mi><mn>4</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.556673	2011-05-03 19:16:50.817582	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <msup>\r\n    <mi>c</mi>\r\n    <mn>3</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaam4yamaaCaaaleqabaGaaG4maaaaaaa@2FE4@</annotation>\r\n </semantics>\r\n</math>\r\n
4	2	<math display="block"><mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.559516	2011-05-03 19:17:24.648873	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>1</mn>\r\n    <mrow>\r\n     <msup>\r\n      <mi>a</mi>\r\n      <mn>5</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaIXaaabaGaamyyamaaCaaaleqabaGaaGynaaaaaaaaaa@30AF@</annotation>\r\n </semantics>\r\n</math>\r\n
5	2	<math display="block"><mfrac><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.56201	2011-05-03 19:18:26.868687	<math display='block'>\r\n <semantics>\r\n  <mn>1</mn>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaaGymaaaa@2ECD@</annotation>\r\n </semantics>\r\n</math>\r\n
6	3	<math display="block"><mfrac><mrow><mn>12</mn><msup><mi>x</mi><mn>5</mn></msup></mrow><mrow><mn>-3</mn><msup><mi>x</mi><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.56451	2011-05-03 19:21:52.826693	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mn>5</mn><msup>\r\n    <mi>x</mi>\r\n    <mn>2</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaaGynaiaadIhadaahaaWcbeqaaiaaikdaaaaaaa@30B7@</annotation>\r\n </semantics>\r\n</math>\r\n
7	3	<math display="block"><mfrac><mrow><mn>-5</mn><msup><mi>k</mi><mn>4</mn></msup></mrow><mrow><mn>20</mn><mi>k</mi></mrow></mfrac></math>	2011-05-03 19:10:31.567118	2011-05-03 19:22:31.615545	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><msup>\r\n      <mi>k</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mn>4</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaWGRbWaaWbaaSqabeaacaaIZaaaaaGcbaGaaGinaaaaaaa@31B1@</annotation>\r\n </semantics>\r\n</math>\r\n
8	4	<math display="block"><mfrac><mrow><mi>m</mi><msup><mi>n</mi><mn>5</mn></msup></mrow><mrow><msup><mi>m</mi><mn>3</mn></msup><msup><mi>n</mi><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.597407	2011-05-03 19:29:16.595266	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <msup>\r\n      <mi>n</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>m</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWGUbWaaWbaaSqabeaacaaIZaaaaaGcbaGaamyBamaaCaaaleqabaGaaGOmaaaaaaaaaa@31E4@</annotation>\r\n </semantics>\r\n</math>\r\n
9	4	<math display="block"><mfrac><mrow><msup><mi>x</mi><mn>5</mn></msup><msup><mi>y</mi><mn>4</mn></msup></mrow><mrow><mi>x</mi><msup><mi>y</mi><mn>10</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.600705	2011-05-03 19:29:49.184525	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <msup>\r\n      <mi>x</mi>\r\n      <mn>4</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>y</mi>\r\n      <mn>6</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWG4bWaaWbaaSqabeaacaaI0aaaaaGcbaGaamyEamaaCaaaleqabaGaaGOnaaaaaaaaaa@31FF@</annotation>\r\n </semantics>\r\n</math>\r\n
10	5	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>5</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.604258	2011-05-03 19:30:41.423882	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <msup>\r\n    <mi>k</mi>\r\n    <mn>2</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaam4AamaaCaaaleqabaGaaGOmaaaaaaa@2FEB@</annotation>\r\n </semantics>\r\n</math>\r\n
11	5	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>3</mn><mi>x</mi></mrow></mfenced><mn>2</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>x</mi></mrow></mfenced><mn>4</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.607551	2011-05-03 19:32:07.890869	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>9</mn>\r\n    <mrow>\r\n     <mn>16</mn><msup>\r\n      <mi>x</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaI5aaabaGaaGymaiaaiAdacaWG4bWaaWbaaSqabeaacaaIYaaaaaaaaaa@3246@</annotation>\r\n </semantics>\r\n</math>\r\n
12	6	<math display="block"><mfrac><mrow><mo>-</mo><mfenced><mrow><msup><mi>m</mi><mn>3</mn></msup><mi>n</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>m</mi><mi>n</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.610912	2011-05-03 19:34:03.14447	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>1</mn>\r\n    <mrow>\r\n     <msup>\r\n      <mi>n</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaIXaaabaGaamOBamaaCaaaleqabaGaaGOmaaaaaaaaaa@30B9@</annotation>\r\n </semantics>\r\n</math>\r\n
13	6	<math display="block"><mfrac><mrow><msup><mfenced><mi>-x</mi></mfenced><mn>2</mn></msup><mi>y</mi></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>x</mi><mi>y</mi></mrow></mfenced><mn>5</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.613912	2011-05-03 19:35:40.494852	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><mn>1</mn>\r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>x</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     <msup>\r\n      <mi>y</mi>\r\n      <mn>4</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaaIXaaabaGaamiEamaaCaaaleqabaGaaG4maaaakiaadMhadaahaaWcbeqaaiaaisdaaaaaaaaa@33A4@</annotation>\r\n </semantics>\r\n</math>\r\n
14	7	<math><mrow><mn>72</mn><msup><mi>x</mi><mn>3</mn></msup><mi>y</mi><msup><mi>z</mi><mn>3</mn></msup></mrow></math><span class="math_problem_template">and</span><math><mrow><mn>120</mn><msup><mi>x</mi><mn>2</mn></msup><msup><mi>z</mi><mn>5</mn></msup></mrow></math>	2011-05-03 19:10:31.617328	2011-05-03 19:10:31.617328	\N
15	7	<math><mrow><mn>4</mn><msup><mi>p</mi><mn>2</mn></msup><mfenced><mrow><mi>p</mi><mo>-</mo><mn>1</mn></mrow></mfenced></mrow></math><span class="math_text">and</span><math><mrow><mn>6</mn><mi>p</mi><msup><mfenced><mrow><mi>p</mi><mo>+</mo><mn>1</mn></mrow></mfenced><mn>2</mn></msup></mrow></math>	2011-05-03 19:10:31.645565	2011-05-03 19:10:31.645565	\N
16	8	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>3</mn></msup></mrow><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.649005	2011-05-03 19:10:31.649005	\N
17	8	<math display="block"><mfrac><mrow><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mfenced><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.652116	2011-05-03 19:10:31.652116	\N
18	9	<math><mrow><mn>3</mn><msup><mi>x</mi><mn>2</mn></msup></mrow></math><span class="math_problem_template">and</span><math><mrow><mn>9</mn><msup><mi>x</mi><mn>3</mn></msup></mrow></math>	2011-05-03 22:45:34.058796	2011-05-05 15:27:23.183576	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mn>3</mn><msup>\r\n    <mi>x</mi>\r\n    <mn>2</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaaG4maiaadIhadaahaaWcbeqaaiaaikdaaaaaaa@30B5@</annotation>\r\n </semantics>\r\n</math>\r\n
19	10	How many different words can be formed using all the letters in the word REARRANGE?	2011-05-04 16:27:48.042824	2011-05-04 17:04:30.472905	15,120
20	11	How many different committees of 3 people can be formed from a pool of 7 people?	2011-05-04 16:28:44.322059	2011-05-04 16:28:44.322059	35
21	12	In how many different ways can a committee of 2 faculty members and 3 students be formed if 6 faculty members and 10 students are eligible to serve on the committee?	2011-05-04 16:29:39.58991	2011-05-04 16:29:39.58991	18000
22	10	How many different 9-letter words (real or imaginary) can be formed from the letters in the word ECONOMICS?	2011-05-04 17:04:19.722813	2011-05-04 17:04:19.722813	90,720
\.


--
-- Data for Name: problem_levels; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY problem_levels (id, problem_type_id, difficulty, created_at, updated_at) FROM stdin;
1	1	1	2011-05-03 19:10:31.475904	2011-05-03 19:10:31.475904
2	1	2	2011-05-03 19:10:31.483309	2011-05-03 19:10:31.483309
3	1	3	2011-05-03 19:10:31.486344	2011-05-03 19:10:31.486344
4	1	4	2011-05-03 19:10:31.489465	2011-05-03 19:10:31.489465
5	1	5	2011-05-03 19:10:31.494375	2011-05-03 19:10:31.494375
6	1	6	2011-05-03 19:10:31.505266	2011-05-03 19:10:31.505266
7	2	3	2011-05-03 19:10:31.508137	2011-05-03 19:10:31.508137
8	3	3	2011-05-03 19:10:31.510688	2011-05-03 19:10:31.510688
9	2	\N	2011-05-03 22:45:34.053097	2011-05-03 22:45:34.053097
10	4	\N	2011-05-04 16:27:48.016976	2011-05-04 16:27:48.016976
11	4	\N	2011-05-04 16:28:44.318415	2011-05-04 16:28:44.318415
12	4	\N	2011-05-04 16:29:39.588314	2011-05-04 16:29:39.588314
\.


--
-- Data for Name: problem_types; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY problem_types (id, lesson_id, instruction_id, created_at, updated_at, display_mode) FROM stdin;
1	1	1	2011-05-03 19:10:31.432688	2011-05-03 19:10:31.432688	t
2	1	2	2011-05-03 19:10:31.455778	2011-05-03 19:10:31.455778	f
3	1	3	2011-05-03 19:10:31.460493	2011-05-03 19:10:31.460493	t
4	2	4	2011-05-04 16:27:47.955369	2011-05-04 16:27:47.955369	t
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY schema_migrations (version) FROM stdin;
20110213202850
20110213203222
20110213203310
20110214140107
20110214150113
20110220144540
20110220193718
20110405180707
20110407140232
20110412143136
20110420144012
20110504025954
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY subjects (id, title, created_at, updated_at) FROM stdin;
1	Algebra I	2011-05-03 19:10:31.25813	2011-05-03 19:10:31.25813
2	Geometry	2011-05-03 19:10:31.304325	2011-05-03 19:10:31.304325
3	Algebra II	2011-05-03 19:10:31.307877	2011-05-03 19:10:31.307877
4	Precalculus	2011-05-03 19:10:31.31366	2011-05-03 19:10:31.31366
5	Calculus	2011-05-03 19:10:31.317414	2011-05-03 19:10:31.317414
\.


--
-- Data for Name: worksheet_problems; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY worksheet_problems (id, worksheet_id, math_problem_id, problem_number, created_at, updated_at) FROM stdin;
1	1	1	1	2011-05-03 19:10:31.703793	2011-05-03 19:10:31.703793
2	1	2	2	2011-05-03 19:10:31.714007	2011-05-03 19:10:31.714007
3	1	3	3	2011-05-03 19:10:31.719957	2011-05-03 19:10:31.719957
4	1	4	4	2011-05-03 19:10:31.725162	2011-05-03 19:10:31.725162
5	1	6	5	2011-05-03 19:10:31.730281	2011-05-03 19:10:31.730281
6	1	8	6	2011-05-03 19:10:31.746036	2011-05-03 19:10:31.746036
7	1	10	7	2011-05-03 19:10:31.764176	2011-05-03 19:10:31.764176
8	1	12	8	2011-05-03 19:10:31.769407	2011-05-03 19:10:31.769407
9	1	14	9	2011-05-03 19:10:31.774256	2011-05-03 19:10:31.774256
10	1	15	10	2011-05-03 19:10:31.779661	2011-05-03 19:10:31.779661
11	1	16	11	2011-05-03 19:10:31.797217	2011-05-03 19:10:31.797217
12	1	17	12	2011-05-03 19:10:31.805573	2011-05-03 19:10:31.805573
\.


--
-- Data for Name: worksheets; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY worksheets (id, title, created_at, updated_at) FROM stdin;
1	My first worksheet	2011-05-03 19:10:31.667423	2011-05-03 19:10:31.667423
\.


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: instructions_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY instructions
    ADD CONSTRAINT instructions_pkey PRIMARY KEY (id);


--
-- Name: lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: math_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY math_problems
    ADD CONSTRAINT math_problems_pkey PRIMARY KEY (id);


--
-- Name: problem_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY problem_levels
    ADD CONSTRAINT problem_levels_pkey PRIMARY KEY (id);


--
-- Name: problem_types_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY problem_types
    ADD CONSTRAINT problem_types_pkey PRIMARY KEY (id);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: worksheet_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY worksheet_problems
    ADD CONSTRAINT worksheet_problems_pkey PRIMARY KEY (id);


--
-- Name: worksheets_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY worksheets
    ADD CONSTRAINT worksheets_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

