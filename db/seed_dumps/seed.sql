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

SELECT pg_catalog.setval('categories_id_seq', 12, false);


--
-- Name: core_lesson_problem_types; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE core_lesson_problem_types (
    id integer NOT NULL,
    lesson_id integer,
    problem_type_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.core_lesson_problem_types OWNER TO alexauritt;

--
-- Name: core_lesson_problem_types_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE core_lesson_problem_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_lesson_problem_types_id_seq OWNER TO alexauritt;

--
-- Name: core_lesson_problem_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE core_lesson_problem_types_id_seq OWNED BY core_lesson_problem_types.id;


--
-- Name: core_lesson_problem_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('core_lesson_problem_types_id_seq', 12, false);


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

SELECT pg_catalog.setval('instructions_id_seq', 9, false);


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
    subject_id integer,
    category_id integer,
    owner_id integer
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

SELECT pg_catalog.setval('lessons_id_seq', 6, false);


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

SELECT pg_catalog.setval('math_problems_id_seq', 45, false);


--
-- Name: problem_levels; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE problem_levels (
    id integer NOT NULL,
    problem_type_id integer,
    level_number integer,
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

SELECT pg_catalog.setval('problem_levels_id_seq', 24, false);


--
-- Name: problem_types; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE problem_types (
    id integer NOT NULL,
    instruction_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    display_mode boolean DEFAULT true,
    title character varying(255),
    permalink character varying(255),
    owner_id integer,
    category_id integer
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

SELECT pg_catalog.setval('problem_types_id_seq', 11, false);


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
-- Name: taggings; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE public.taggings OWNER TO alexauritt;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggings_id_seq OWNER TO alexauritt;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('taggings_id_seq', 11, false);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.tags OWNER TO alexauritt;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO alexauritt;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('tags_id_seq', 8, false);


--
-- Name: users; Type: TABLE; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO alexauritt;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: alexauritt
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO alexauritt;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexauritt
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexauritt
--

SELECT pg_catalog.setval('users_id_seq', 4, false);


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

ALTER TABLE core_lesson_problem_types ALTER COLUMN id SET DEFAULT nextval('core_lesson_problem_types_id_seq'::regclass);


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

ALTER TABLE taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alexauritt
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


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
1	Polynomials	1	2011-05-12 14:15:13.017631	2011-05-12 14:16:07.033299
2	Probability and Counting	4	2011-05-12 14:15:13.051083	2011-05-12 14:16:19.138069
3	Basic Equations and Problems	1	2011-06-20 20:45:26.982298	2011-06-20 20:45:26.982298
8	Factoring Polynomials	1	2011-07-09 10:31:13.819191	2011-07-09 10:31:13.819191
9	Algebraic Fractions	1	2011-07-09 10:32:08.425715	2011-07-09 10:32:08.425715
11	Limits and Continuity  	5	2011-07-14 13:25:59.067449	2011-07-14 13:25:59.067449
\.


--
-- Data for Name: core_lesson_problem_types; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY core_lesson_problem_types (id, lesson_id, problem_type_id, created_at, updated_at) FROM stdin;
1	1	1	2011-07-26 11:37:31.513726	2011-07-26 11:37:31.513726
2	1	2	2011-07-26 11:37:31.528191	2011-07-26 11:37:31.528191
3	1	3	2011-07-26 11:37:31.531938	2011-07-26 11:37:31.531938
4	2	4	2011-07-26 11:37:31.535665	2011-07-26 11:37:31.535665
5	1	5	2011-07-26 11:37:31.539245	2011-07-26 11:37:31.539245
6	4	6	2011-07-26 11:37:31.542809	2011-07-26 11:37:31.542809
7	3	7	2011-07-26 11:37:31.546382	2011-07-26 11:37:31.546382
8	3	8	2011-07-26 11:37:31.549896	2011-07-26 11:37:31.549896
9	5	1	2011-07-26 11:37:31.553469	2011-07-26 11:37:31.553469
10	5	2	2011-07-26 11:37:31.557039	2011-07-26 11:37:31.557039
11	5	3	2011-07-26 11:37:31.560622	2011-07-26 11:37:31.560622
\.


--
-- Data for Name: instructions; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY instructions (id, description, created_at, updated_at) FROM stdin;
1	Simplify	2011-05-03 19:10:31.382471	2011-05-03 19:10:31.382471
2	Find the GCF of each pair of monomials	2011-05-03 19:10:31.391329	2011-05-03 19:10:31.391329
3	Simplify. Assume that no denominator equals 0.	2011-05-03 19:10:31.394166	2011-05-03 19:10:31.394166
4	Solve the following word problem.	2011-05-04 16:26:35.626882	2011-05-04 16:26:35.626882
5	Divide.	2011-06-21 23:32:56.573779	2011-06-21 23:32:56.573779
6	Factor.	2011-07-04 16:27:28.59712	2011-07-04 16:27:28.59712
7	Differentiate.	2011-07-14 13:26:51.661628	2011-07-14 13:26:51.661628
8	Solve.	2011-07-28 09:40:14.316131	2011-07-28 09:40:14.316131
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY lessons (id, title, chapter, section, created_at, updated_at, subject_id, category_id, owner_id) FROM stdin;
1	Dividing Monomials	5	2	2011-05-03 19:10:31.353717	2011-07-07 09:24:31.323106	1	4	1
2	Permutations and Combinations	13	2	2011-05-04 16:26:08.070815	2011-07-10 18:28:23.649171	4	2	1
3	Monomial Factors of Polynomials	5	3	2011-06-04 04:13:59.923778	2011-07-07 09:24:31.380905	\N	6	1
4	Cost, Value and Income Problems	3	7	2011-06-20 20:46:26.418678	2011-07-07 09:24:31.387004	\N	7	1
5	Algebra Review	\N	\N	2011-07-10 10:43:14.972	2011-07-10 10:43:14.972	2	\N	2
\.


--
-- Data for Name: math_problems; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY math_problems (id, problem_level_id, question_markup, created_at, updated_at, answer_markup) FROM stdin;
1	1	<math display="block"><mfrac><mrow><mn>-4</mn><mi>x</mi><mi>y</mi></mrow><mrow><mn>10</mn><mi>x</mi></mrow></mfrac></math>	2011-05-03 19:10:31.538236	2011-06-04 03:39:23.365932	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>5</mn>\r\n    <mn>6</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaI1aaabaGaaGOnaaaaaaa@2FA1@</annotation>\r\n </semantics>\r\n</math>\r\n
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
14	15	\\[ 72x^{3}yz^{3} \\text{ and } 120x^{2}z^{5} \\]	2011-05-03 19:10:31.617328	2011-07-09 16:28:52.378519	\\[24x^{2}z^{3}\\]
15	15	\\[4p^{2}\\left ( p-1 \\right ) \\text{ and } 6p\\left (p+1 \\right)^{2}\\]	2011-05-03 19:10:31.645565	2011-07-09 16:32:33.310024	\\[2p\\]
16	8	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>3</mn></msup></mrow><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.649005	2011-06-04 03:54:36.991026	<math display='block'><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></math>
17	8	<math display="block"><mfrac><mrow><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mfenced><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.652116	2011-06-04 03:55:08.807184	<math display='block'><mfrac><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfrac></math>
18	9	\\[ 3x^{2} \\text{ and } 9x^{3} \\]	2011-05-03 22:45:34.058796	2011-07-09 16:25:16.0926	\\[ 3x^{2} \\]
19	10	How many different words can be formed using all the letters in the word REARRANGE?	2011-05-04 16:27:48.042824	2011-05-04 17:04:30.472905	15,120
20	11	How many different committees of 3 people can be formed from a pool of 7 people?	2011-05-04 16:28:44.322059	2011-05-04 16:28:44.322059	35
21	12	In how many different ways can a committee of 2 faculty members and 3 students be formed if 6 faculty members and 10 students are eligible to serve on the committee?	2011-05-04 16:29:39.58991	2011-05-04 16:29:39.58991	18000
22	10	How many different 9-letter words (real or imaginary) can be formed from the letters in the word ECONOMICS?	2011-05-04 17:04:19.722813	2011-05-04 17:04:19.722813	90,720
24	13	<math display='block'><mfrac><msup><mi>x</mi><mn>2</mn></msup><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>4</mn></msup></mrow><mo>+</mo><mrow><mn>2</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></mrow></mfrac></math>	2011-06-03 02:52:28.643694	2011-06-04 04:19:17.420707	<math display='block'><mfrac><mn>1</mn><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mn>2</mn></mrow></mfrac></math>
25	14	Tickets for the play cost $6 for grown-ups and $3 for children. 846 tickets were sold for a total cash value of $3846. How many child tickets were sold?	2011-06-20 20:48:42.812331	2011-06-20 20:48:42.812331	410 child tickets were sold.
26	14	Mary makes $5/hr working during the week, and $6/hr working on weekends. In May she made $64.50 by working a total of 12 hours. How many hours did she make working on weekends in May?	2011-06-20 20:51:06.391392	2011-06-21 22:43:12.207802	4.5 hours on the weekends.
28	16	Jim bought 100 postage stamps, worth $9.40 in total. Half of them where $0.01 stamps, and the rest were $0.14 and $0.22 stamps. How many $0.22 stamps did he buy?	2011-06-21 22:48:16.540375	2011-06-21 22:48:16.540375	30 stamps.
29	14	Thirty students bought posters to support the yearbook. Small posters cost $4 each, and large posters cost $8 each. If the total cost of all posters was $168, how many students bought large posters?	2011-06-21 22:50:48.74252	2011-06-21 22:50:48.74252	12 students.
30	14	Fred bought candybars; he paid $1.50 for each one. He sold all but 20 of them for $3 each and he made a profit of $15. How many candy bars did he buy?	2011-06-21 22:53:06.472724	2011-06-21 22:53:06.472724	50 candy bars.
31	17	<math display='block'><mfrac><mrow><mrow><mn>5</mn><mo>&#8290;</mo><mi>m</mi></mrow><mo>+</mo><mn>35</mn></mrow><mrow><mn>5</mn></mrow></mfrac></math>	2011-06-21 22:56:53.85072	2011-06-21 23:27:44.140475	<math display='block'><mrow><mi>m</mi><mo>+</mo><mn>7</mn></mrow></math>
32	18	<math display='block'><mfrac><mrow><mrow><mn>26</mn><mo>&#8290;</mo><mi>xy</mi></mrow><mo>-</mo><mrow><mn>39</mn><mo>&#8290;</mo><mi>y</mi></mrow></mrow><mrow><mn>13</mn><mo>&#8290;</mo><mi>y</mi></mrow></mfrac></math>	2011-06-21 23:29:16.008733	2011-06-21 23:29:16.008733	<math display='block'><mrow><mrow><mn>2</mn><mo>&#8290;</mo><mi>x</mi></mrow><mo>-</mo><mi>y</mi></mrow></math>
33	19	<math display='block'><mrow><mfrac><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>4</mn></msup></mrow><mo>-</mo><mrow><mn>9</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>3</mn></msup><mo>&#8290;</mo><mi>y</mi></mrow><mo>+</mo><mrow><mn>6</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup><mo>&#8290;</mo><msup><mi>y</mi><mn>2</mn></msup></mrow></mrow><mrow><mo>-</mo><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></mfrac></mrow></math>	2011-06-21 23:30:26.072071	2011-06-21 23:31:56.185436	<math display='block'><mrow><mrow><mo>-</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mrow><mn>3</mn><mo>&#8290;</mo><mi>xy</mi></mrow><mo>-</mo><mrow><mn>2</mn><mo>&#8290;</mo><msup><mi>y</mi><mn>2</mn></msup></mrow></mrow></math>
35	17	<math display='block'><mfrac><mrow><mrow><mn>7</mn><mo>&#8290;</mo><mi>x</mi></mrow><mo>+</mo><mn>28</mn></mrow><mrow><mn>14</mn><mo>&#8290;</mo><mi>x</mi></mrow></mfrac></math>	2011-07-04 16:20:00.577125	2011-07-04 16:23:52.348119	<math display='block'><mfrac><mrow><mi>x</mi><mo>+</mo><mn>4</mn></mrow><mrow><mn>2</mn><mo>&#8290;</mo><mi>x</mi></mrow></mfrac></math>
36	20	<math display='block'><mrow><mrow><mn>5</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mrow><mn>10</mn><mo>&#8290;</mo><mi>x</mi></mrow></mrow></math>	2011-07-04 16:28:36.920276	2011-07-04 16:28:36.920276	<math display='block'><mrow><mn>5</mn><mo>&#8290;</mo><mrow><mi>x</mi><mo>&#8289;</mo><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>2</mn></mrow><mo>)</mo></mrow></mrow></math>
37	21	\\[y = \\left ( x^{3}+7x-1 \\right ) \\left (5x + 2  \\right )\\]	2011-07-14 13:29:54.020934	2011-07-14 13:32:55.361806	\\[20x^{3} + 6x^{2} + 70x + 9\\]
38	22	\\[x + 3 = 5\\]	2011-07-28 09:40:42.546593	2011-07-28 09:42:17.787033	\\[x = 2\\]
39	22	\\[x + 5 = 9\\]	2011-07-28 09:41:08.717327	2011-07-28 09:42:46.120752	\\[x = 4\\]
40	22	\\[6 + x = 10\\]	2011-07-28 09:43:45.724751	2011-07-28 09:43:45.724751	\\[x = 4\\]
41	22	\\[12 = x + 7\\]	2011-07-28 09:44:41.866577	2011-07-28 09:44:41.866577	\\[5 = x\\]
42	22	\\[m + 4 = 9\\]	2011-07-28 09:53:23.155928	2011-07-28 09:53:23.155928	\\[m = 5\\]
43	23	\\[5 + a = 7\\]	2011-07-28 09:54:42.023068	2011-07-28 09:54:42.023068	\\[a = 2\\]
44	23	\\[4 + y = 5\\]	2011-07-28 09:55:59.907241	2011-07-28 09:55:59.907241	\\[y = 1\\]
\.


--
-- Data for Name: problem_levels; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY problem_levels (id, problem_type_id, level_number, created_at, updated_at) FROM stdin;
1	1	2	2011-05-03 19:10:31.475904	2011-07-04 23:57:09.338475
2	1	1	2011-05-03 19:10:31.483309	2011-07-04 23:58:17.640063
3	1	3	2011-05-03 19:10:31.486344	2011-05-03 19:10:31.486344
4	1	4	2011-05-03 19:10:31.489465	2011-05-03 19:10:31.489465
5	1	5	2011-05-03 19:10:31.494375	2011-05-03 19:10:31.494375
6	1	6	2011-05-03 19:10:31.505266	2011-05-03 19:10:31.505266
8	3	3	2011-05-03 19:10:31.510688	2011-05-03 19:10:31.510688
9	2	1	2011-05-03 22:45:34.053097	2011-05-03 22:45:34.053097
10	4	1	2011-05-04 16:27:48.016976	2011-05-04 16:27:48.016976
11	4	2	2011-05-04 16:28:44.318415	2011-05-04 16:28:44.318415
12	4	3	2011-05-04 16:29:39.588314	2011-05-04 16:29:39.588314
13	5	1	2011-06-03 02:52:28.613788	2011-06-03 02:52:28.613788
14	6	1	2011-06-20 20:48:42.76488	2011-06-20 20:48:42.76488
15	2	2	2011-06-21 09:30:34.33215	2011-06-21 09:30:34.33215
16	6	2	2011-06-21 22:48:16.531808	2011-06-21 22:48:16.531808
17	7	1	2011-06-21 22:56:53.84734	2011-06-21 22:56:53.84734
18	7	2	2011-06-21 23:29:15.995437	2011-06-21 23:29:15.995437
19	7	3	2011-06-21 23:30:26.068669	2011-06-21 23:30:26.068669
20	8	1	2011-07-04 16:28:36.916288	2011-07-04 16:28:36.916288
21	9	1	2011-07-14 13:29:53.920026	2011-07-14 13:29:53.920026
22	10	1	2011-07-28 09:40:42.524027	2011-07-28 09:40:42.524027
23	10	2	2011-07-28 09:54:42.020261	2011-07-28 09:54:42.020261
\.


--
-- Data for Name: problem_types; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY problem_types (id, instruction_id, created_at, updated_at, display_mode, title, permalink, owner_id, category_id) FROM stdin;
1	1	2011-05-03 19:10:31.432688	2011-07-09 10:32:22.832702	t	Monomial Fractions	monomial-fractions	1	9
2	2	2011-05-03 19:10:31.455778	2011-07-09 10:32:46.781318	f	Find GCF of Monomials	find-gcf-of-monomials	1	8
3	3	2011-05-03 19:10:31.460493	2011-07-09 10:33:04.822564	t	Quantity Monomial Fractions	quantity-monomial-fractions	1	9
4	4	2011-05-04 16:27:47.955369	2011-07-09 10:37:35.316978	t	Permutation Word Problem with Duplicate Letters	permutation-word-problem-with-duplicate-letters	1	2
5	4	2011-06-03 02:52:28.504803	2011-07-09 10:36:25.409592	t	Factor Polynomial and Simplify Fraction	factor-polynomial-and-simplify-fraction	1	9
6	4	2011-06-20 20:48:42.724036	2011-07-09 10:33:18.437593	t	Cost, Income, and Vaue Word Problems	cost-income-and-vaue-word-problems	1	3
7	5	2011-06-21 22:56:53.839379	2011-07-09 10:35:23.448254	t	Polynomial Fraction Simplification	polynomial-fraction-simplification	1	9
8	6	2011-07-04 16:28:36.912024	2011-07-09 10:35:59.292902	t	Factor Polynomials	factor-polynomials	2	8
9	7	2011-07-14 13:29:53.665834	2011-07-14 13:29:53.665834	t	Differentiation Using The Product Rule	differentiation-using-the-product-rule	2	11
10	8	2011-07-28 09:40:42.491155	2011-07-28 09:40:42.491155	t	Simple Equations: One Variable, Addition	simple-equations-one-variable-addition	2	3
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
20110504122003
20110515232512
20110517171058
20110605141049
20110702215214
20110703161223
20110704225902
20110705090118
20110708112600
20110710104842
20110719081623
20110719111515
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY subjects (id, title, created_at, updated_at) FROM stdin;
1	Algebra I	2011-05-03 19:10:31.25813	2011-07-07 09:24:31.387782
2	Geometry	2011-05-03 19:10:31.304325	2011-05-03 19:10:31.304325
3	Algebra II	2011-05-03 19:10:31.307877	2011-05-03 19:10:31.307877
4	Precalculus	2011-05-03 19:10:31.31366	2011-07-07 09:24:31.375397
5	Calculus	2011-05-03 19:10:31.317414	2011-05-03 19:10:31.317414
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
1	1	1	ProblemType	\N	\N	tags	2011-06-03 04:22:00.271152
2	2	5	ProblemType	\N	\N	tags	2011-06-04 04:15:25.821241
3	1	5	ProblemType	\N	\N	tags	2011-06-04 04:15:34.247495
4	3	5	ProblemType	\N	\N	tags	2011-06-04 04:15:46.808472
5	4	6	ProblemType	\N	\N	tags	2011-06-20 20:49:10.661558
6	5	6	ProblemType	\N	\N	tags	2011-06-20 20:49:18.472211
7	1	7	ProblemType	\N	\N	tags	2011-06-21 23:33:21.426626
8	2	7	ProblemType	\N	\N	tags	2011-06-21 23:33:33.001147
9	6	7	ProblemType	\N	\N	tags	2011-06-21 23:33:39.919861
10	7	6	ProblemType	\N	\N	tags	2011-07-01 16:33:58.877063
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY tags (id, name) FROM stdin;
1	Fractions
2	Monomial Factoring
3	Polynomials
4	Word Problems
5	Basic Algebra
6	Division
7	Single Variable
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
1	admin@rightrabbit.com	$2a$10$gKFXdYZkxFrC.u2tWjkpROJi6Ti.rWRY1bAVYG.3/dY1khBKtSRz2	\N	\N	\N	1	2011-07-04 16:02:43.003559	2011-07-04 16:02:43.003559	80.137.250.98	80.137.250.98	2011-07-04 15:48:47.21456	2011-07-04 16:02:43.00639
2	alexauritt@gmail.com	$2a$10$A1XU.3c0TOzD2w1BcviNr.vNYytsolWkMsHKlP8v3L3vNp8w7rKn6	\N	\N	\N	17	2011-07-29 16:53:32.832613	2011-07-29 16:51:13.651395	84.191.63.252	84.191.63.252	2011-07-04 16:03:17.396792	2011-07-29 16:53:32.834322
3	audrey_federman@yahoo.com	$2a$10$BeC1llyJV.cr6/Ywo11nC.h8dSXjdrXOmX0g4ry4VAoz7iRma79da	\N	\N	\N	1	2011-07-05 23:35:32.862924	2011-07-05 23:35:32.862924	80.137.224.39	80.137.224.39	2011-07-04 16:40:00.704632	2011-07-05 23:35:32.925882
\.


--
-- Data for Name: worksheet_problems; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY worksheet_problems (id, worksheet_id, math_problem_id, problem_number, created_at, updated_at) FROM stdin;
1	1	1	1	2011-05-03 19:10:31.703793	2011-05-03 19:10:31.703793
2	1	2	2	2011-05-03 19:10:31.714007	2011-05-03 19:10:31.714007
3	1	3	3	2011-05-03 19:10:31.719957	2011-07-27 10:43:53.466462
4	1	4	4	2011-05-03 19:10:31.725162	2011-07-27 10:43:42.06137
5	1	6	5	2011-05-03 19:10:31.730281	2011-07-27 10:43:40.281599
6	1	8	6	2011-05-03 19:10:31.746036	2011-07-27 10:43:48.445453
7	1	11	7	2011-05-03 19:10:31.764176	2011-07-27 10:43:46.665326
8	1	12	8	2011-05-03 19:10:31.769407	2011-07-27 10:43:45.233848
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
-- Name: core_lesson_problem_types_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY core_lesson_problem_types
    ADD CONSTRAINT core_lesson_problem_types_pkey PRIMARY KEY (id);


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
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: alexauritt; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: alexauritt; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


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

