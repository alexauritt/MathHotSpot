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
    answer_markup text,
    owner_id integer
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

SELECT pg_catalog.setval('math_problems_id_seq', 1010, true);


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

SELECT pg_catalog.setval('problem_levels_id_seq', 35, true);


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

SELECT pg_catalog.setval('problem_types_id_seq', 13, true);


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

COPY math_problems (id, problem_level_id, question_markup, created_at, updated_at, answer_markup, owner_id) FROM stdin;
795	27	\\[3 = y - 12\\]	2011-08-11 19:12:33.764856	2011-08-11 19:12:33.764856	\\[15 = y\\]	1
977	30	\\[y - 18.4 = 13.4\\]	2011-08-12 10:07:40.48139	2011-08-12 10:07:40.48139	\\[y = 31.8\\]	1
978	30	\\[25.8 = 5.9 + a\\]	2011-08-12 10:07:40.485208	2011-08-12 10:07:40.485208	\\[19.9 = a\\]	1
979	30	\\[k - 17 = 13\\]	2011-08-12 10:07:40.488754	2011-08-12 10:07:40.488754	\\[k = 30\\]	1
1	1	<math display="block"><mfrac><mrow><mn>-4</mn><mi>x</mi><mi>y</mi></mrow><mrow><mn>10</mn><mi>x</mi></mrow></mfrac></math>	2011-05-03 19:10:31.538236	2011-06-04 03:39:23.365932	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>5</mn>\r\n    <mn>6</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaI1aaabaGaaGOnaaaaaaa@2FA1@</annotation>\r\n </semantics>\r\n</math>\r\n	1
2	1	<math display="block"><mfrac><mrow><mn>-2</mn><mi>a</mi><mi>b</mi></mrow><mrow><mn>14</mn><mi>a</mi></mrow></mfrac></math>	2011-05-03 19:10:31.545926	2011-05-03 19:16:15.085969	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><mi>b</mi>\r\n    </mrow>\r\n    <mn>7</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaWGIbaabaGaaG4naaaaaaa@30B7@</annotation>\r\n </semantics>\r\n</math>\r\n	1
3	2	<math display="block"><mfrac><mrow><msup><mi>c</mi><mn>7</mn></msup></mrow><mrow><msup><mi>c</mi><mn>4</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.556673	2011-05-03 19:16:50.817582	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <msup>\r\n    <mi>c</mi>\r\n    <mn>3</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaam4yamaaCaaaleqabaGaaG4maaaaaaa@2FE4@</annotation>\r\n </semantics>\r\n</math>\r\n	1
4	2	<math display="block"><mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.559516	2011-05-03 19:17:24.648873	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>1</mn>\r\n    <mrow>\r\n     <msup>\r\n      <mi>a</mi>\r\n      <mn>5</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaIXaaabaGaamyyamaaCaaaleqabaGaaGynaaaaaaaaaa@30AF@</annotation>\r\n </semantics>\r\n</math>\r\n	1
5	2	<math display="block"><mfrac><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.56201	2011-05-03 19:18:26.868687	<math display='block'>\r\n <semantics>\r\n  <mn>1</mn>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaaGymaaaa@2ECD@</annotation>\r\n </semantics>\r\n</math>\r\n	1
17	8	<math display="block"><mfrac><mrow><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mfenced><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.652116	2011-06-04 03:55:08.807184	<math display='block'><mfrac><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfrac></math>	1
18	9	\\[ 3x^{2} \\text{ and } 9x^{3} \\]	2011-05-03 22:45:34.058796	2011-07-09 16:25:16.0926	\\[ 3x^{2} \\]	1
81	24	\\[5 + x = 9\\]	2011-08-11 18:21:24.5155	2011-08-11 18:21:24.5155	\\[x = 4\\]	1
980	30	\\[8.3 + y = 16.7\\]	2011-08-12 10:07:40.492073	2011-08-12 10:07:40.492073	\\[y = 8.4\\]	1
981	30	\\[y - 0 = 16\\]	2011-08-12 10:07:40.495378	2011-08-12 10:07:40.495378	\\[y = 16\\]	1
982	30	\\[11.9 = k + 6.7\\]	2011-08-12 10:07:40.499308	2011-08-12 10:07:40.499308	\\[5.2 = k\\]	1
983	30	\\[1.5 = w - 10.9\\]	2011-08-12 10:07:40.503387	2011-08-12 10:07:40.503387	\\[12.4 = w\\]	1
6	3	<math display="block"><mfrac><mrow><mn>12</mn><msup><mi>x</mi><mn>5</mn></msup></mrow><mrow><mn>-3</mn><msup><mi>x</mi><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.56451	2011-05-03 19:21:52.826693	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mn>5</mn><msup>\r\n    <mi>x</mi>\r\n    <mn>2</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaaGynaiaadIhadaahaaWcbeqaaiaaikdaaaaaaa@30B7@</annotation>\r\n </semantics>\r\n</math>\r\n	1
7	3	<math display="block"><mfrac><mrow><mn>-5</mn><msup><mi>k</mi><mn>4</mn></msup></mrow><mrow><mn>20</mn><mi>k</mi></mrow></mfrac></math>	2011-05-03 19:10:31.567118	2011-05-03 19:22:31.615545	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><msup>\r\n      <mi>k</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mn>4</mn>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaWGRbWaaWbaaSqabeaacaaIZaaaaaGcbaGaaGinaaaaaaa@31B1@</annotation>\r\n </semantics>\r\n</math>\r\n	1
8	4	<math display="block"><mfrac><mrow><mi>m</mi><msup><mi>n</mi><mn>5</mn></msup></mrow><mrow><msup><mi>m</mi><mn>3</mn></msup><msup><mi>n</mi><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.597407	2011-05-03 19:29:16.595266	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <msup>\r\n      <mi>n</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>m</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWGUbWaaWbaaSqabeaacaaIZaaaaaGcbaGaamyBamaaCaaaleqabaGaaGOmaaaaaaaaaa@31E4@</annotation>\r\n </semantics>\r\n</math>\r\n	1
9	4	<math display="block"><mfrac><mrow><msup><mi>x</mi><mn>5</mn></msup><msup><mi>y</mi><mn>4</mn></msup></mrow><mrow><mi>x</mi><msup><mi>y</mi><mn>10</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.600705	2011-05-03 19:29:49.184525	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <msup>\r\n      <mi>x</mi>\r\n      <mn>4</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>y</mi>\r\n      <mn>6</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWG4bWaaWbaaSqabeaacaaI0aaaaaGcbaGaamyEamaaCaaaleqabaGaaGOnaaaaaaaaaa@31FF@</annotation>\r\n </semantics>\r\n</math>\r\n	1
10	5	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>5</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.604258	2011-05-03 19:30:41.423882	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <msup>\r\n    <mi>k</mi>\r\n    <mn>2</mn>\r\n   </msup>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaGaam4AamaaCaaaleqabaGaaGOmaaaaaaa@2FEB@</annotation>\r\n </semantics>\r\n</math>\r\n	1
131	25	\\[3 = y - 0\\]	2011-08-11 18:23:01.76779	2011-08-11 18:23:01.76779	\\[3 = y\\]	1
132	25	\\[x - 1 = 4\\]	2011-08-11 18:23:01.77107	2011-08-11 18:23:01.77107	\\[x = 5\\]	1
133	25	\\[4 = x - 0\\]	2011-08-11 18:23:01.774729	2011-08-11 18:23:01.774729	\\[4 = x\\]	1
134	25	\\[x - 1 = 2\\]	2011-08-11 18:23:01.780073	2011-08-11 18:23:01.780073	\\[x = 3\\]	1
11	5	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>3</mn><mi>x</mi></mrow></mfenced><mn>2</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>x</mi></mrow></mfenced><mn>4</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.607551	2011-05-03 19:32:07.890869	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>9</mn>\r\n    <mrow>\r\n     <mn>16</mn><msup>\r\n      <mi>x</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaI5aaabaGaaGymaiaaiAdacaWG4bWaaWbaaSqabeaacaaIYaaaaaaaaaa@3246@</annotation>\r\n </semantics>\r\n</math>\r\n	1
12	6	<math display="block"><mfrac><mrow><mo>-</mo><mfenced><mrow><msup><mi>m</mi><mn>3</mn></msup><mi>n</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>m</mi><mi>n</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.610912	2011-05-03 19:34:03.14447	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mn>1</mn>\r\n    <mrow>\r\n     <msup>\r\n      <mi>n</mi>\r\n      <mn>2</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaaIXaaabaGaamOBamaaCaaaleqabaGaaGOmaaaaaaaaaa@30B9@</annotation>\r\n </semantics>\r\n</math>\r\n	1
13	6	<math display="block"><mfrac><mrow><msup><mfenced><mi>-x</mi></mfenced><mn>2</mn></msup><mi>y</mi></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>x</mi><mi>y</mi></mrow></mfenced><mn>5</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.613912	2011-05-03 19:35:40.494852	<math display='block'>\r\n <semantics>\r\n  <mrow>\r\n   <mfrac>\r\n    <mrow>\r\n     <mo>&#x2212;</mo><mn>1</mn>\r\n    </mrow>\r\n    <mrow>\r\n     <msup>\r\n      <mi>x</mi>\r\n      <mn>3</mn>\r\n     </msup>\r\n     <msup>\r\n      <mi>y</mi>\r\n      <mn>4</mn>\r\n     </msup>\r\n     \r\n    </mrow>\r\n   </mfrac>\r\n   \r\n  </mrow>\r\n <annotation encoding='MathType-MTEF'>\r\n MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacqGHsislcaaIXaaabaGaamiEamaaCaaaleqabaGaaG4maaaakiaadMhadaahaaWcbeqaaiaaisdaaaaaaaaa@33A4@</annotation>\r\n </semantics>\r\n</math>\r\n	1
14	15	\\[ 72x^{3}yz^{3} \\text{ and } 120x^{2}z^{5} \\]	2011-05-03 19:10:31.617328	2011-07-09 16:28:52.378519	\\[24x^{2}z^{3}\\]	1
15	15	\\[4p^{2}\\left ( p-1 \\right ) \\text{ and } 6p\\left (p+1 \\right)^{2}\\]	2011-05-03 19:10:31.645565	2011-07-09 16:32:33.310024	\\[2p\\]	1
16	8	<math display="block"><mfrac><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>3</mn></msup></mrow><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>	2011-05-03 19:10:31.649005	2011-06-04 03:54:36.991026	<math display='block'><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></math>	1
19	10	How many different words can be formed using all the letters in the word REARRANGE?	2011-05-04 16:27:48.042824	2011-05-04 17:04:30.472905	15,120	1
20	11	How many different committees of 3 people can be formed from a pool of 7 people?	2011-05-04 16:28:44.322059	2011-05-04 16:28:44.322059	35	1
21	12	In how many different ways can a committee of 2 faculty members and 3 students be formed if 6 faculty members and 10 students are eligible to serve on the committee?	2011-05-04 16:29:39.58991	2011-05-04 16:29:39.58991	18000	1
22	10	How many different 9-letter words (real or imaginary) can be formed from the letters in the word ECONOMICS?	2011-05-04 17:04:19.722813	2011-05-04 17:04:19.722813	90,720	1
24	13	<math display='block'><mfrac><msup><mi>x</mi><mn>2</mn></msup><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>4</mn></msup></mrow><mo>+</mo><mrow><mn>2</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></mrow></mfrac></math>	2011-06-03 02:52:28.643694	2011-06-04 04:19:17.420707	<math display='block'><mfrac><mn>1</mn><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mn>2</mn></mrow></mfrac></math>	1
25	14	Tickets for the play cost $6 for grown-ups and $3 for children. 846 tickets were sold for a total cash value of $3846. How many child tickets were sold?	2011-06-20 20:48:42.812331	2011-06-20 20:48:42.812331	410 child tickets were sold.	1
26	14	Mary makes $5/hr working during the week, and $6/hr working on weekends. In May she made $64.50 by working a total of 12 hours. How many hours did she make working on weekends in May?	2011-06-20 20:51:06.391392	2011-06-21 22:43:12.207802	4.5 hours on the weekends.	1
28	16	Jim bought 100 postage stamps, worth $9.40 in total. Half of them where $0.01 stamps, and the rest were $0.14 and $0.22 stamps. How many $0.22 stamps did he buy?	2011-06-21 22:48:16.540375	2011-06-21 22:48:16.540375	30 stamps.	1
29	14	Thirty students bought posters to support the yearbook. Small posters cost $4 each, and large posters cost $8 each. If the total cost of all posters was $168, how many students bought large posters?	2011-06-21 22:50:48.74252	2011-06-21 22:50:48.74252	12 students.	1
30	14	Fred bought candybars; he paid $1.50 for each one. He sold all but 20 of them for $3 each and he made a profit of $15. How many candy bars did he buy?	2011-06-21 22:53:06.472724	2011-06-21 22:53:06.472724	50 candy bars.	1
31	17	<math display='block'><mfrac><mrow><mrow><mn>5</mn><mo>&#8290;</mo><mi>m</mi></mrow><mo>+</mo><mn>35</mn></mrow><mrow><mn>5</mn></mrow></mfrac></math>	2011-06-21 22:56:53.85072	2011-06-21 23:27:44.140475	<math display='block'><mrow><mi>m</mi><mo>+</mo><mn>7</mn></mrow></math>	1
32	18	<math display='block'><mfrac><mrow><mrow><mn>26</mn><mo>&#8290;</mo><mi>xy</mi></mrow><mo>-</mo><mrow><mn>39</mn><mo>&#8290;</mo><mi>y</mi></mrow></mrow><mrow><mn>13</mn><mo>&#8290;</mo><mi>y</mi></mrow></mfrac></math>	2011-06-21 23:29:16.008733	2011-06-21 23:29:16.008733	<math display='block'><mrow><mrow><mn>2</mn><mo>&#8290;</mo><mi>x</mi></mrow><mo>-</mo><mi>y</mi></mrow></math>	1
33	19	<math display='block'><mrow><mfrac><mrow><mrow><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>4</mn></msup></mrow><mo>-</mo><mrow><mn>9</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>3</mn></msup><mo>&#8290;</mo><mi>y</mi></mrow><mo>+</mo><mrow><mn>6</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup><mo>&#8290;</mo><msup><mi>y</mi><mn>2</mn></msup></mrow></mrow><mrow><mo>-</mo><mn>3</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></mfrac></mrow></math>	2011-06-21 23:30:26.072071	2011-06-21 23:31:56.185436	<math display='block'><mrow><mrow><mo>-</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mrow><mn>3</mn><mo>&#8290;</mo><mi>xy</mi></mrow><mo>-</mo><mrow><mn>2</mn><mo>&#8290;</mo><msup><mi>y</mi><mn>2</mn></msup></mrow></mrow></math>	1
135	25	\\[1 = x - 4\\]	2011-08-11 18:23:01.783751	2011-08-11 18:23:01.783751	\\[5 = x\\]	1
136	25	\\[x - 7 = 1\\]	2011-08-11 18:23:01.787317	2011-08-11 18:23:01.787317	\\[x = 8\\]	1
35	17	<math display='block'><mfrac><mrow><mrow><mn>7</mn><mo>&#8290;</mo><mi>x</mi></mrow><mo>+</mo><mn>28</mn></mrow><mrow><mn>14</mn><mo>&#8290;</mo><mi>x</mi></mrow></mfrac></math>	2011-07-04 16:20:00.577125	2011-07-04 16:23:52.348119	<math display='block'><mfrac><mrow><mi>x</mi><mo>+</mo><mn>4</mn></mrow><mrow><mn>2</mn><mo>&#8290;</mo><mi>x</mi></mrow></mfrac></math>	1
36	20	<math display='block'><mrow><mrow><mn>5</mn><mo>&#8290;</mo><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mrow><mn>10</mn><mo>&#8290;</mo><mi>x</mi></mrow></mrow></math>	2011-07-04 16:28:36.920276	2011-07-04 16:28:36.920276	<math display='block'><mrow><mn>5</mn><mo>&#8290;</mo><mrow><mi>x</mi><mo>&#8289;</mo><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>2</mn></mrow><mo>)</mo></mrow></mrow></math>	1
37	21	\\[y = \\left ( x^{3}+7x-1 \\right ) \\left (5x + 2  \\right )\\]	2011-07-14 13:29:54.020934	2011-07-14 13:32:55.361806	\\[20x^{3} + 6x^{2} + 70x + 9\\]	1
45	24	\\[a + 5 = 6\\]	2011-08-11 18:21:24.332101	2011-08-11 18:21:24.332101	\\[a = 1\\]	1
46	24	\\[4 = y + 3\\]	2011-08-11 18:21:24.385301	2011-08-11 18:21:24.385301	\\[1 = y\\]	1
47	24	\\[2 + x = 2\\]	2011-08-11 18:21:24.389013	2011-08-11 18:21:24.389013	\\[x = 0\\]	1
48	24	\\[5 = 0 + k\\]	2011-08-11 18:21:24.392608	2011-08-11 18:21:24.392608	\\[5 = k\\]	1
49	24	\\[4 + y = 5\\]	2011-08-11 18:21:24.397418	2011-08-11 18:21:24.397418	\\[y = 1\\]	1
50	24	\\[9 = 9 + x\\]	2011-08-11 18:21:24.401208	2011-08-11 18:21:24.401208	\\[0 = x\\]	1
51	24	\\[3 = y + 2\\]	2011-08-11 18:21:24.404496	2011-08-11 18:21:24.404496	\\[1 = y\\]	1
52	24	\\[6 + x = 9\\]	2011-08-11 18:21:24.408695	2011-08-11 18:21:24.408695	\\[x = 3\\]	1
53	24	\\[4 = 1 + y\\]	2011-08-11 18:21:24.412002	2011-08-11 18:21:24.412002	\\[3 = y\\]	1
54	24	\\[5 = 2 + y\\]	2011-08-11 18:21:24.415619	2011-08-11 18:21:24.415619	\\[3 = y\\]	1
55	24	\\[9 = 4 + y\\]	2011-08-11 18:21:24.419989	2011-08-11 18:21:24.419989	\\[5 = y\\]	1
56	24	\\[0 + w = 6\\]	2011-08-11 18:21:24.423529	2011-08-11 18:21:24.423529	\\[w = 6\\]	1
57	24	\\[7 = x + 0\\]	2011-08-11 18:21:24.427058	2011-08-11 18:21:24.427058	\\[7 = x\\]	1
58	24	\\[x + 0 = 2\\]	2011-08-11 18:21:24.430687	2011-08-11 18:21:24.430687	\\[x = 2\\]	1
59	24	\\[y + 0 = 1\\]	2011-08-11 18:21:24.434171	2011-08-11 18:21:24.434171	\\[y = 1\\]	1
60	24	\\[3 = 3 + x\\]	2011-08-11 18:21:24.437853	2011-08-11 18:21:24.437853	\\[0 = x\\]	1
61	24	\\[3 = w + 1\\]	2011-08-11 18:21:24.441897	2011-08-11 18:21:24.441897	\\[2 = w\\]	1
62	24	\\[x + 0 = 8\\]	2011-08-11 18:21:24.445241	2011-08-11 18:21:24.445241	\\[x = 8\\]	1
63	24	\\[a + 0 = 4\\]	2011-08-11 18:21:24.448536	2011-08-11 18:21:24.448536	\\[a = 4\\]	1
64	24	\\[6 = 6 + y\\]	2011-08-11 18:21:24.451947	2011-08-11 18:21:24.451947	\\[0 = y\\]	1
65	24	\\[2 + w = 4\\]	2011-08-11 18:21:24.455878	2011-08-11 18:21:24.455878	\\[w = 2\\]	1
66	24	\\[9 = 1 + x\\]	2011-08-11 18:21:24.459179	2011-08-11 18:21:24.459179	\\[8 = x\\]	1
67	24	\\[1 + x = 8\\]	2011-08-11 18:21:24.462508	2011-08-11 18:21:24.462508	\\[x = 7\\]	1
68	24	\\[7 = 5 + w\\]	2011-08-11 18:21:24.46644	2011-08-11 18:21:24.46644	\\[2 = w\\]	1
69	24	\\[2 = x + 1\\]	2011-08-11 18:21:24.469749	2011-08-11 18:21:24.469749	\\[1 = x\\]	1
70	24	\\[6 = 3 + x\\]	2011-08-11 18:21:24.474666	2011-08-11 18:21:24.474666	\\[3 = x\\]	1
71	24	\\[7 + w = 8\\]	2011-08-11 18:21:24.478444	2011-08-11 18:21:24.478444	\\[w = 1\\]	1
72	24	\\[9 = 7 + y\\]	2011-08-11 18:21:24.482089	2011-08-11 18:21:24.482089	\\[2 = y\\]	1
73	24	\\[3 + w = 7\\]	2011-08-11 18:21:24.486038	2011-08-11 18:21:24.486038	\\[w = 4\\]	1
74	24	\\[y + 3 = 5\\]	2011-08-11 18:21:24.489924	2011-08-11 18:21:24.489924	\\[y = 2\\]	1
75	24	\\[9 = 0 + x\\]	2011-08-11 18:21:24.493555	2011-08-11 18:21:24.493555	\\[9 = x\\]	1
76	24	\\[9 = 3 + a\\]	2011-08-11 18:21:24.496811	2011-08-11 18:21:24.496811	\\[6 = a\\]	1
77	24	\\[0 = m + 0\\]	2011-08-11 18:21:24.501543	2011-08-11 18:21:24.501543	\\[0 = m\\]	1
78	24	\\[4 = y + 4\\]	2011-08-11 18:21:24.504941	2011-08-11 18:21:24.504941	\\[0 = y\\]	1
79	24	\\[w + 1 = 6\\]	2011-08-11 18:21:24.508253	2011-08-11 18:21:24.508253	\\[w = 5\\]	1
80	24	\\[x + 2 = 7\\]	2011-08-11 18:21:24.512181	2011-08-11 18:21:24.512181	\\[x = 5\\]	1
82	24	\\[6 = m + 2\\]	2011-08-11 18:21:24.520567	2011-08-11 18:21:24.520567	\\[4 = m\\]	1
83	24	\\[2 + x = 9\\]	2011-08-11 18:21:24.524237	2011-08-11 18:21:24.524237	\\[x = 7\\]	1
84	24	\\[6 + x = 8\\]	2011-08-11 18:21:24.527661	2011-08-11 18:21:24.527661	\\[x = 2\\]	1
85	24	\\[x + 1 = 5\\]	2011-08-11 18:21:24.531066	2011-08-11 18:21:24.531066	\\[x = 4\\]	1
86	24	\\[5 + m = 8\\]	2011-08-11 18:21:24.53533	2011-08-11 18:21:24.53533	\\[m = 3\\]	1
87	24	\\[3 + w = 8\\]	2011-08-11 18:21:24.538952	2011-08-11 18:21:24.538952	\\[w = 5\\]	1
88	24	\\[k + 1 = 1\\]	2011-08-11 18:21:24.54245	2011-08-11 18:21:24.54245	\\[k = 0\\]	1
89	24	\\[3 = 0 + x\\]	2011-08-11 18:21:24.546577	2011-08-11 18:21:24.546577	\\[3 = x\\]	1
90	24	\\[6 = x + 4\\]	2011-08-11 18:21:24.550051	2011-08-11 18:21:24.550051	\\[2 = x\\]	1
91	24	\\[6 + m = 7\\]	2011-08-11 18:21:24.553467	2011-08-11 18:21:24.553467	\\[m = 1\\]	1
92	24	\\[8 = w + 8\\]	2011-08-11 18:21:24.556744	2011-08-11 18:21:24.556744	\\[0 = w\\]	1
93	24	\\[9 = x + 8\\]	2011-08-11 18:21:24.560694	2011-08-11 18:21:24.560694	\\[1 = x\\]	1
94	24	\\[8 = 4 + x\\]	2011-08-11 18:21:24.610482	2011-08-11 18:21:24.610482	\\[4 = x\\]	1
95	24	\\[1 + y = 7\\]	2011-08-11 18:21:24.614064	2011-08-11 18:21:24.614064	\\[y = 6\\]	1
96	24	\\[m + 2 = 8\\]	2011-08-11 18:21:24.618751	2011-08-11 18:21:24.618751	\\[m = 6\\]	1
97	24	\\[7 = x + 4\\]	2011-08-11 18:21:24.622669	2011-08-11 18:21:24.622669	\\[3 = x\\]	1
98	24	\\[7 + x = 7\\]	2011-08-11 18:21:24.626257	2011-08-11 18:21:24.626257	\\[x = 0\\]	1
99	24	\\[x + 5 = 5\\]	2011-08-11 18:21:24.629587	2011-08-11 18:21:24.629587	\\[x = 0\\]	1
100	25	\\[4 = x - 5\\]	2011-08-11 18:23:01.623524	2011-08-11 18:23:01.623524	\\[9 = x\\]	1
101	25	\\[x - 3 = 0\\]	2011-08-11 18:23:01.654599	2011-08-11 18:23:01.654599	\\[x = 3\\]	1
102	25	\\[y - 0 = 0\\]	2011-08-11 18:23:01.658502	2011-08-11 18:23:01.658502	\\[y = 0\\]	1
103	25	\\[w - 2 = 6\\]	2011-08-11 18:23:01.662246	2011-08-11 18:23:01.662246	\\[w = 8\\]	1
104	25	\\[1 = y - 2\\]	2011-08-11 18:23:01.666371	2011-08-11 18:23:01.666371	\\[3 = y\\]	1
105	25	\\[5 = a - 1\\]	2011-08-11 18:23:01.669768	2011-08-11 18:23:01.669768	\\[6 = a\\]	1
106	25	\\[x - 2 = 3\\]	2011-08-11 18:23:01.673715	2011-08-11 18:23:01.673715	\\[x = 5\\]	1
107	25	\\[x - 0 = 6\\]	2011-08-11 18:23:01.677128	2011-08-11 18:23:01.677128	\\[x = 6\\]	1
108	25	\\[m - 1 = 7\\]	2011-08-11 18:23:01.681086	2011-08-11 18:23:01.681086	\\[m = 8\\]	1
109	25	\\[3 = w - 3\\]	2011-08-11 18:23:01.684594	2011-08-11 18:23:01.684594	\\[6 = w\\]	1
110	25	\\[a - 9 = 0\\]	2011-08-11 18:23:01.688483	2011-08-11 18:23:01.688483	\\[a = 9\\]	1
111	25	\\[3 = k - 1\\]	2011-08-11 18:23:01.692294	2011-08-11 18:23:01.692294	\\[4 = k\\]	1
112	25	\\[x - 4 = 5\\]	2011-08-11 18:23:01.695907	2011-08-11 18:23:01.695907	\\[x = 9\\]	1
113	25	\\[1 = a - 5\\]	2011-08-11 18:23:01.699709	2011-08-11 18:23:01.699709	\\[6 = a\\]	1
114	25	\\[y - 3 = 4\\]	2011-08-11 18:23:01.702948	2011-08-11 18:23:01.702948	\\[y = 7\\]	1
115	25	\\[y - 0 = 9\\]	2011-08-11 18:23:01.706916	2011-08-11 18:23:01.706916	\\[y = 9\\]	1
116	25	\\[3 = y - 4\\]	2011-08-11 18:23:01.710231	2011-08-11 18:23:01.710231	\\[7 = y\\]	1
117	25	\\[8 = k - 0\\]	2011-08-11 18:23:01.714208	2011-08-11 18:23:01.714208	\\[8 = k\\]	1
118	25	\\[2 = x - 5\\]	2011-08-11 18:23:01.718474	2011-08-11 18:23:01.718474	\\[7 = x\\]	1
119	25	\\[x - 8 = 1\\]	2011-08-11 18:23:01.72188	2011-08-11 18:23:01.72188	\\[x = 9\\]	1
120	25	\\[y - 1 = 0\\]	2011-08-11 18:23:01.725997	2011-08-11 18:23:01.725997	\\[y = 1\\]	1
121	25	\\[y - 6 = 3\\]	2011-08-11 18:23:01.730402	2011-08-11 18:23:01.730402	\\[y = 9\\]	1
122	25	\\[m - 8 = 0\\]	2011-08-11 18:23:01.734011	2011-08-11 18:23:01.734011	\\[m = 8\\]	1
123	25	\\[a - 2 = 0\\]	2011-08-11 18:23:01.737745	2011-08-11 18:23:01.737745	\\[a = 2\\]	1
124	25	\\[x - 3 = 2\\]	2011-08-11 18:23:01.742202	2011-08-11 18:23:01.742202	\\[x = 5\\]	1
125	25	\\[2 = w - 0\\]	2011-08-11 18:23:01.746008	2011-08-11 18:23:01.746008	\\[2 = w\\]	1
126	25	\\[a - 1 = 6\\]	2011-08-11 18:23:01.74951	2011-08-11 18:23:01.74951	\\[a = 7\\]	1
127	25	\\[y - 0 = 1\\]	2011-08-11 18:23:01.753715	2011-08-11 18:23:01.753715	\\[y = 1\\]	1
128	25	\\[0 = k - 7\\]	2011-08-11 18:23:01.757003	2011-08-11 18:23:01.757003	\\[7 = k\\]	1
129	25	\\[w - 5 = 3\\]	2011-08-11 18:23:01.76039	2011-08-11 18:23:01.76039	\\[w = 8\\]	1
130	25	\\[4 = y - 4\\]	2011-08-11 18:23:01.763596	2011-08-11 18:23:01.763596	\\[8 = y\\]	1
137	25	\\[1 = x - 3\\]	2011-08-11 18:23:01.791474	2011-08-11 18:23:01.791474	\\[4 = x\\]	1
138	25	\\[2 = x - 2\\]	2011-08-11 18:23:01.795183	2011-08-11 18:23:01.795183	\\[4 = x\\]	1
139	25	\\[0 = k - 4\\]	2011-08-11 18:23:01.79937	2011-08-11 18:23:01.79937	\\[4 = k\\]	1
140	25	\\[1 = k - 1\\]	2011-08-11 18:23:01.802891	2011-08-11 18:23:01.802891	\\[2 = k\\]	1
141	25	\\[a - 6 = 0\\]	2011-08-11 18:23:01.806136	2011-08-11 18:23:01.806136	\\[a = 6\\]	1
142	25	\\[5 = x - 3\\]	2011-08-11 18:23:01.809409	2011-08-11 18:23:01.809409	\\[8 = x\\]	1
143	25	\\[a - 0 = 5\\]	2011-08-11 18:23:01.813625	2011-08-11 18:23:01.813625	\\[a = 5\\]	1
144	25	\\[m - 2 = 5\\]	2011-08-11 18:23:01.816981	2011-08-11 18:23:01.816981	\\[m = 7\\]	1
145	25	\\[y - 1 = 8\\]	2011-08-11 18:23:01.820336	2011-08-11 18:23:01.820336	\\[y = 9\\]	1
146	25	\\[a - 7 = 2\\]	2011-08-11 18:23:01.824331	2011-08-11 18:23:01.824331	\\[a = 9\\]	1
147	25	\\[7 = k - 0\\]	2011-08-11 18:23:01.82773	2011-08-11 18:23:01.82773	\\[7 = k\\]	1
148	25	\\[2 = x - 6\\]	2011-08-11 18:23:01.832368	2011-08-11 18:23:01.832368	\\[8 = x\\]	1
149	25	\\[0 = x - 5\\]	2011-08-11 18:23:01.881543	2011-08-11 18:23:01.881543	\\[5 = x\\]	1
150	25	\\[4 = a - 2\\]	2011-08-11 18:23:01.885137	2011-08-11 18:23:01.885137	\\[6 = a\\]	1
151	25	\\[1 = m - 6\\]	2011-08-11 18:23:01.888941	2011-08-11 18:23:01.888941	\\[7 = m\\]	1
152	25	\\[7 = y - 2\\]	2011-08-11 18:23:01.893703	2011-08-11 18:23:01.893703	\\[9 = y\\]	1
153	25	\\[6 = a - 3\\]	2011-08-11 18:23:01.897621	2011-08-11 18:23:01.897621	\\[9 = a\\]	1
154	25	\\[2 = m - 4\\]	2011-08-11 18:23:01.901396	2011-08-11 18:23:01.901396	\\[6 = m\\]	1
155	26	\\[14 + x = 36\\]	2011-08-11 18:23:14.951674	2011-08-11 18:23:14.951674	\\[x = 22\\]	1
156	26	\\[32 = x + 10\\]	2011-08-11 18:23:14.982603	2011-08-11 18:23:14.982603	\\[22 = x\\]	1
157	26	\\[m + 17 = 26\\]	2011-08-11 18:23:14.987951	2011-08-11 18:23:14.987951	\\[m = 9\\]	1
158	26	\\[19 + x = 33\\]	2011-08-11 18:23:14.991563	2011-08-11 18:23:14.991563	\\[x = 14\\]	1
159	26	\\[28 = 14 + x\\]	2011-08-11 18:23:14.994847	2011-08-11 18:23:14.994847	\\[14 = x\\]	1
160	26	\\[14 = x + 4\\]	2011-08-11 18:23:14.998724	2011-08-11 18:23:14.998724	\\[10 = x\\]	1
161	26	\\[30 = 20 + k\\]	2011-08-11 18:23:15.002543	2011-08-11 18:23:15.002543	\\[10 = k\\]	1
162	26	\\[28 = k + 11\\]	2011-08-11 18:23:15.005923	2011-08-11 18:23:15.005923	\\[17 = k\\]	1
163	26	\\[37 = m + 16\\]	2011-08-11 18:23:15.009435	2011-08-11 18:23:15.009435	\\[21 = m\\]	1
164	26	\\[y + 9 = 21\\]	2011-08-11 18:23:15.013192	2011-08-11 18:23:15.013192	\\[y = 12\\]	1
165	26	\\[15 = 4 + w\\]	2011-08-11 18:23:15.016844	2011-08-11 18:23:15.016844	\\[11 = w\\]	1
166	26	\\[y + 11 = 30\\]	2011-08-11 18:23:15.020371	2011-08-11 18:23:15.020371	\\[y = 19\\]	1
167	26	\\[18 + x = 34\\]	2011-08-11 18:23:15.024454	2011-08-11 18:23:15.024454	\\[x = 16\\]	1
168	26	\\[x + 12 = 32\\]	2011-08-11 18:23:15.027737	2011-08-11 18:23:15.027737	\\[x = 20\\]	1
169	26	\\[32 = 19 + k\\]	2011-08-11 18:23:15.030928	2011-08-11 18:23:15.030928	\\[13 = k\\]	1
170	26	\\[k + 10 = 24\\]	2011-08-11 18:23:15.034866	2011-08-11 18:23:15.034866	\\[k = 14\\]	1
171	26	\\[y + 5 = 22\\]	2011-08-11 18:23:15.038149	2011-08-11 18:23:15.038149	\\[y = 17\\]	1
172	26	\\[x + 14 = 29\\]	2011-08-11 18:23:15.041387	2011-08-11 18:23:15.041387	\\[x = 15\\]	1
173	26	\\[15 + w = 29\\]	2011-08-11 18:23:15.044602	2011-08-11 18:23:15.044602	\\[w = 14\\]	1
174	26	\\[36 = 15 + w\\]	2011-08-11 18:23:15.049146	2011-08-11 18:23:15.049146	\\[21 = w\\]	1
175	26	\\[18 = 7 + k\\]	2011-08-11 18:23:15.053573	2011-08-11 18:23:15.053573	\\[11 = k\\]	1
176	26	\\[33 = m + 11\\]	2011-08-11 18:23:15.057444	2011-08-11 18:23:15.057444	\\[22 = m\\]	1
177	26	\\[32 = 11 + x\\]	2011-08-11 18:23:15.061016	2011-08-11 18:23:15.061016	\\[21 = x\\]	1
178	26	\\[y + 17 = 28\\]	2011-08-11 18:23:15.064866	2011-08-11 18:23:15.064866	\\[y = 11\\]	1
179	26	\\[29 = k + 11\\]	2011-08-11 18:23:15.069094	2011-08-11 18:23:15.069094	\\[18 = k\\]	1
180	26	\\[m + 13 = 23\\]	2011-08-11 18:23:15.072774	2011-08-11 18:23:15.072774	\\[m = 10\\]	1
181	26	\\[3 + a = 18\\]	2011-08-11 18:23:15.076134	2011-08-11 18:23:15.076134	\\[a = 15\\]	1
182	26	\\[31 = 13 + y\\]	2011-08-11 18:23:15.079779	2011-08-11 18:23:15.079779	\\[18 = y\\]	1
183	26	\\[13 + x = 28\\]	2011-08-11 18:23:15.08405	2011-08-11 18:23:15.08405	\\[x = 15\\]	1
184	26	\\[3 + k = 23\\]	2011-08-11 18:23:15.087437	2011-08-11 18:23:15.087437	\\[k = 20\\]	1
185	26	\\[31 = y + 17\\]	2011-08-11 18:23:15.091026	2011-08-11 18:23:15.091026	\\[14 = y\\]	1
186	26	\\[12 + a = 23\\]	2011-08-11 18:23:15.095183	2011-08-11 18:23:15.095183	\\[a = 11\\]	1
187	26	\\[35 = 14 + m\\]	2011-08-11 18:23:15.0994	2011-08-11 18:23:15.0994	\\[21 = m\\]	1
188	26	\\[y + 9 = 29\\]	2011-08-11 18:23:15.102951	2011-08-11 18:23:15.102951	\\[y = 20\\]	1
189	26	\\[a + 10 = 31\\]	2011-08-11 18:23:15.106497	2011-08-11 18:23:15.106497	\\[a = 21\\]	1
190	26	\\[x + 8 = 18\\]	2011-08-11 18:23:15.110114	2011-08-11 18:23:15.110114	\\[x = 10\\]	1
191	26	\\[27 = k + 13\\]	2011-08-11 18:23:15.113895	2011-08-11 18:23:15.113895	\\[14 = k\\]	1
192	26	\\[y + 18 = 39\\]	2011-08-11 18:23:15.117428	2011-08-11 18:23:15.117428	\\[y = 21\\]	1
193	26	\\[3 + x = 22\\]	2011-08-11 18:23:15.120954	2011-08-11 18:23:15.120954	\\[x = 19\\]	1
194	26	\\[k + 10 = 22\\]	2011-08-11 18:23:15.124293	2011-08-11 18:23:15.124293	\\[k = 12\\]	1
195	26	\\[19 + k = 41\\]	2011-08-11 18:23:15.1283	2011-08-11 18:23:15.1283	\\[k = 22\\]	1
196	26	\\[y + 19 = 28\\]	2011-08-11 18:23:15.131618	2011-08-11 18:23:15.131618	\\[y = 9\\]	1
197	26	\\[11 + x = 25\\]	2011-08-11 18:23:15.134995	2011-08-11 18:23:15.134995	\\[x = 14\\]	1
198	26	\\[22 = x + 4\\]	2011-08-11 18:23:15.139007	2011-08-11 18:23:15.139007	\\[18 = x\\]	1
199	26	\\[y + 7 = 29\\]	2011-08-11 18:23:15.142327	2011-08-11 18:23:15.142327	\\[y = 22\\]	1
200	26	\\[31 = 18 + a\\]	2011-08-11 18:23:15.145687	2011-08-11 18:23:15.145687	\\[13 = a\\]	1
201	26	\\[x + 8 = 30\\]	2011-08-11 18:23:15.149072	2011-08-11 18:23:15.149072	\\[x = 22\\]	1
202	26	\\[k + 4 = 12\\]	2011-08-11 18:23:15.153951	2011-08-11 18:23:15.153951	\\[k = 8\\]	1
203	26	\\[k + 6 = 15\\]	2011-08-11 18:23:15.209069	2011-08-11 18:23:15.209069	\\[k = 9\\]	1
204	26	\\[x + 18 = 27\\]	2011-08-11 18:23:15.216156	2011-08-11 18:23:15.216156	\\[x = 9\\]	1
205	26	\\[7 + y = 17\\]	2011-08-11 18:23:15.235468	2011-08-11 18:23:15.235468	\\[y = 10\\]	1
206	26	\\[15 = 7 + a\\]	2011-08-11 18:23:15.24361	2011-08-11 18:23:15.24361	\\[8 = a\\]	1
207	26	\\[5 + x = 19\\]	2011-08-11 18:23:15.260788	2011-08-11 18:23:15.260788	\\[x = 14\\]	1
208	26	\\[x + 17 = 25\\]	2011-08-11 18:23:15.264884	2011-08-11 18:23:15.264884	\\[x = 8\\]	1
209	26	\\[k + 17 = 33\\]	2011-08-11 18:23:15.269115	2011-08-11 18:23:15.269115	\\[k = 16\\]	1
210	26	\\[m + 3 = 24\\]	2011-08-11 18:23:15.272768	2011-08-11 18:23:15.272768	\\[m = 21\\]	1
211	26	\\[y + 4 = 25\\]	2011-08-11 18:23:15.276275	2011-08-11 18:23:15.276275	\\[y = 21\\]	1
212	26	\\[34 = y + 19\\]	2011-08-11 18:23:15.281304	2011-08-11 18:23:15.281304	\\[15 = y\\]	1
213	26	\\[20 + x = 29\\]	2011-08-11 18:23:15.284897	2011-08-11 18:23:15.284897	\\[x = 9\\]	1
214	26	\\[24 = 9 + x\\]	2011-08-11 18:23:15.288478	2011-08-11 18:23:15.288478	\\[15 = x\\]	1
215	26	\\[6 + w = 22\\]	2011-08-11 18:23:15.29228	2011-08-11 18:23:15.29228	\\[w = 16\\]	1
216	26	\\[x + 14 = 34\\]	2011-08-11 18:23:15.29581	2011-08-11 18:23:15.29581	\\[x = 20\\]	1
217	26	\\[30 = a + 12\\]	2011-08-11 18:23:15.299414	2011-08-11 18:23:15.299414	\\[18 = a\\]	1
218	26	\\[y + 17 = 32\\]	2011-08-11 18:23:15.303957	2011-08-11 18:23:15.303957	\\[y = 15\\]	1
219	26	\\[5 + y = 23\\]	2011-08-11 18:23:15.307529	2011-08-11 18:23:15.307529	\\[y = 18\\]	1
220	26	\\[x + 5 = 21\\]	2011-08-11 18:23:15.310856	2011-08-11 18:23:15.310856	\\[x = 16\\]	1
221	26	\\[36 = 20 + a\\]	2011-08-11 18:23:15.314303	2011-08-11 18:23:15.314303	\\[16 = a\\]	1
222	26	\\[w + 17 = 27\\]	2011-08-11 18:23:15.317636	2011-08-11 18:23:15.317636	\\[w = 10\\]	1
223	26	\\[y + 8 = 28\\]	2011-08-11 18:23:15.321383	2011-08-11 18:23:15.321383	\\[y = 20\\]	1
224	26	\\[x + 12 = 25\\]	2011-08-11 18:23:15.325482	2011-08-11 18:23:15.325482	\\[x = 13\\]	1
225	26	\\[18 + w = 33\\]	2011-08-11 18:23:15.329206	2011-08-11 18:23:15.329206	\\[w = 15\\]	1
226	26	\\[34 = x + 12\\]	2011-08-11 18:23:15.333278	2011-08-11 18:23:15.333278	\\[22 = x\\]	1
227	26	\\[32 = x + 16\\]	2011-08-11 18:23:15.337933	2011-08-11 18:23:15.337933	\\[16 = x\\]	1
228	26	\\[x + 20 = 32\\]	2011-08-11 18:23:15.3415	2011-08-11 18:23:15.3415	\\[x = 12\\]	1
229	26	\\[w + 8 = 19\\]	2011-08-11 18:23:15.344996	2011-08-11 18:23:15.344996	\\[w = 11\\]	1
230	26	\\[20 + x = 35\\]	2011-08-11 18:23:15.349314	2011-08-11 18:23:15.349314	\\[x = 15\\]	1
231	26	\\[m + 8 = 29\\]	2011-08-11 18:23:15.352671	2011-08-11 18:23:15.352671	\\[m = 21\\]	1
232	26	\\[27 = x + 16\\]	2011-08-11 18:23:15.356085	2011-08-11 18:23:15.356085	\\[11 = x\\]	1
233	26	\\[14 + x = 22\\]	2011-08-11 18:23:15.360164	2011-08-11 18:23:15.360164	\\[x = 8\\]	1
234	26	\\[16 + a = 24\\]	2011-08-11 18:23:15.363409	2011-08-11 18:23:15.363409	\\[a = 8\\]	1
235	26	\\[25 = x + 10\\]	2011-08-11 18:23:15.366983	2011-08-11 18:23:15.366983	\\[15 = x\\]	1
236	26	\\[y + 6 = 19\\]	2011-08-11 18:23:15.371417	2011-08-11 18:23:15.371417	\\[y = 13\\]	1
237	26	\\[w + 15 = 35\\]	2011-08-11 18:23:15.374859	2011-08-11 18:23:15.374859	\\[w = 20\\]	1
238	26	\\[y + 7 = 23\\]	2011-08-11 18:23:15.378359	2011-08-11 18:23:15.378359	\\[y = 16\\]	1
239	26	\\[11 + a = 24\\]	2011-08-11 18:23:15.382456	2011-08-11 18:23:15.382456	\\[a = 13\\]	1
240	26	\\[w + 3 = 16\\]	2011-08-11 18:23:15.394002	2011-08-11 18:23:15.394002	\\[w = 13\\]	1
241	26	\\[m + 17 = 37\\]	2011-08-11 18:23:15.397926	2011-08-11 18:23:15.397926	\\[m = 20\\]	1
242	26	\\[15 + x = 34\\]	2011-08-11 18:23:15.401477	2011-08-11 18:23:15.401477	\\[x = 19\\]	1
243	26	\\[24 = x + 15\\]	2011-08-11 18:23:15.405014	2011-08-11 18:23:15.405014	\\[9 = x\\]	1
244	26	\\[17 + k = 30\\]	2011-08-11 18:23:15.408526	2011-08-11 18:23:15.408526	\\[k = 13\\]	1
245	26	\\[19 = m + 10\\]	2011-08-11 18:23:15.412017	2011-08-11 18:23:15.412017	\\[9 = m\\]	1
246	26	\\[y + 9 = 28\\]	2011-08-11 18:23:15.416261	2011-08-11 18:23:15.416261	\\[y = 19\\]	1
247	26	\\[12 = k + 3\\]	2011-08-11 18:23:15.421197	2011-08-11 18:23:15.421197	\\[9 = k\\]	1
248	26	\\[16 = x + 6\\]	2011-08-11 18:23:15.424932	2011-08-11 18:23:15.424932	\\[10 = x\\]	1
249	26	\\[42 = 20 + x\\]	2011-08-11 18:23:15.428802	2011-08-11 18:23:15.428802	\\[22 = x\\]	1
250	26	\\[25 = x + 7\\]	2011-08-11 18:23:15.432796	2011-08-11 18:23:15.432796	\\[18 = x\\]	1
251	26	\\[x + 18 = 37\\]	2011-08-11 18:23:15.436256	2011-08-11 18:23:15.436256	\\[x = 19\\]	1
252	26	\\[21 = y + 7\\]	2011-08-11 18:23:15.440539	2011-08-11 18:23:15.440539	\\[14 = y\\]	1
253	26	\\[5 + x = 16\\]	2011-08-11 18:23:15.444179	2011-08-11 18:23:15.444179	\\[x = 11\\]	1
254	26	\\[22 = 11 + x\\]	2011-08-11 18:23:15.447644	2011-08-11 18:23:15.447644	\\[11 = x\\]	1
255	26	\\[y + 15 = 30\\]	2011-08-11 18:23:15.451059	2011-08-11 18:23:15.451059	\\[y = 15\\]	1
256	26	\\[25 = 15 + x\\]	2011-08-11 18:23:15.455567	2011-08-11 18:23:15.455567	\\[10 = x\\]	1
257	26	\\[23 = 11 + x\\]	2011-08-11 18:23:15.508575	2011-08-11 18:23:15.508575	\\[12 = x\\]	1
258	26	\\[20 + x = 40\\]	2011-08-11 18:23:15.51303	2011-08-11 18:23:15.51303	\\[x = 20\\]	1
259	26	\\[x + 4 = 17\\]	2011-08-11 18:23:15.516647	2011-08-11 18:23:15.516647	\\[x = 13\\]	1
260	26	\\[30 = 13 + a\\]	2011-08-11 18:23:15.520475	2011-08-11 18:23:15.520475	\\[17 = a\\]	1
261	26	\\[y + 20 = 33\\]	2011-08-11 18:23:15.524167	2011-08-11 18:23:15.524167	\\[y = 13\\]	1
262	26	\\[25 = m + 14\\]	2011-08-11 18:23:15.527608	2011-08-11 18:23:15.527608	\\[11 = m\\]	1
263	26	\\[m + 13 = 25\\]	2011-08-11 18:23:15.531448	2011-08-11 18:23:15.531448	\\[m = 12\\]	1
264	26	\\[13 + w = 24\\]	2011-08-11 18:23:15.535086	2011-08-11 18:23:15.535086	\\[w = 11\\]	1
265	26	\\[31 = 9 + w\\]	2011-08-11 18:23:15.538722	2011-08-11 18:23:15.538722	\\[22 = w\\]	1
266	26	\\[17 = 8 + x\\]	2011-08-11 18:23:15.542341	2011-08-11 18:23:15.542341	\\[9 = x\\]	1
267	26	\\[x + 9 = 26\\]	2011-08-11 18:23:15.546303	2011-08-11 18:23:15.546303	\\[x = 17\\]	1
268	26	\\[38 = m + 19\\]	2011-08-11 18:23:15.550005	2011-08-11 18:23:15.550005	\\[19 = m\\]	1
269	26	\\[16 + k = 25\\]	2011-08-11 18:23:15.553465	2011-08-11 18:23:15.553465	\\[k = 9\\]	1
270	26	\\[y + 18 = 28\\]	2011-08-11 18:23:15.557431	2011-08-11 18:23:15.557431	\\[y = 10\\]	1
271	26	\\[20 = m + 9\\]	2011-08-11 18:23:15.560834	2011-08-11 18:23:15.560834	\\[11 = m\\]	1
272	26	\\[y + 12 = 33\\]	2011-08-11 18:23:15.564184	2011-08-11 18:23:15.564184	\\[y = 21\\]	1
273	26	\\[m + 7 = 16\\]	2011-08-11 18:23:15.568396	2011-08-11 18:23:15.568396	\\[m = 9\\]	1
274	26	\\[26 = k + 10\\]	2011-08-11 18:23:15.571864	2011-08-11 18:23:15.571864	\\[16 = k\\]	1
275	26	\\[35 = y + 19\\]	2011-08-11 18:23:15.575327	2011-08-11 18:23:15.575327	\\[16 = y\\]	1
276	26	\\[17 + m = 35\\]	2011-08-11 18:23:15.580138	2011-08-11 18:23:15.580138	\\[m = 18\\]	1
277	26	\\[34 = y + 13\\]	2011-08-11 18:23:15.584075	2011-08-11 18:23:15.584075	\\[21 = y\\]	1
278	26	\\[w + 10 = 30\\]	2011-08-11 18:23:15.587714	2011-08-11 18:23:15.587714	\\[w = 20\\]	1
279	26	\\[38 = 17 + y\\]	2011-08-11 18:23:15.592002	2011-08-11 18:23:15.592002	\\[21 = y\\]	1
280	26	\\[18 + x = 30\\]	2011-08-11 18:23:15.595829	2011-08-11 18:23:15.595829	\\[x = 12\\]	1
281	26	\\[21 = k + 8\\]	2011-08-11 18:23:15.59924	2011-08-11 18:23:15.59924	\\[13 = k\\]	1
282	26	\\[12 + x = 29\\]	2011-08-11 18:23:15.60327	2011-08-11 18:23:15.60327	\\[x = 17\\]	1
283	26	\\[14 = x + 6\\]	2011-08-11 18:23:15.606801	2011-08-11 18:23:15.606801	\\[8 = x\\]	1
284	26	\\[28 = w + 15\\]	2011-08-11 18:23:15.610098	2011-08-11 18:23:15.610098	\\[13 = w\\]	1
285	26	\\[x + 19 = 27\\]	2011-08-11 18:23:15.613526	2011-08-11 18:23:15.613526	\\[x = 8\\]	1
286	26	\\[23 = w + 10\\]	2011-08-11 18:23:15.618087	2011-08-11 18:23:15.618087	\\[13 = w\\]	1
287	26	\\[12 + x = 24\\]	2011-08-11 18:23:15.621667	2011-08-11 18:23:15.621667	\\[x = 12\\]	1
288	26	\\[30 = 16 + k\\]	2011-08-11 18:23:15.625167	2011-08-11 18:23:15.625167	\\[14 = k\\]	1
289	26	\\[x + 10 = 29\\]	2011-08-11 18:23:15.628732	2011-08-11 18:23:15.628732	\\[x = 19\\]	1
290	26	\\[34 = w + 20\\]	2011-08-11 18:23:15.632552	2011-08-11 18:23:15.632552	\\[14 = w\\]	1
291	26	\\[19 = 3 + x\\]	2011-08-11 18:23:15.636132	2011-08-11 18:23:15.636132	\\[16 = x\\]	1
292	26	\\[a + 12 = 26\\]	2011-08-11 18:23:15.640299	2011-08-11 18:23:15.640299	\\[a = 14\\]	1
293	26	\\[36 = y + 17\\]	2011-08-11 18:23:15.643698	2011-08-11 18:23:15.643698	\\[19 = y\\]	1
294	26	\\[25 = 8 + m\\]	2011-08-11 18:23:15.647101	2011-08-11 18:23:15.647101	\\[17 = m\\]	1
295	26	\\[x + 12 = 22\\]	2011-08-11 18:23:15.65145	2011-08-11 18:23:15.65145	\\[x = 10\\]	1
296	26	\\[m + 11 = 27\\]	2011-08-11 18:23:15.654989	2011-08-11 18:23:15.654989	\\[m = 16\\]	1
297	26	\\[40 = w + 18\\]	2011-08-11 18:23:15.65849	2011-08-11 18:23:15.65849	\\[22 = w\\]	1
298	26	\\[3 + x = 13\\]	2011-08-11 18:23:15.662641	2011-08-11 18:23:15.662641	\\[x = 10\\]	1
299	26	\\[8 + y = 20\\]	2011-08-11 18:23:15.667456	2011-08-11 18:23:15.667456	\\[y = 12\\]	1
300	26	\\[y + 13 = 32\\]	2011-08-11 18:23:15.671385	2011-08-11 18:23:15.671385	\\[y = 19\\]	1
301	26	\\[x + 14 = 23\\]	2011-08-11 18:23:15.675352	2011-08-11 18:23:15.675352	\\[x = 9\\]	1
302	26	\\[21 = k + 4\\]	2011-08-11 18:23:15.679262	2011-08-11 18:23:15.679262	\\[17 = k\\]	1
303	26	\\[31 = a + 11\\]	2011-08-11 18:23:15.682988	2011-08-11 18:23:15.682988	\\[20 = a\\]	1
304	26	\\[18 + w = 26\\]	2011-08-11 18:23:15.686479	2011-08-11 18:23:15.686479	\\[w = 8\\]	1
305	26	\\[12 + a = 31\\]	2011-08-11 18:23:15.689948	2011-08-11 18:23:15.689948	\\[a = 19\\]	1
306	26	\\[18 + a = 29\\]	2011-08-11 18:23:15.693329	2011-08-11 18:23:15.693329	\\[a = 11\\]	1
307	26	\\[6 + x = 23\\]	2011-08-11 18:23:15.697578	2011-08-11 18:23:15.697578	\\[x = 17\\]	1
308	26	\\[36 = 16 + m\\]	2011-08-11 18:23:15.700985	2011-08-11 18:23:15.700985	\\[20 = m\\]	1
309	26	\\[26 = x + 8\\]	2011-08-11 18:23:15.704516	2011-08-11 18:23:15.704516	\\[18 = x\\]	1
310	26	\\[x + 4 = 24\\]	2011-08-11 18:23:15.755916	2011-08-11 18:23:15.755916	\\[x = 20\\]	1
311	26	\\[27 = 10 + y\\]	2011-08-11 18:23:15.760092	2011-08-11 18:23:15.760092	\\[17 = y\\]	1
312	26	\\[32 = y + 14\\]	2011-08-11 18:23:15.76365	2011-08-11 18:23:15.76365	\\[18 = y\\]	1
313	26	\\[31 = a + 16\\]	2011-08-11 18:23:15.768456	2011-08-11 18:23:15.768456	\\[15 = a\\]	1
314	26	\\[20 + y = 37\\]	2011-08-11 18:23:15.772051	2011-08-11 18:23:15.772051	\\[y = 17\\]	1
315	26	\\[x + 14 = 30\\]	2011-08-11 18:23:15.775455	2011-08-11 18:23:15.775455	\\[x = 16\\]	1
316	26	\\[10 + x = 28\\]	2011-08-11 18:23:15.779176	2011-08-11 18:23:15.779176	\\[x = 18\\]	1
317	26	\\[x + 9 = 18\\]	2011-08-11 18:23:15.783154	2011-08-11 18:23:15.783154	\\[x = 9\\]	1
318	26	\\[13 + w = 26\\]	2011-08-11 18:23:15.786636	2011-08-11 18:23:15.786636	\\[w = 13\\]	1
319	26	\\[4 + y = 20\\]	2011-08-11 18:23:15.791269	2011-08-11 18:23:15.791269	\\[y = 16\\]	1
320	26	\\[6 + x = 20\\]	2011-08-11 18:23:15.794657	2011-08-11 18:23:15.794657	\\[x = 14\\]	1
321	26	\\[20 + a = 38\\]	2011-08-11 18:23:15.797904	2011-08-11 18:23:15.797904	\\[a = 18\\]	1
322	26	\\[19 + x = 40\\]	2011-08-11 18:23:15.801939	2011-08-11 18:23:15.801939	\\[x = 21\\]	1
323	26	\\[31 = k + 15\\]	2011-08-11 18:23:15.805489	2011-08-11 18:23:15.805489	\\[16 = k\\]	1
324	26	\\[22 = 8 + x\\]	2011-08-11 18:23:15.808883	2011-08-11 18:23:15.808883	\\[14 = x\\]	1
325	26	\\[a + 15 = 23\\]	2011-08-11 18:23:15.812986	2011-08-11 18:23:15.812986	\\[a = 8\\]	1
326	26	\\[39 = m + 19\\]	2011-08-11 18:23:15.816457	2011-08-11 18:23:15.816457	\\[20 = m\\]	1
327	26	\\[6 + w = 21\\]	2011-08-11 18:23:15.820336	2011-08-11 18:23:15.820336	\\[w = 15\\]	1
328	26	\\[4 + k = 16\\]	2011-08-11 18:23:15.824123	2011-08-11 18:23:15.824123	\\[k = 12\\]	1
329	26	\\[17 + x = 29\\]	2011-08-11 18:23:15.82759	2011-08-11 18:23:15.82759	\\[x = 12\\]	1
330	26	\\[29 = 13 + a\\]	2011-08-11 18:23:15.831497	2011-08-11 18:23:15.831497	\\[16 = a\\]	1
331	26	\\[5 + x = 24\\]	2011-08-11 18:23:15.835931	2011-08-11 18:23:15.835931	\\[x = 19\\]	1
332	26	\\[25 = x + 5\\]	2011-08-11 18:23:15.83957	2011-08-11 18:23:15.83957	\\[20 = x\\]	1
333	26	\\[27 = 15 + y\\]	2011-08-11 18:23:15.843064	2011-08-11 18:23:15.843064	\\[12 = y\\]	1
334	26	\\[39 = 17 + x\\]	2011-08-11 18:23:15.847272	2011-08-11 18:23:15.847272	\\[22 = x\\]	1
335	26	\\[14 = k + 3\\]	2011-08-11 18:23:15.850643	2011-08-11 18:23:15.850643	\\[11 = k\\]	1
336	26	\\[a + 9 = 25\\]	2011-08-11 18:23:15.854513	2011-08-11 18:23:15.854513	\\[a = 16\\]	1
337	26	\\[7 + x = 28\\]	2011-08-11 18:23:15.858808	2011-08-11 18:23:15.858808	\\[x = 21\\]	1
338	26	\\[35 = a + 18\\]	2011-08-11 18:23:15.862286	2011-08-11 18:23:15.862286	\\[17 = a\\]	1
339	26	\\[15 + y = 32\\]	2011-08-11 18:23:15.86558	2011-08-11 18:23:15.86558	\\[y = 17\\]	1
340	26	\\[26 = w + 15\\]	2011-08-11 18:23:15.869794	2011-08-11 18:23:15.869794	\\[11 = w\\]	1
341	26	\\[19 = x + 11\\]	2011-08-11 18:23:15.87339	2011-08-11 18:23:15.87339	\\[8 = x\\]	1
342	26	\\[37 = y + 19\\]	2011-08-11 18:23:15.876848	2011-08-11 18:23:15.876848	\\[18 = y\\]	1
343	26	\\[26 = y + 7\\]	2011-08-11 18:23:15.880459	2011-08-11 18:23:15.880459	\\[19 = y\\]	1
344	26	\\[y + 9 = 30\\]	2011-08-11 18:23:15.884609	2011-08-11 18:23:15.884609	\\[y = 21\\]	1
345	26	\\[28 = k + 6\\]	2011-08-11 18:23:15.888431	2011-08-11 18:23:15.888431	\\[22 = k\\]	1
346	26	\\[14 + m = 27\\]	2011-08-11 18:23:15.891882	2011-08-11 18:23:15.891882	\\[m = 13\\]	1
347	26	\\[3 + x = 21\\]	2011-08-11 18:23:15.895929	2011-08-11 18:23:15.895929	\\[x = 18\\]	1
348	26	\\[10 + k = 21\\]	2011-08-11 18:23:15.899373	2011-08-11 18:23:15.899373	\\[k = 11\\]	1
349	26	\\[x + 8 = 23\\]	2011-08-11 18:23:15.902756	2011-08-11 18:23:15.902756	\\[x = 15\\]	1
350	26	\\[14 + x = 24\\]	2011-08-11 18:23:15.907045	2011-08-11 18:23:15.907045	\\[x = 10\\]	1
351	26	\\[y + 10 = 18\\]	2011-08-11 18:23:15.910508	2011-08-11 18:23:15.910508	\\[y = 8\\]	1
352	26	\\[23 = 9 + x\\]	2011-08-11 18:23:15.914434	2011-08-11 18:23:15.914434	\\[14 = x\\]	1
353	26	\\[12 + y = 21\\]	2011-08-11 18:23:15.919562	2011-08-11 18:23:15.919562	\\[y = 9\\]	1
354	26	\\[w + 9 = 22\\]	2011-08-11 18:23:15.923259	2011-08-11 18:23:15.923259	\\[w = 13\\]	1
355	26	\\[33 = x + 14\\]	2011-08-11 18:23:15.926768	2011-08-11 18:23:15.926768	\\[19 = x\\]	1
356	26	\\[33 = x + 16\\]	2011-08-11 18:23:15.931338	2011-08-11 18:23:15.931338	\\[17 = x\\]	1
357	26	\\[a + 12 = 27\\]	2011-08-11 18:23:15.935227	2011-08-11 18:23:15.935227	\\[a = 15\\]	1
358	26	\\[26 = 16 + x\\]	2011-08-11 18:23:15.938941	2011-08-11 18:23:15.938941	\\[10 = x\\]	1
359	26	\\[x + 13 = 33\\]	2011-08-11 18:23:15.943097	2011-08-11 18:23:15.943097	\\[x = 20\\]	1
360	26	\\[29 = 16 + y\\]	2011-08-11 18:23:15.946433	2011-08-11 18:23:15.946433	\\[13 = y\\]	1
361	26	\\[34 = 16 + x\\]	2011-08-11 18:23:15.998205	2011-08-11 18:23:15.998205	\\[18 = x\\]	1
362	26	\\[36 = 19 + x\\]	2011-08-11 18:23:16.002214	2011-08-11 18:23:16.002214	\\[17 = x\\]	1
363	26	\\[31 = 20 + a\\]	2011-08-11 18:23:16.00575	2011-08-11 18:23:16.00575	\\[11 = a\\]	1
364	26	\\[4 + m = 26\\]	2011-08-11 18:23:16.00984	2011-08-11 18:23:16.00984	\\[m = 22\\]	1
365	26	\\[a + 4 = 23\\]	2011-08-11 18:23:16.013369	2011-08-11 18:23:16.013369	\\[a = 19\\]	1
366	26	\\[15 + x = 37\\]	2011-08-11 18:23:16.017154	2011-08-11 18:23:16.017154	\\[x = 22\\]	1
367	26	\\[27 = x + 9\\]	2011-08-11 18:23:16.021271	2011-08-11 18:23:16.021271	\\[18 = x\\]	1
368	26	\\[25 = x + 3\\]	2011-08-11 18:23:16.024727	2011-08-11 18:23:16.024727	\\[22 = x\\]	1
369	26	\\[18 = w + 5\\]	2011-08-11 18:23:16.028112	2011-08-11 18:23:16.028112	\\[13 = w\\]	1
370	26	\\[35 = 13 + k\\]	2011-08-11 18:23:16.032005	2011-08-11 18:23:16.032005	\\[22 = k\\]	1
371	26	\\[16 + x = 38\\]	2011-08-11 18:23:16.035657	2011-08-11 18:23:16.035657	\\[x = 22\\]	1
372	26	\\[x + 5 = 17\\]	2011-08-11 18:23:16.039274	2011-08-11 18:23:16.039274	\\[x = 12\\]	1
373	26	\\[39 = y + 20\\]	2011-08-11 18:23:16.042641	2011-08-11 18:23:16.042641	\\[19 = y\\]	1
374	26	\\[17 = w + 9\\]	2011-08-11 18:23:16.046801	2011-08-11 18:23:16.046801	\\[8 = w\\]	1
375	26	\\[k + 3 = 15\\]	2011-08-11 18:23:16.050185	2011-08-11 18:23:16.050185	\\[k = 12\\]	1
376	26	\\[13 + y = 21\\]	2011-08-11 18:23:16.053642	2011-08-11 18:23:16.053642	\\[y = 8\\]	1
377	26	\\[a + 6 = 25\\]	2011-08-11 18:23:16.057781	2011-08-11 18:23:16.057781	\\[a = 19\\]	1
378	26	\\[36 = x + 18\\]	2011-08-11 18:23:16.061212	2011-08-11 18:23:16.061212	\\[18 = x\\]	1
379	26	\\[k + 4 = 19\\]	2011-08-11 18:23:16.065252	2011-08-11 18:23:16.065252	\\[k = 15\\]	1
380	26	\\[34 = 17 + x\\]	2011-08-11 18:23:16.069337	2011-08-11 18:23:16.069337	\\[17 = x\\]	1
381	26	\\[x + 6 = 18\\]	2011-08-11 18:23:16.072861	2011-08-11 18:23:16.072861	\\[x = 12\\]	1
382	26	\\[18 + m = 38\\]	2011-08-11 18:23:16.076509	2011-08-11 18:23:16.076509	\\[m = 20\\]	1
383	26	\\[x + 6 = 17\\]	2011-08-11 18:23:16.080053	2011-08-11 18:23:16.080053	\\[x = 11\\]	1
384	26	\\[21 = k + 11\\]	2011-08-11 18:23:16.083866	2011-08-11 18:23:16.083866	\\[10 = k\\]	1
385	26	\\[19 + y = 29\\]	2011-08-11 18:23:16.087329	2011-08-11 18:23:16.087329	\\[y = 10\\]	1
386	26	\\[15 + x = 33\\]	2011-08-11 18:23:16.0916	2011-08-11 18:23:16.0916	\\[x = 18\\]	1
387	26	\\[16 + y = 35\\]	2011-08-11 18:23:16.095078	2011-08-11 18:23:16.095078	\\[y = 19\\]	1
388	26	\\[22 = 13 + x\\]	2011-08-11 18:23:16.098494	2011-08-11 18:23:16.098494	\\[9 = x\\]	1
389	26	\\[4 + y = 13\\]	2011-08-11 18:23:16.102547	2011-08-11 18:23:16.102547	\\[y = 9\\]	1
390	26	\\[26 = y + 11\\]	2011-08-11 18:23:16.105986	2011-08-11 18:23:16.105986	\\[15 = y\\]	1
391	26	\\[m + 7 = 24\\]	2011-08-11 18:23:16.109362	2011-08-11 18:23:16.109362	\\[m = 17\\]	1
392	26	\\[13 = 5 + w\\]	2011-08-11 18:23:16.112644	2011-08-11 18:23:16.112644	\\[8 = w\\]	1
393	26	\\[15 = 5 + k\\]	2011-08-11 18:23:16.116776	2011-08-11 18:23:16.116776	\\[10 = k\\]	1
394	26	\\[7 + x = 22\\]	2011-08-11 18:23:16.121054	2011-08-11 18:23:16.121054	\\[x = 15\\]	1
395	26	\\[26 = 14 + k\\]	2011-08-11 18:23:16.124686	2011-08-11 18:23:16.124686	\\[12 = k\\]	1
396	26	\\[4 + x = 18\\]	2011-08-11 18:23:16.128275	2011-08-11 18:23:16.128275	\\[x = 14\\]	1
397	26	\\[x + 7 = 19\\]	2011-08-11 18:23:16.132873	2011-08-11 18:23:16.132873	\\[x = 12\\]	1
398	26	\\[m + 12 = 28\\]	2011-08-11 18:23:16.137318	2011-08-11 18:23:16.137318	\\[m = 16\\]	1
399	26	\\[14 = m + 5\\]	2011-08-11 18:23:16.141126	2011-08-11 18:23:16.141126	\\[9 = m\\]	1
400	26	\\[w + 12 = 20\\]	2011-08-11 18:23:16.144713	2011-08-11 18:23:16.144713	\\[w = 8\\]	1
401	26	\\[11 = 3 + a\\]	2011-08-11 18:23:16.149152	2011-08-11 18:23:16.149152	\\[8 = a\\]	1
402	26	\\[5 + x = 27\\]	2011-08-11 18:23:16.152742	2011-08-11 18:23:16.152742	\\[x = 22\\]	1
403	26	\\[20 = k + 10\\]	2011-08-11 18:23:16.156214	2011-08-11 18:23:16.156214	\\[10 = k\\]	1
404	26	\\[20 = 11 + w\\]	2011-08-11 18:23:16.15952	2011-08-11 18:23:16.15952	\\[9 = w\\]	1
405	26	\\[41 = x + 20\\]	2011-08-11 18:23:16.1635	2011-08-11 18:23:16.1635	\\[21 = x\\]	1
406	26	\\[k + 3 = 20\\]	2011-08-11 18:23:16.167925	2011-08-11 18:23:16.167925	\\[k = 17\\]	1
407	26	\\[20 + a = 28\\]	2011-08-11 18:23:16.171604	2011-08-11 18:23:16.171604	\\[a = 8\\]	1
408	26	\\[5 + x = 20\\]	2011-08-11 18:23:16.175357	2011-08-11 18:23:16.175357	\\[x = 15\\]	1
409	26	\\[27 = k + 7\\]	2011-08-11 18:23:16.179619	2011-08-11 18:23:16.179619	\\[20 = k\\]	1
410	26	\\[27 = 6 + y\\]	2011-08-11 18:23:16.18402	2011-08-11 18:23:16.18402	\\[21 = y\\]	1
411	26	\\[18 + x = 32\\]	2011-08-11 18:23:16.232915	2011-08-11 18:23:16.232915	\\[x = 14\\]	1
412	26	\\[16 = 8 + x\\]	2011-08-11 18:23:16.238182	2011-08-11 18:23:16.238182	\\[8 = x\\]	1
413	26	\\[x + 5 = 26\\]	2011-08-11 18:23:16.242193	2011-08-11 18:23:16.242193	\\[x = 21\\]	1
414	26	\\[19 = 9 + k\\]	2011-08-11 18:23:16.245879	2011-08-11 18:23:16.245879	\\[10 = k\\]	1
415	26	\\[30 = 19 + x\\]	2011-08-11 18:23:16.249311	2011-08-11 18:23:16.249311	\\[11 = x\\]	1
416	26	\\[6 + x = 24\\]	2011-08-11 18:23:16.253479	2011-08-11 18:23:16.253479	\\[x = 18\\]	1
417	26	\\[20 = 7 + a\\]	2011-08-11 18:23:16.257265	2011-08-11 18:23:16.257265	\\[13 = a\\]	1
418	26	\\[m + 16 = 28\\]	2011-08-11 18:23:16.261253	2011-08-11 18:23:16.261253	\\[m = 12\\]	1
419	26	\\[26 = 6 + a\\]	2011-08-11 18:23:16.265912	2011-08-11 18:23:16.265912	\\[20 = a\\]	1
420	26	\\[3 + x = 17\\]	2011-08-11 18:23:16.270257	2011-08-11 18:23:16.270257	\\[x = 14\\]	1
421	26	\\[x + 19 = 31\\]	2011-08-11 18:23:16.274217	2011-08-11 18:23:16.274217	\\[x = 12\\]	1
422	26	\\[x + 8 = 24\\]	2011-08-11 18:23:16.27909	2011-08-11 18:23:16.27909	\\[x = 16\\]	1
423	26	\\[31 = x + 14\\]	2011-08-11 18:23:16.282686	2011-08-11 18:23:16.282686	\\[17 = x\\]	1
424	26	\\[8 + m = 27\\]	2011-08-11 18:23:16.286184	2011-08-11 18:23:16.286184	\\[m = 19\\]	1
695	27	\\[7 = m - 20\\]	2011-08-11 19:12:33.259837	2011-08-11 19:12:33.259837	\\[27 = m\\]	1
696	27	\\[11 = w - 11\\]	2011-08-11 19:12:33.291956	2011-08-11 19:12:33.291956	\\[22 = w\\]	1
697	27	\\[w - 16 = 3\\]	2011-08-11 19:12:33.295783	2011-08-11 19:12:33.295783	\\[w = 19\\]	1
698	27	\\[8 = y - 11\\]	2011-08-11 19:12:33.299293	2011-08-11 19:12:33.299293	\\[19 = y\\]	1
699	27	\\[3 = w - 18\\]	2011-08-11 19:12:33.30288	2011-08-11 19:12:33.30288	\\[21 = w\\]	1
700	27	\\[15 = y - 11\\]	2011-08-11 19:12:33.306507	2011-08-11 19:12:33.306507	\\[26 = y\\]	1
701	27	\\[y - 17 = 3\\]	2011-08-11 19:12:33.310222	2011-08-11 19:12:33.310222	\\[y = 20\\]	1
702	27	\\[w - 18 = 5\\]	2011-08-11 19:12:33.314669	2011-08-11 19:12:33.314669	\\[w = 23\\]	1
703	27	\\[9 = y - 17\\]	2011-08-11 19:12:33.318077	2011-08-11 19:12:33.318077	\\[26 = y\\]	1
704	27	\\[8 = x - 19\\]	2011-08-11 19:12:33.32134	2011-08-11 19:12:33.32134	\\[27 = x\\]	1
705	27	\\[5 = x - 16\\]	2011-08-11 19:12:33.325714	2011-08-11 19:12:33.325714	\\[21 = x\\]	1
706	27	\\[14 = a - 12\\]	2011-08-11 19:12:33.329092	2011-08-11 19:12:33.329092	\\[26 = a\\]	1
707	27	\\[w - 19 = 6\\]	2011-08-11 19:12:33.332574	2011-08-11 19:12:33.332574	\\[w = 25\\]	1
708	27	\\[12 = y - 14\\]	2011-08-11 19:12:33.336613	2011-08-11 19:12:33.336613	\\[26 = y\\]	1
709	27	\\[7 = y - 14\\]	2011-08-11 19:12:33.340688	2011-08-11 19:12:33.340688	\\[21 = y\\]	1
710	27	\\[k - 15 = 11\\]	2011-08-11 19:12:33.344942	2011-08-11 19:12:33.344942	\\[k = 26\\]	1
711	27	\\[m - 15 = 12\\]	2011-08-11 19:12:33.348469	2011-08-11 19:12:33.348469	\\[m = 27\\]	1
712	27	\\[x - 18 = 4\\]	2011-08-11 19:12:33.351976	2011-08-11 19:12:33.351976	\\[x = 22\\]	1
713	27	\\[x - 14 = 13\\]	2011-08-11 19:12:33.355774	2011-08-11 19:12:33.355774	\\[x = 27\\]	1
714	27	\\[w - 11 = 5\\]	2011-08-11 19:12:33.359526	2011-08-11 19:12:33.359526	\\[w = 16\\]	1
715	27	\\[x - 19 = 2\\]	2011-08-11 19:12:33.363072	2011-08-11 19:12:33.363072	\\[x = 21\\]	1
716	27	\\[x - 19 = 4\\]	2011-08-11 19:12:33.366505	2011-08-11 19:12:33.366505	\\[x = 23\\]	1
717	27	\\[8 = x - 15\\]	2011-08-11 19:12:33.370619	2011-08-11 19:12:33.370619	\\[23 = x\\]	1
718	27	\\[7 = x - 18\\]	2011-08-11 19:12:33.374049	2011-08-11 19:12:33.374049	\\[25 = x\\]	1
719	27	\\[2 = x - 16\\]	2011-08-11 19:12:33.377692	2011-08-11 19:12:33.377692	\\[18 = x\\]	1
720	27	\\[y - 16 = 8\\]	2011-08-11 19:12:33.382073	2011-08-11 19:12:33.382073	\\[y = 24\\]	1
721	27	\\[5 = y - 20\\]	2011-08-11 19:12:33.385566	2011-08-11 19:12:33.385566	\\[25 = y\\]	1
722	27	\\[2 = x - 15\\]	2011-08-11 19:12:33.389269	2011-08-11 19:12:33.389269	\\[17 = x\\]	1
723	27	\\[7 = w - 11\\]	2011-08-11 19:12:33.393974	2011-08-11 19:12:33.393974	\\[18 = w\\]	1
724	27	\\[6 = y - 15\\]	2011-08-11 19:12:33.397772	2011-08-11 19:12:33.397772	\\[21 = y\\]	1
725	27	\\[a - 13 = 13\\]	2011-08-11 19:12:33.401393	2011-08-11 19:12:33.401393	\\[a = 26\\]	1
726	27	\\[x - 12 = 8\\]	2011-08-11 19:12:33.405902	2011-08-11 19:12:33.405902	\\[x = 20\\]	1
727	27	\\[a - 15 = 9\\]	2011-08-11 19:12:33.409689	2011-08-11 19:12:33.409689	\\[a = 24\\]	1
728	27	\\[11 = a - 13\\]	2011-08-11 19:12:33.458654	2011-08-11 19:12:33.458654	\\[24 = a\\]	1
729	27	\\[x - 13 = 14\\]	2011-08-11 19:12:33.464391	2011-08-11 19:12:33.464391	\\[x = 27\\]	1
730	27	\\[x - 11 = 10\\]	2011-08-11 19:12:33.46812	2011-08-11 19:12:33.46812	\\[x = 21\\]	1
731	27	\\[x - 12 = 12\\]	2011-08-11 19:12:33.471917	2011-08-11 19:12:33.471917	\\[x = 24\\]	1
732	27	\\[m - 17 = 8\\]	2011-08-11 19:12:33.476157	2011-08-11 19:12:33.476157	\\[m = 25\\]	1
733	27	\\[5 = x - 12\\]	2011-08-11 19:12:33.479714	2011-08-11 19:12:33.479714	\\[17 = x\\]	1
734	27	\\[a - 18 = 6\\]	2011-08-11 19:12:33.48306	2011-08-11 19:12:33.48306	\\[a = 24\\]	1
735	27	\\[10 = x - 17\\]	2011-08-11 19:12:33.487635	2011-08-11 19:12:33.487635	\\[27 = x\\]	1
736	27	\\[8 = y - 13\\]	2011-08-11 19:12:33.490996	2011-08-11 19:12:33.490996	\\[21 = y\\]	1
737	27	\\[x - 12 = 9\\]	2011-08-11 19:12:33.495461	2011-08-11 19:12:33.495461	\\[x = 21\\]	1
738	27	\\[9 = x - 18\\]	2011-08-11 19:12:33.499285	2011-08-11 19:12:33.499285	\\[27 = x\\]	1
739	27	\\[x - 17 = 5\\]	2011-08-11 19:12:33.502822	2011-08-11 19:12:33.502822	\\[x = 22\\]	1
740	27	\\[y - 12 = 4\\]	2011-08-11 19:12:33.506655	2011-08-11 19:12:33.506655	\\[y = 16\\]	1
741	27	\\[a - 20 = 2\\]	2011-08-11 19:12:33.510852	2011-08-11 19:12:33.510852	\\[a = 22\\]	1
742	27	\\[y - 15 = 3\\]	2011-08-11 19:12:33.51459	2011-08-11 19:12:33.51459	\\[y = 18\\]	1
743	27	\\[11 = y - 16\\]	2011-08-11 19:12:33.518293	2011-08-11 19:12:33.518293	\\[27 = y\\]	1
744	27	\\[11 = y - 14\\]	2011-08-11 19:12:33.522561	2011-08-11 19:12:33.522561	\\[25 = y\\]	1
745	27	\\[10 = a - 15\\]	2011-08-11 19:12:33.526534	2011-08-11 19:12:33.526534	\\[25 = a\\]	1
746	27	\\[k - 17 = 7\\]	2011-08-11 19:12:33.530037	2011-08-11 19:12:33.530037	\\[k = 24\\]	1
747	27	\\[k - 20 = 3\\]	2011-08-11 19:12:33.534352	2011-08-11 19:12:33.534352	\\[k = 23\\]	1
748	27	\\[2 = w - 18\\]	2011-08-11 19:12:33.537975	2011-08-11 19:12:33.537975	\\[20 = w\\]	1
749	27	\\[15 = x - 12\\]	2011-08-11 19:12:33.542618	2011-08-11 19:12:33.542618	\\[27 = x\\]	1
750	27	\\[5 = w - 13\\]	2011-08-11 19:12:33.546519	2011-08-11 19:12:33.546519	\\[18 = w\\]	1
751	27	\\[a - 14 = 2\\]	2011-08-11 19:12:33.550075	2011-08-11 19:12:33.550075	\\[a = 16\\]	1
752	27	\\[x - 19 = 5\\]	2011-08-11 19:12:33.553727	2011-08-11 19:12:33.553727	\\[x = 24\\]	1
753	27	\\[2 = k - 11\\]	2011-08-11 19:12:33.557713	2011-08-11 19:12:33.557713	\\[13 = k\\]	1
754	27	\\[x - 12 = 11\\]	2011-08-11 19:12:33.561229	2011-08-11 19:12:33.561229	\\[x = 23\\]	1
755	27	\\[7 = y - 16\\]	2011-08-11 19:12:33.564959	2011-08-11 19:12:33.564959	\\[23 = y\\]	1
756	27	\\[6 = y - 20\\]	2011-08-11 19:12:33.569153	2011-08-11 19:12:33.569153	\\[26 = y\\]	1
757	27	\\[8 = k - 14\\]	2011-08-11 19:12:33.572594	2011-08-11 19:12:33.572594	\\[22 = k\\]	1
758	27	\\[2 = y - 12\\]	2011-08-11 19:12:33.575889	2011-08-11 19:12:33.575889	\\[14 = y\\]	1
759	27	\\[5 = w - 14\\]	2011-08-11 19:12:33.579926	2011-08-11 19:12:33.579926	\\[19 = w\\]	1
760	27	\\[m - 17 = 4\\]	2011-08-11 19:12:33.583272	2011-08-11 19:12:33.583272	\\[m = 21\\]	1
761	27	\\[m - 12 = 7\\]	2011-08-11 19:12:33.586771	2011-08-11 19:12:33.586771	\\[m = 19\\]	1
762	27	\\[m - 14 = 4\\]	2011-08-11 19:12:33.592131	2011-08-11 19:12:33.592131	\\[m = 18\\]	1
763	27	\\[x - 12 = 10\\]	2011-08-11 19:12:33.595996	2011-08-11 19:12:33.595996	\\[x = 22\\]	1
764	27	\\[a - 11 = 16\\]	2011-08-11 19:12:33.599642	2011-08-11 19:12:33.599642	\\[a = 27\\]	1
765	27	\\[w - 11 = 9\\]	2011-08-11 19:12:33.603131	2011-08-11 19:12:33.603131	\\[w = 20\\]	1
766	27	\\[14 = k - 11\\]	2011-08-11 19:12:33.607052	2011-08-11 19:12:33.607052	\\[25 = k\\]	1
767	27	\\[6 = y - 12\\]	2011-08-11 19:12:33.610945	2011-08-11 19:12:33.610945	\\[18 = y\\]	1
768	27	\\[a - 14 = 6\\]	2011-08-11 19:12:33.615301	2011-08-11 19:12:33.615301	\\[a = 20\\]	1
769	27	\\[x - 15 = 7\\]	2011-08-11 19:12:33.618863	2011-08-11 19:12:33.618863	\\[x = 22\\]	1
770	27	\\[6 = y - 17\\]	2011-08-11 19:12:33.622143	2011-08-11 19:12:33.622143	\\[23 = y\\]	1
771	27	\\[x - 13 = 6\\]	2011-08-11 19:12:33.626195	2011-08-11 19:12:33.626195	\\[x = 19\\]	1
772	27	\\[10 = y - 14\\]	2011-08-11 19:12:33.629738	2011-08-11 19:12:33.629738	\\[24 = y\\]	1
773	27	\\[8 = x - 18\\]	2011-08-11 19:12:33.633383	2011-08-11 19:12:33.633383	\\[26 = x\\]	1
774	27	\\[k - 17 = 2\\]	2011-08-11 19:12:33.637466	2011-08-11 19:12:33.637466	\\[k = 19\\]	1
775	27	\\[x - 16 = 9\\]	2011-08-11 19:12:33.641001	2011-08-11 19:12:33.641001	\\[x = 25\\]	1
776	27	\\[x - 15 = 5\\]	2011-08-11 19:12:33.645535	2011-08-11 19:12:33.645535	\\[x = 20\\]	1
777	27	\\[m - 13 = 4\\]	2011-08-11 19:12:33.649785	2011-08-11 19:12:33.649785	\\[m = 17\\]	1
778	27	\\[12 = x - 11\\]	2011-08-11 19:12:33.653588	2011-08-11 19:12:33.653588	\\[23 = x\\]	1
779	27	\\[m - 19 = 7\\]	2011-08-11 19:12:33.701691	2011-08-11 19:12:33.701691	\\[m = 26\\]	1
780	27	\\[13 = y - 11\\]	2011-08-11 19:12:33.706774	2011-08-11 19:12:33.706774	\\[24 = y\\]	1
781	27	\\[m - 15 = 4\\]	2011-08-11 19:12:33.712008	2011-08-11 19:12:33.712008	\\[m = 19\\]	1
782	27	\\[6 = w - 16\\]	2011-08-11 19:12:33.715942	2011-08-11 19:12:33.715942	\\[22 = w\\]	1
783	27	\\[13 = y - 12\\]	2011-08-11 19:12:33.720235	2011-08-11 19:12:33.720235	\\[25 = y\\]	1
784	27	\\[3 = x - 13\\]	2011-08-11 19:12:33.724121	2011-08-11 19:12:33.724121	\\[16 = x\\]	1
785	27	\\[12 = x - 13\\]	2011-08-11 19:12:33.727662	2011-08-11 19:12:33.727662	\\[25 = x\\]	1
786	27	\\[a - 16 = 4\\]	2011-08-11 19:12:33.731568	2011-08-11 19:12:33.731568	\\[a = 20\\]	1
787	27	\\[k - 11 = 3\\]	2011-08-11 19:12:33.735334	2011-08-11 19:12:33.735334	\\[k = 14\\]	1
788	27	\\[4 = y - 20\\]	2011-08-11 19:12:33.739008	2011-08-11 19:12:33.739008	\\[24 = y\\]	1
789	27	\\[w - 14 = 9\\]	2011-08-11 19:12:33.742913	2011-08-11 19:12:33.742913	\\[w = 23\\]	1
790	27	\\[7 = a - 13\\]	2011-08-11 19:12:33.746603	2011-08-11 19:12:33.746603	\\[20 = a\\]	1
791	27	\\[9 = k - 13\\]	2011-08-11 19:12:33.749903	2011-08-11 19:12:33.749903	\\[22 = k\\]	1
792	27	\\[w - 19 = 3\\]	2011-08-11 19:12:33.753892	2011-08-11 19:12:33.753892	\\[w = 22\\]	1
793	27	\\[6 = y - 11\\]	2011-08-11 19:12:33.75734	2011-08-11 19:12:33.75734	\\[17 = y\\]	1
794	27	\\[10 = w - 16\\]	2011-08-11 19:12:33.760777	2011-08-11 19:12:33.760777	\\[26 = w\\]	1
796	27	\\[x - 11 = 4\\]	2011-08-11 19:12:33.768447	2011-08-11 19:12:33.768447	\\[x = 15\\]	1
797	27	\\[3 = w - 14\\]	2011-08-11 19:12:33.772052	2011-08-11 19:12:33.772052	\\[17 = w\\]	1
798	27	\\[2 = a - 13\\]	2011-08-11 19:12:33.776285	2011-08-11 19:12:33.776285	\\[15 = a\\]	1
799	27	\\[x - 13 = 10\\]	2011-08-11 19:12:33.780161	2011-08-11 19:12:33.780161	\\[x = 23\\]	1
800	29	\\[m - 4.2 = 9.8\\]	2011-08-12 10:07:31.47536	2011-08-12 10:07:31.47536	\\[m = 14\\]	1
801	29	\\[0.5 = a - 9\\]	2011-08-12 10:07:31.505901	2011-08-12 10:07:31.505901	\\[9.5 = a\\]	1
802	29	\\[m - 1.6 = 1.4\\]	2011-08-12 10:07:31.509916	2011-08-12 10:07:31.509916	\\[m = 3\\]	1
803	29	\\[11 = 1.6 + k\\]	2011-08-12 10:07:31.513374	2011-08-12 10:07:31.513374	\\[9.4 = k\\]	1
804	29	\\[6.3 = a - 2.7\\]	2011-08-12 10:07:31.517076	2011-08-12 10:07:31.517076	\\[9 = a\\]	1
805	29	\\[x - 18 = 0.4\\]	2011-08-12 10:07:31.520847	2011-08-12 10:07:31.520847	\\[x = 18.4\\]	1
806	29	\\[10 = 1 + k\\]	2011-08-12 10:07:31.524578	2011-08-12 10:07:31.524578	\\[9 = k\\]	1
807	29	\\[3.7 + w = 11\\]	2011-08-12 10:07:31.529019	2011-08-12 10:07:31.529019	\\[w = 7.3\\]	1
808	29	\\[x - 13 = 4\\]	2011-08-12 10:07:31.532731	2011-08-12 10:07:31.532731	\\[x = 17\\]	1
809	29	\\[0.2 + y = 1\\]	2011-08-12 10:07:31.536045	2011-08-12 10:07:31.536045	\\[y = 0.8\\]	1
810	29	\\[3 = 1.9 + m\\]	2011-08-12 10:07:31.539355	2011-08-12 10:07:31.539355	\\[1.1 = m\\]	1
811	29	\\[x - 3.3 = 0.7\\]	2011-08-12 10:07:31.542806	2011-08-12 10:07:31.542806	\\[x = 4\\]	1
812	29	\\[12 = 2.1 + x\\]	2011-08-12 10:07:31.546188	2011-08-12 10:07:31.546188	\\[9.9 = x\\]	1
813	29	\\[4.6 = y - 2\\]	2011-08-12 10:07:31.550094	2011-08-12 10:07:31.550094	\\[6.6 = y\\]	1
814	29	\\[x + 0.6 = 9\\]	2011-08-12 10:07:31.554438	2011-08-12 10:07:31.554438	\\[x = 8.4\\]	1
815	29	\\[w - 17 = 8.5\\]	2011-08-12 10:07:31.558052	2011-08-12 10:07:31.558052	\\[w = 25.5\\]	1
816	29	\\[4 = y + 0.5\\]	2011-08-12 10:07:31.561802	2011-08-12 10:07:31.561802	\\[3.5 = y\\]	1
817	29	\\[6 = 4.5 + k\\]	2011-08-12 10:07:31.565332	2011-08-12 10:07:31.565332	\\[1.5 = k\\]	1
818	29	\\[6 = w + 4.5\\]	2011-08-12 10:07:31.569161	2011-08-12 10:07:31.569161	\\[1.5 = w\\]	1
819	29	\\[3.4 = a - 4.6\\]	2011-08-12 10:07:31.572885	2011-08-12 10:07:31.572885	\\[8 = a\\]	1
820	29	\\[9.5 = x - 3.5\\]	2011-08-12 10:07:31.576502	2011-08-12 10:07:31.576502	\\[13 = x\\]	1
821	29	\\[9 = 4.3 + y\\]	2011-08-12 10:07:31.579895	2011-08-12 10:07:31.579895	\\[4.7 = y\\]	1
822	29	\\[7 = x + 0.5\\]	2011-08-12 10:07:31.583295	2011-08-12 10:07:31.583295	\\[6.5 = x\\]	1
823	29	\\[2 + a = 4\\]	2011-08-12 10:07:31.586677	2011-08-12 10:07:31.586677	\\[a = 2\\]	1
824	29	\\[1.1 + m = 8\\]	2011-08-12 10:07:31.590498	2011-08-12 10:07:31.590498	\\[m = 6.9\\]	1
825	29	\\[x + 4.4 = 9\\]	2011-08-12 10:07:31.594837	2011-08-12 10:07:31.594837	\\[x = 4.6\\]	1
826	29	\\[x - 0.4 = 9.6\\]	2011-08-12 10:07:31.598314	2011-08-12 10:07:31.598314	\\[x = 10\\]	1
827	29	\\[1.5 + m = 9\\]	2011-08-12 10:07:31.602163	2011-08-12 10:07:31.602163	\\[m = 7.5\\]	1
828	29	\\[7 = a + 0.6\\]	2011-08-12 10:07:31.606334	2011-08-12 10:07:31.606334	\\[6.4 = a\\]	1
829	29	\\[2 + y = 9\\]	2011-08-12 10:07:31.610042	2011-08-12 10:07:31.610042	\\[y = 7\\]	1
830	29	\\[a - 0 = 5\\]	2011-08-12 10:07:31.613499	2011-08-12 10:07:31.613499	\\[a = 5\\]	1
831	29	\\[m - 10 = 9.4\\]	2011-08-12 10:07:31.617068	2011-08-12 10:07:31.617068	\\[m = 19.4\\]	1
832	29	\\[x + 4.6 = 14\\]	2011-08-12 10:07:31.620912	2011-08-12 10:07:31.620912	\\[x = 9.4\\]	1
833	29	\\[y - 11 = 7.6\\]	2011-08-12 10:07:31.624612	2011-08-12 10:07:31.624612	\\[y = 18.6\\]	1
834	29	\\[0.1 + k = 2\\]	2011-08-12 10:07:31.628178	2011-08-12 10:07:31.628178	\\[k = 1.9\\]	1
835	29	\\[k + 3.6 = 9\\]	2011-08-12 10:07:31.631737	2011-08-12 10:07:31.631737	\\[k = 5.4\\]	1
836	29	\\[1 = x + 0.8\\]	2011-08-12 10:07:31.707823	2011-08-12 10:07:31.707823	\\[0.2 = x\\]	1
837	29	\\[x - 6 = 7.4\\]	2011-08-12 10:07:31.807249	2011-08-12 10:07:31.807249	\\[x = 13.4\\]	1
838	29	\\[a - 6 = 5.6\\]	2011-08-12 10:07:31.811611	2011-08-12 10:07:31.811611	\\[a = 11.6\\]	1
839	29	\\[2.2 + x = 9\\]	2011-08-12 10:07:31.816257	2011-08-12 10:07:31.816257	\\[x = 6.8\\]	1
840	29	\\[8 = w + 3.6\\]	2011-08-12 10:07:31.820928	2011-08-12 10:07:31.820928	\\[4.4 = w\\]	1
841	29	\\[11 = x + 1.9\\]	2011-08-12 10:07:31.825376	2011-08-12 10:07:31.825376	\\[9.1 = x\\]	1
842	29	\\[k - 9 = 6.1\\]	2011-08-12 10:07:31.828838	2011-08-12 10:07:31.828838	\\[k = 15.1\\]	1
843	29	\\[a - 1.1 = 1.9\\]	2011-08-12 10:07:31.832311	2011-08-12 10:07:31.832311	\\[a = 3\\]	1
844	29	\\[6 = 3.5 + a\\]	2011-08-12 10:07:31.836933	2011-08-12 10:07:31.836933	\\[2.5 = a\\]	1
845	29	\\[4.1 + y = 7\\]	2011-08-12 10:07:31.84222	2011-08-12 10:07:31.84222	\\[y = 2.9\\]	1
846	29	\\[7 = 4.3 + x\\]	2011-08-12 10:07:31.846433	2011-08-12 10:07:31.846433	\\[2.7 = x\\]	1
847	29	\\[7 = 3.1 + x\\]	2011-08-12 10:07:31.850788	2011-08-12 10:07:31.850788	\\[3.9 = x\\]	1
848	29	\\[x - 1 = 2.1\\]	2011-08-12 10:07:31.854633	2011-08-12 10:07:31.854633	\\[x = 3.1\\]	1
849	29	\\[12 = 4.2 + x\\]	2011-08-12 10:07:31.859446	2011-08-12 10:07:31.859446	\\[7.8 = x\\]	1
850	29	\\[x - 0.6 = 6.4\\]	2011-08-12 10:07:31.863235	2011-08-12 10:07:31.863235	\\[x = 7\\]	1
851	29	\\[9 = y + 1.5\\]	2011-08-12 10:07:31.866757	2011-08-12 10:07:31.866757	\\[7.5 = y\\]	1
852	29	\\[6 = 0.8 + x\\]	2011-08-12 10:07:31.870218	2011-08-12 10:07:31.870218	\\[5.2 = x\\]	1
853	29	\\[x - 3 = 2.9\\]	2011-08-12 10:07:31.873826	2011-08-12 10:07:31.873826	\\[x = 5.9\\]	1
854	29	\\[y - 1 = 0.4\\]	2011-08-12 10:07:31.877436	2011-08-12 10:07:31.877436	\\[y = 1.4\\]	1
855	29	\\[w + 3 = 4\\]	2011-08-12 10:07:31.880954	2011-08-12 10:07:31.880954	\\[w = 1\\]	1
856	29	\\[x + 2.5 = 11\\]	2011-08-12 10:07:31.886247	2011-08-12 10:07:31.886247	\\[x = 8.5\\]	1
857	29	\\[w + 4.7 = 9\\]	2011-08-12 10:07:31.890495	2011-08-12 10:07:31.890495	\\[w = 4.3\\]	1
858	29	\\[5.6 = m - 3.4\\]	2011-08-12 10:07:31.894371	2011-08-12 10:07:31.894371	\\[9 = m\\]	1
859	29	\\[6.8 = x - 3\\]	2011-08-12 10:07:31.898691	2011-08-12 10:07:31.898691	\\[9.8 = x\\]	1
860	29	\\[4.4 + y = 5\\]	2011-08-12 10:07:31.902291	2011-08-12 10:07:31.902291	\\[y = 0.6\\]	1
861	29	\\[10 = y + 3\\]	2011-08-12 10:07:31.906182	2011-08-12 10:07:31.906182	\\[7 = y\\]	1
862	29	\\[8 = x + 3\\]	2011-08-12 10:07:31.909727	2011-08-12 10:07:31.909727	\\[5 = x\\]	1
863	29	\\[3.3 + y = 4\\]	2011-08-12 10:07:31.913239	2011-08-12 10:07:31.913239	\\[y = 0.7\\]	1
864	29	\\[6 = a + 0.2\\]	2011-08-12 10:07:31.916814	2011-08-12 10:07:31.916814	\\[5.8 = a\\]	1
865	29	\\[4.7 + x = 13\\]	2011-08-12 10:07:31.920254	2011-08-12 10:07:31.920254	\\[x = 8.3\\]	1
866	29	\\[y - 1.3 = 9.7\\]	2011-08-12 10:07:31.925432	2011-08-12 10:07:31.925432	\\[y = 11\\]	1
867	29	\\[x + 1.2 = 10\\]	2011-08-12 10:07:31.929589	2011-08-12 10:07:31.929589	\\[x = 8.8\\]	1
868	29	\\[3 = y + 1.3\\]	2011-08-12 10:07:31.933292	2011-08-12 10:07:31.933292	\\[1.7 = y\\]	1
869	29	\\[1 = a - 2\\]	2011-08-12 10:07:31.937609	2011-08-12 10:07:31.937609	\\[3 = a\\]	1
870	29	\\[y - 3.2 = 9.8\\]	2011-08-12 10:07:31.941673	2011-08-12 10:07:31.941673	\\[y = 13\\]	1
871	29	\\[4.4 + k = 13\\]	2011-08-12 10:07:31.94524	2011-08-12 10:07:31.94524	\\[k = 8.6\\]	1
872	29	\\[5.7 = y - 0.3\\]	2011-08-12 10:07:31.948755	2011-08-12 10:07:31.948755	\\[6 = y\\]	1
873	29	\\[x + 4.8 = 6\\]	2011-08-12 10:07:31.952215	2011-08-12 10:07:31.952215	\\[x = 1.2\\]	1
874	29	\\[x - 11 = 9.1\\]	2011-08-12 10:07:31.955711	2011-08-12 10:07:31.955711	\\[x = 20.1\\]	1
875	29	\\[1.9 = x - 1.1\\]	2011-08-12 10:07:31.959306	2011-08-12 10:07:31.959306	\\[3 = x\\]	1
876	29	\\[11 = m + 2\\]	2011-08-12 10:07:31.962933	2011-08-12 10:07:31.962933	\\[9 = m\\]	1
877	29	\\[4.6 = x - 7\\]	2011-08-12 10:07:31.966414	2011-08-12 10:07:31.966414	\\[11.6 = x\\]	1
878	29	\\[11 = 4.6 + w\\]	2011-08-12 10:07:31.970701	2011-08-12 10:07:31.970701	\\[6.4 = w\\]	1
879	29	\\[x + 2.6 = 12\\]	2011-08-12 10:07:31.974829	2011-08-12 10:07:31.974829	\\[x = 9.4\\]	1
880	29	\\[7 = x + 4.8\\]	2011-08-12 10:07:31.978563	2011-08-12 10:07:31.978563	\\[2.2 = x\\]	1
881	29	\\[k - 3 = 2.9\\]	2011-08-12 10:07:31.982278	2011-08-12 10:07:31.982278	\\[k = 5.9\\]	1
882	29	\\[5.7 = x - 3.3\\]	2011-08-12 10:07:31.986089	2011-08-12 10:07:31.986089	\\[9 = x\\]	1
883	29	\\[3.5 + m = 11\\]	2011-08-12 10:07:31.989803	2011-08-12 10:07:31.989803	\\[m = 7.5\\]	1
884	29	\\[a + 1.2 = 8\\]	2011-08-12 10:07:31.994554	2011-08-12 10:07:31.994554	\\[a = 6.8\\]	1
885	29	\\[1.1 + k = 3\\]	2011-08-12 10:07:31.998181	2011-08-12 10:07:31.998181	\\[k = 1.9\\]	1
886	29	\\[2.2 = k - 3\\]	2011-08-12 10:07:32.001879	2011-08-12 10:07:32.001879	\\[5.2 = k\\]	1
887	29	\\[13 = y + 4.7\\]	2011-08-12 10:07:32.005818	2011-08-12 10:07:32.005818	\\[8.3 = y\\]	1
888	29	\\[y - 13 = 1.1\\]	2011-08-12 10:07:32.009433	2011-08-12 10:07:32.009433	\\[y = 14.1\\]	1
889	29	\\[4.5 = x - 1.5\\]	2011-08-12 10:07:32.013224	2011-08-12 10:07:32.013224	\\[6 = x\\]	1
890	29	\\[x - 4.7 = 0.3\\]	2011-08-12 10:07:32.061413	2011-08-12 10:07:32.061413	\\[x = 5\\]	1
891	29	\\[m - 10 = 7\\]	2011-08-12 10:07:32.065926	2011-08-12 10:07:32.065926	\\[m = 17\\]	1
892	29	\\[8 = x + 2.6\\]	2011-08-12 10:07:32.070026	2011-08-12 10:07:32.070026	\\[5.4 = x\\]	1
893	29	\\[5 = k + 0.9\\]	2011-08-12 10:07:32.073805	2011-08-12 10:07:32.073805	\\[4.1 = k\\]	1
894	29	\\[x - 4.1 = 9.9\\]	2011-08-12 10:07:32.077829	2011-08-12 10:07:32.077829	\\[x = 14\\]	1
895	29	\\[12 = 3.7 + y\\]	2011-08-12 10:07:32.081487	2011-08-12 10:07:32.081487	\\[8.3 = y\\]	1
896	29	\\[y - 9 = 2.3\\]	2011-08-12 10:07:32.085576	2011-08-12 10:07:32.085576	\\[y = 11.3\\]	1
897	29	\\[x - 18 = 3.2\\]	2011-08-12 10:07:32.089554	2011-08-12 10:07:32.089554	\\[x = 21.2\\]	1
898	29	\\[x + 4.1 = 5\\]	2011-08-12 10:07:32.093443	2011-08-12 10:07:32.093443	\\[x = 0.9\\]	1
899	29	\\[7.4 = m - 1.6\\]	2011-08-12 10:07:32.096938	2011-08-12 10:07:32.096938	\\[9 = m\\]	1
900	30	\\[y + 2.6 = 3.1\\]	2011-08-12 10:07:40.111502	2011-08-12 10:07:40.111502	\\[y = 0.5\\]	1
901	30	\\[4.1 = k - 5.9\\]	2011-08-12 10:07:40.142944	2011-08-12 10:07:40.142944	\\[10 = k\\]	1
902	30	\\[15.4 = 0 + a\\]	2011-08-12 10:07:40.147385	2011-08-12 10:07:40.147385	\\[15.4 = a\\]	1
903	30	\\[w + 7.7 = 13.1\\]	2011-08-12 10:07:40.152464	2011-08-12 10:07:40.152464	\\[w = 5.4\\]	1
904	30	\\[x - 12 = 5.2\\]	2011-08-12 10:07:40.15625	2011-08-12 10:07:40.15625	\\[x = 17.2\\]	1
905	30	\\[w - 16 = 16.3\\]	2011-08-12 10:07:40.159748	2011-08-12 10:07:40.159748	\\[w = 32.3\\]	1
906	30	\\[29.8 = 18.7 + x\\]	2011-08-12 10:07:40.163297	2011-08-12 10:07:40.163297	\\[11.1 = x\\]	1
907	30	\\[17.5 = y - 16\\]	2011-08-12 10:07:40.167562	2011-08-12 10:07:40.167562	\\[33.5 = y\\]	1
908	30	\\[12.8 = x + 11.6\\]	2011-08-12 10:07:40.171526	2011-08-12 10:07:40.171526	\\[1.2 = x\\]	1
909	30	\\[19 = a + 7.3\\]	2011-08-12 10:07:40.175274	2011-08-12 10:07:40.175274	\\[11.7 = a\\]	1
910	30	\\[12.2 = x - 8\\]	2011-08-12 10:07:40.179157	2011-08-12 10:07:40.179157	\\[20.2 = x\\]	1
911	30	\\[29.3 = x + 16.9\\]	2011-08-12 10:07:40.182952	2011-08-12 10:07:40.182952	\\[12.4 = x\\]	1
912	30	\\[17 = 13.2 + y\\]	2011-08-12 10:07:40.187019	2011-08-12 10:07:40.187019	\\[3.8 = y\\]	1
913	30	\\[18.7 = 3 + w\\]	2011-08-12 10:07:40.1914	2011-08-12 10:07:40.1914	\\[15.7 = w\\]	1
914	30	\\[17.2 = 8.3 + x\\]	2011-08-12 10:07:40.194911	2011-08-12 10:07:40.194911	\\[8.9 = x\\]	1
915	30	\\[x - 15.3 = 14.4\\]	2011-08-12 10:07:40.198718	2011-08-12 10:07:40.198718	\\[x = 29.7\\]	1
916	30	\\[10.4 + x = 11.5\\]	2011-08-12 10:07:40.202592	2011-08-12 10:07:40.202592	\\[x = 1.1\\]	1
917	30	\\[a + 5.5 = 15.7\\]	2011-08-12 10:07:40.20628	2011-08-12 10:07:40.20628	\\[a = 10.2\\]	1
918	30	\\[19.5 = m - 10\\]	2011-08-12 10:07:40.209754	2011-08-12 10:07:40.209754	\\[29.5 = m\\]	1
919	30	\\[m - 18 = 14.5\\]	2011-08-12 10:07:40.21339	2011-08-12 10:07:40.21339	\\[m = 32.5\\]	1
920	30	\\[a + 17.7 = 33.1\\]	2011-08-12 10:07:40.217789	2011-08-12 10:07:40.217789	\\[a = 15.4\\]	1
921	30	\\[11.1 + k = 21.8\\]	2011-08-12 10:07:40.221489	2011-08-12 10:07:40.221489	\\[k = 10.7\\]	1
922	30	\\[w - 14 = 17.3\\]	2011-08-12 10:07:40.225139	2011-08-12 10:07:40.225139	\\[w = 31.3\\]	1
923	30	\\[27.6 = 18.7 + w\\]	2011-08-12 10:07:40.228909	2011-08-12 10:07:40.228909	\\[8.9 = w\\]	1
924	30	\\[16.8 = 11.1 + x\\]	2011-08-12 10:07:40.232433	2011-08-12 10:07:40.232433	\\[5.7 = x\\]	1
925	30	\\[a - 2.6 = 7.1\\]	2011-08-12 10:07:40.236014	2011-08-12 10:07:40.236014	\\[a = 9.7\\]	1
926	30	\\[8.8 = x - 12.5\\]	2011-08-12 10:07:40.239527	2011-08-12 10:07:40.239527	\\[21.3 = x\\]	1
927	30	\\[x + 16 = 28.4\\]	2011-08-12 10:07:40.243094	2011-08-12 10:07:40.243094	\\[x = 12.4\\]	1
928	30	\\[y - 5.2 = 9.3\\]	2011-08-12 10:07:40.246478	2011-08-12 10:07:40.246478	\\[y = 14.5\\]	1
929	30	\\[8.9 = x - 2.1\\]	2011-08-12 10:07:40.250203	2011-08-12 10:07:40.250203	\\[11 = x\\]	1
930	30	\\[10.5 = x + 3.5\\]	2011-08-12 10:07:40.253707	2011-08-12 10:07:40.253707	\\[7 = x\\]	1
931	30	\\[a - 17.2 = 10.3\\]	2011-08-12 10:07:40.257254	2011-08-12 10:07:40.257254	\\[a = 27.5\\]	1
932	30	\\[18.4 = m - 15.1\\]	2011-08-12 10:07:40.261429	2011-08-12 10:07:40.261429	\\[33.5 = m\\]	1
933	30	\\[y - 19 = 16.4\\]	2011-08-12 10:07:40.265916	2011-08-12 10:07:40.265916	\\[y = 35.4\\]	1
934	30	\\[13.3 + y = 24.5\\]	2011-08-12 10:07:40.270053	2011-08-12 10:07:40.270053	\\[y = 11.2\\]	1
935	30	\\[10.9 = y - 17\\]	2011-08-12 10:07:40.273852	2011-08-12 10:07:40.273852	\\[27.9 = y\\]	1
936	30	\\[x + 13.3 = 29.8\\]	2011-08-12 10:07:40.322008	2011-08-12 10:07:40.322008	\\[x = 16.5\\]	1
937	30	\\[x + 2.5 = 9.8\\]	2011-08-12 10:07:40.326022	2011-08-12 10:07:40.326022	\\[x = 7.3\\]	1
938	30	\\[14.1 = w - 19.1\\]	2011-08-12 10:07:40.330357	2011-08-12 10:07:40.330357	\\[33.2 = w\\]	1
939	30	\\[k - 16.5 = 11.6\\]	2011-08-12 10:07:40.335105	2011-08-12 10:07:40.335105	\\[k = 28.1\\]	1
940	30	\\[y + 18.8 = 23.6\\]	2011-08-12 10:07:40.339376	2011-08-12 10:07:40.339376	\\[y = 4.8\\]	1
941	30	\\[14.8 = 10.5 + x\\]	2011-08-12 10:07:40.343267	2011-08-12 10:07:40.343267	\\[4.3 = x\\]	1
942	30	\\[y - 4 = 13.4\\]	2011-08-12 10:07:40.346721	2011-08-12 10:07:40.346721	\\[y = 17.4\\]	1
943	30	\\[4.7 + k = 8.8\\]	2011-08-12 10:07:40.350327	2011-08-12 10:07:40.350327	\\[k = 4.1\\]	1
944	30	\\[w + 12.3 = 13.5\\]	2011-08-12 10:07:40.354207	2011-08-12 10:07:40.354207	\\[w = 1.2\\]	1
945	30	\\[19.6 + x = 36.2\\]	2011-08-12 10:07:40.35823	2011-08-12 10:07:40.35823	\\[x = 16.6\\]	1
946	30	\\[2.7 + x = 21.8\\]	2011-08-12 10:07:40.362314	2011-08-12 10:07:40.362314	\\[x = 19.1\\]	1
947	30	\\[x + 9.2 = 26.4\\]	2011-08-12 10:07:40.366514	2011-08-12 10:07:40.366514	\\[x = 17.2\\]	1
948	30	\\[x + 0.8 = 8.5\\]	2011-08-12 10:07:40.370556	2011-08-12 10:07:40.370556	\\[x = 7.7\\]	1
949	30	\\[1.8 = m - 7.2\\]	2011-08-12 10:07:40.374051	2011-08-12 10:07:40.374051	\\[9 = m\\]	1
950	30	\\[x - 19 = 3.8\\]	2011-08-12 10:07:40.37748	2011-08-12 10:07:40.37748	\\[x = 22.8\\]	1
951	30	\\[24.5 = x + 6.2\\]	2011-08-12 10:07:40.380904	2011-08-12 10:07:40.380904	\\[18.3 = x\\]	1
952	30	\\[15.1 = y - 19\\]	2011-08-12 10:07:40.384318	2011-08-12 10:07:40.384318	\\[34.1 = y\\]	1
953	30	\\[x + 9.9 = 29.8\\]	2011-08-12 10:07:40.387971	2011-08-12 10:07:40.387971	\\[x = 19.9\\]	1
954	30	\\[2.9 = x - 12.8\\]	2011-08-12 10:07:40.392676	2011-08-12 10:07:40.392676	\\[15.7 = x\\]	1
955	30	\\[y - 9 = 17.5\\]	2011-08-12 10:07:40.396273	2011-08-12 10:07:40.396273	\\[y = 26.5\\]	1
956	30	\\[x - 4 = 19.9\\]	2011-08-12 10:07:40.400451	2011-08-12 10:07:40.400451	\\[x = 23.9\\]	1
957	30	\\[14.4 = 4.5 + x\\]	2011-08-12 10:07:40.40419	2011-08-12 10:07:40.40419	\\[9.9 = x\\]	1
958	30	\\[7.8 + y = 11.1\\]	2011-08-12 10:07:40.407908	2011-08-12 10:07:40.407908	\\[y = 3.3\\]	1
959	30	\\[3.3 = x - 11.4\\]	2011-08-12 10:07:40.411731	2011-08-12 10:07:40.411731	\\[14.7 = x\\]	1
960	30	\\[x + 18.1 = 19.4\\]	2011-08-12 10:07:40.415643	2011-08-12 10:07:40.415643	\\[x = 1.3\\]	1
961	30	\\[y - 10 = 0.8\\]	2011-08-12 10:07:40.419618	2011-08-12 10:07:40.419618	\\[y = 10.8\\]	1
962	30	\\[34.1 = 14.4 + w\\]	2011-08-12 10:07:40.423271	2011-08-12 10:07:40.423271	\\[19.7 = w\\]	1
963	30	\\[7.3 + x = 24.1\\]	2011-08-12 10:07:40.426883	2011-08-12 10:07:40.426883	\\[x = 16.8\\]	1
964	30	\\[17 = y - 4.7\\]	2011-08-12 10:07:40.431924	2011-08-12 10:07:40.431924	\\[21.7 = y\\]	1
965	30	\\[17 + k = 21.8\\]	2011-08-12 10:07:40.435519	2011-08-12 10:07:40.435519	\\[k = 4.8\\]	1
966	30	\\[x - 15 = 6.8\\]	2011-08-12 10:07:40.439069	2011-08-12 10:07:40.439069	\\[x = 21.8\\]	1
967	30	\\[a + 7.8 = 11.3\\]	2011-08-12 10:07:40.442705	2011-08-12 10:07:40.442705	\\[a = 3.5\\]	1
968	30	\\[x + 7.3 = 16.7\\]	2011-08-12 10:07:40.446066	2011-08-12 10:07:40.446066	\\[x = 9.4\\]	1
969	30	\\[8.5 = x - 12.6\\]	2011-08-12 10:07:40.450267	2011-08-12 10:07:40.450267	\\[21.1 = x\\]	1
970	30	\\[7 = x - 2\\]	2011-08-12 10:07:40.454111	2011-08-12 10:07:40.454111	\\[9 = x\\]	1
971	30	\\[1.9 + w = 13.6\\]	2011-08-12 10:07:40.458298	2011-08-12 10:07:40.458298	\\[w = 11.7\\]	1
972	30	\\[25.6 = 11.2 + x\\]	2011-08-12 10:07:40.46228	2011-08-12 10:07:40.46228	\\[14.4 = x\\]	1
973	30	\\[3.7 + y = 8.9\\]	2011-08-12 10:07:40.46614	2011-08-12 10:07:40.46614	\\[y = 5.2\\]	1
974	30	\\[y - 4 = 5.4\\]	2011-08-12 10:07:40.469912	2011-08-12 10:07:40.469912	\\[y = 9.4\\]	1
975	30	\\[6.6 = k - 18\\]	2011-08-12 10:07:40.473785	2011-08-12 10:07:40.473785	\\[24.6 = k\\]	1
976	30	\\[17.3 = 12.1 + a\\]	2011-08-12 10:07:40.477258	2011-08-12 10:07:40.477258	\\[5.2 = a\\]	1
984	30	\\[8.3 = x - 2.2\\]	2011-08-12 10:07:40.507032	2011-08-12 10:07:40.507032	\\[10.5 = x\\]	1
985	30	\\[17.7 = 5.2 + m\\]	2011-08-12 10:07:40.51076	2011-08-12 10:07:40.51076	\\[12.5 = m\\]	1
986	30	\\[a + 12 = 17.3\\]	2011-08-12 10:07:40.514655	2011-08-12 10:07:40.514655	\\[a = 5.3\\]	1
987	30	\\[9.4 + y = 27.9\\]	2011-08-12 10:07:40.518334	2011-08-12 10:07:40.518334	\\[y = 18.5\\]	1
988	30	\\[16 + m = 27.9\\]	2011-08-12 10:07:40.522122	2011-08-12 10:07:40.522122	\\[m = 11.9\\]	1
989	30	\\[5.6 = x - 0\\]	2011-08-12 10:07:40.526073	2011-08-12 10:07:40.526073	\\[5.6 = x\\]	1
990	30	\\[k + 13.6 = 31.3\\]	2011-08-12 10:07:40.573921	2011-08-12 10:07:40.573921	\\[k = 17.7\\]	1
991	30	\\[m + 19.9 = 25.3\\]	2011-08-12 10:07:40.578656	2011-08-12 10:07:40.578656	\\[m = 5.4\\]	1
992	30	\\[12 = x - 19\\]	2011-08-12 10:07:40.582286	2011-08-12 10:07:40.582286	\\[31 = x\\]	1
993	30	\\[33 = x + 15.4\\]	2011-08-12 10:07:40.585944	2011-08-12 10:07:40.585944	\\[17.6 = x\\]	1
994	30	\\[22.5 = k + 2.9\\]	2011-08-12 10:07:40.590521	2011-08-12 10:07:40.590521	\\[19.6 = k\\]	1
995	30	\\[17.5 = x + 4.7\\]	2011-08-12 10:07:40.594229	2011-08-12 10:07:40.594229	\\[12.8 = x\\]	1
996	30	\\[19.2 = a + 3.3\\]	2011-08-12 10:07:40.598236	2011-08-12 10:07:40.598236	\\[15.9 = a\\]	1
997	30	\\[1.7 = x - 14\\]	2011-08-12 10:07:40.601967	2011-08-12 10:07:40.601967	\\[15.7 = x\\]	1
998	30	\\[5.8 = x - 4\\]	2011-08-12 10:07:40.605703	2011-08-12 10:07:40.605703	\\[9.8 = x\\]	1
999	30	\\[1.2 = 0 + x\\]	2011-08-12 10:07:40.609899	2011-08-12 10:07:40.609899	\\[1.2 = x\\]	1
1000	28	\\[m - .7 = 6\\]	2011-08-12 12:32:17.713807	2011-08-12 12:32:17.713807	\\[m = 6.7\\]	1
1001	28	\\[x + .4 = 5\\]	2011-08-12 12:32:59.755143	2011-08-12 12:32:59.755143	\\[x = 4.6\\]	1
1002	28	\\[w + 1.3 = 6.3\\]	2011-08-12 12:33:51.914906	2011-08-12 12:33:51.914906	\\[w = 6\\]	1
1003	31	\\[m + \\frac{1}{5} = 2\\]	2011-08-12 12:37:11.343056	2011-08-12 12:37:11.343056	\\[m  = 1\\frac{4}{5}\\]	1
1005	34	\\[k + .3 = .9\\]	2011-08-12 13:03:38.708561	2011-08-12 13:03:38.708561	\\[k = .6\\]	1
1006	34	\\[0.2 = x - 0.3\\]	2011-08-12 13:05:04.367457	2011-08-12 13:06:35.363408	\\[0.5 = x\\]	1
1004	35	\\[\\frac{1}{7} + w = \\frac{4}{7}\\]	2011-08-12 12:38:39.032711	2011-08-12 13:36:03.30443	\\[w = \\frac{3}{7}\\]	1
1007	35	\\[\\frac{3}{9} = a - \\frac{2}{9}\\]	2011-08-12 14:58:06.13528	2011-08-12 14:58:06.13528	\\[\\frac{5}{9} = a\\]	1
1008	31	\\[w - \\frac{4}{11} = 2\\frac{7}{11} \\]	2011-08-12 15:00:04.981227	2011-08-12 15:00:04.981227	\\[w = 3\\]	1
1010	33	\\[1\\frac{4}{5} = x - 2\\frac{3}{5} \\]	2011-08-12 15:05:28.175371	2011-08-12 15:05:28.175371	\\[4\\frac{2}{5} = x\\]	1
1009	33	\\[1\\frac{2}{5} + x = 2\\frac{3}{5} \\]	2011-08-12 15:03:30.176116	2011-08-12 15:08:31.432694	\\[x = 1\\frac{1}{5} \\text{or} \\frac{6}{5} \\]	1
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
24	11	1	2011-08-11 18:20:53.445025	2011-08-11 18:20:53.445025
25	11	2	2011-08-11 18:22:14.561269	2011-08-11 18:22:14.561269
26	11	3	2011-08-11 18:22:23.006127	2011-08-11 18:22:23.006127
27	11	4	2011-08-11 19:03:29.366656	2011-08-11 19:03:29.366656
33	13	3	2011-08-12 12:35:17.424921	2011-08-12 12:35:17.424921
29	12	3	2011-08-12 10:05:05.027857	2011-08-12 12:58:32.129585
28	12	2	2011-08-12 10:04:56.268592	2011-08-12 12:58:37.809239
34	12	1	2011-08-12 12:58:47.530046	2011-08-12 12:58:47.530046
30	12	4	2011-08-12 10:05:13.566136	2011-08-12 13:32:08.52831
31	13	2	2011-08-12 12:34:58.070903	2011-08-12 13:35:16.651255
35	13	1	2011-08-12 13:35:52.819369	2011-08-12 13:35:52.819369
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
11	8	2011-08-11 18:20:53.438206	2011-08-11 19:13:20.506727	t	Simple Equations with Positive Integers, No Coefficients, Addition and Subtraction	simple-equations-with-positive-integers-no-coefficients-addition-and-subtraction	2	3
12	8	2011-08-12 10:04:56.256002	2011-08-12 10:04:56.256002	t	Simple Equations with Decimals, No Coefficients, Addition and Subtraction	simple-equations-with-decimals-no-coefficients-addition-and-subtraction	2	3
13	8	2011-08-12 12:34:58.064225	2011-08-12 12:34:58.064225	t	Simple Equations with Fractions, No Coefficients, Addition and Subtraction	simple-equations-with-fractions-no-coefficients-addition-and-subtraction	2	3
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
20110812152409
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
2	alexauritt@gmail.com	$2a$10$A1XU.3c0TOzD2w1BcviNr.vNYytsolWkMsHKlP8v3L3vNp8w7rKn6	\N	\N	\N	18	2011-08-12 09:55:47.219557	2011-07-29 16:53:32.832613	80.137.234.166	84.191.63.252	2011-07-04 16:03:17.396792	2011-08-12 09:55:47.224315
3	audrey_federman@yahoo.com	$2a$10$BeC1llyJV.cr6/Ywo11nC.h8dSXjdrXOmX0g4ry4VAoz7iRma79da	\N	\N	\N	1	2011-07-05 23:35:32.862924	2011-07-05 23:35:32.862924	80.137.224.39	80.137.224.39	2011-07-04 16:40:00.704632	2011-07-05 23:35:32.925882
\.


--
-- Data for Name: worksheet_problems; Type: TABLE DATA; Schema: public; Owner: alexauritt
--

COPY worksheet_problems (id, worksheet_id, math_problem_id, problem_number, created_at, updated_at) FROM stdin;
1	1	1	1	2011-05-03 19:10:31.703793	2011-05-03 19:10:31.703793
2	1	2	2	2011-05-03 19:10:31.714007	2011-05-03 19:10:31.714007
6	1	8	6	2011-05-03 19:10:31.746036	2011-07-27 10:43:48.445453
7	1	11	7	2011-05-03 19:10:31.764176	2011-07-27 10:43:46.665326
8	1	12	8	2011-05-03 19:10:31.769407	2011-07-27 10:43:45.233848
9	1	14	9	2011-05-03 19:10:31.774256	2011-05-03 19:10:31.774256
10	1	15	10	2011-05-03 19:10:31.779661	2011-05-03 19:10:31.779661
11	1	16	11	2011-05-03 19:10:31.797217	2011-05-03 19:10:31.797217
12	1	17	12	2011-05-03 19:10:31.805573	2011-05-03 19:10:31.805573
3	1	3	3	2011-05-03 19:10:31.719957	2011-08-12 12:29:57.212361
4	1	4	4	2011-05-03 19:10:31.725162	2011-08-12 12:29:59.570596
5	1	7	5	2011-05-03 19:10:31.730281	2011-08-12 12:30:02.704309
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

