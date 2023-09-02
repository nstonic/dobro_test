--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Debian 14.8-1.pgdg120+1)
-- Dumped by pg_dump version 14.8 (Debian 14.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO dobro;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO dobro;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO dobro;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO dobro;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO dobro;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO dobro;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO dobro;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO dobro;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO dobro;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO dobro;

--
-- Name: todo_category; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.todo_category (
    id bigint NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.todo_category OWNER TO dobro;

--
-- Name: todo_category_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.todo_category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.todo_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: todo_task; Type: TABLE; Schema: public; Owner: dobro
--

CREATE TABLE public.todo_task (
    id bigint NOT NULL,
    title character varying(256) NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    done_at timestamp with time zone,
    category_id bigint,
    complete_due timestamp with time zone,
    user_id integer NOT NULL
);


ALTER TABLE public.todo_task OWNER TO dobro;

--
-- Name: todo_task_id_seq; Type: SEQUENCE; Schema: public; Owner: dobro
--

ALTER TABLE public.todo_task ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.todo_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Категория	7	add_category
26	Can change Категория	7	change_category
27	Can delete Категория	7	delete_category
28	Can view Категория	7	view_category
29	Can add Задание	8	add_task
30	Can change Задание	8	change_task
31	Can delete Задание	8	delete_task
32	Can view Задание	8	view_task
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	pbkdf2_sha256$600000$Rnj0yPSpBTnlghqRgAnTAn$OfhMMA3wJ0PnGhlmFLiQvE+kTc2zzLE2AGRKpj5ixWU=	\N	f	user2				f	t	2023-09-02 11:51:57+00
2	pbkdf2_sha256$600000$63XmS51X4KNRUfswDKi8mJ$Yfmo/Oj2G02GafEX1/za6Aprt17w3FIOU1QenYWhq6c=	2023-09-02 13:36:11.389283+00	f	user1				f	t	2023-09-02 11:51:14+00
1	pbkdf2_sha256$600000$NwfiSwVEBJsmxwNrI08CQk$sn5l+2ee6qixAV5vlXB6E3Bm6Gz5YWHKUFAF68iCTak=	2023-09-02 13:36:43.341584+00	t	admin				t	t	2023-09-02 11:30:32.070575+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
1	2	32
2	2	25
3	2	26
4	2	27
5	2	28
6	2	29
7	2	30
8	2	31
9	3	32
10	3	25
11	3	26
12	3	27
13	3	28
14	3	29
15	3	30
16	3	31
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2023-09-02 11:51:15.092141+00	2	user1	1	[{"added": {}}]	4	1
2	2023-09-02 11:51:22.751287+00	2	user1	2	[]	4	1
3	2023-09-02 11:51:42.199039+00	2	user1	2	[{"changed": {"fields": ["User permissions"]}}]	4	1
4	2023-09-02 11:51:58.183735+00	3	user2	1	[{"added": {}}]	4	1
5	2023-09-02 11:52:06.041915+00	3	user2	2	[{"changed": {"fields": ["User permissions"]}}]	4	1
6	2023-09-02 11:56:56.09185+00	4	Покупки	3		7	1
7	2023-09-02 11:56:56.094195+00	3	Цвет	3		7	1
8	2023-09-02 11:56:56.095825+00	2	Цвет	3		7	1
9	2023-09-02 11:57:59.591763+00	1	Купить хлеба	2	[{"changed": {"fields": ["\\u041f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}}]	8	1
10	2023-09-02 13:37:00.166676+00	6	Малибу	2	[{"changed": {"fields": ["\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435"]}}]	8	1
11	2023-09-02 13:37:07.393389+00	5	Купить машину	2	[{"changed": {"fields": ["\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435"]}}]	8	1
12	2023-09-02 13:37:27.377301+00	2	Купить велосипед	2	[{"changed": {"fields": ["\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435", "\\u0421\\u043e\\u0434\\u0435\\u0440\\u0436\\u0438\\u043c\\u043e\\u0435"]}}]	8	1
13	2023-09-02 13:37:47.241258+00	5	Купить машину	2	[{"changed": {"fields": ["\\u0421\\u043e\\u0434\\u0435\\u0440\\u0436\\u0438\\u043c\\u043e\\u0435"]}}]	8	1
14	2023-09-02 13:37:59.019771+00	2	Купить велосипед	2	[{"changed": {"fields": ["\\u0421\\u0434\\u0435\\u043b\\u0430\\u043d\\u043e"]}}]	8	1
15	2023-09-02 13:38:08.162949+00	6	Малибу	2	[{"changed": {"fields": ["\\u0421\\u0434\\u0435\\u043b\\u0430\\u0442\\u044c \\u0434\\u043e"]}}]	8	1
16	2023-09-02 14:10:00.580563+00	7	Подарок	1	[{"added": {}}]	8	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	todo	category
8	todo	task
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2023-09-02 11:30:16.663075+00
2	auth	0001_initial	2023-09-02 11:30:16.771915+00
3	admin	0001_initial	2023-09-02 11:30:16.80463+00
4	admin	0002_logentry_remove_auto_add	2023-09-02 11:30:16.815424+00
5	admin	0003_logentry_add_action_flag_choices	2023-09-02 11:30:16.825359+00
6	contenttypes	0002_remove_content_type_name	2023-09-02 11:30:16.842011+00
7	auth	0002_alter_permission_name_max_length	2023-09-02 11:30:16.851293+00
8	auth	0003_alter_user_email_max_length	2023-09-02 11:30:16.860488+00
9	auth	0004_alter_user_username_opts	2023-09-02 11:30:16.872852+00
10	auth	0005_alter_user_last_login_null	2023-09-02 11:30:16.882417+00
11	auth	0006_require_contenttypes_0002	2023-09-02 11:30:16.885838+00
12	auth	0007_alter_validators_add_error_messages	2023-09-02 11:30:16.895659+00
13	auth	0008_alter_user_username_max_length	2023-09-02 11:30:16.909839+00
14	auth	0009_alter_user_last_name_max_length	2023-09-02 11:30:16.918436+00
15	auth	0010_alter_group_name_max_length	2023-09-02 11:30:16.929299+00
16	auth	0011_update_proxy_permissions	2023-09-02 11:30:16.939171+00
17	auth	0012_alter_user_first_name_max_length	2023-09-02 11:30:16.947879+00
18	sessions	0001_initial	2023-09-02 11:30:16.973347+00
19	todo	0001_initial	2023-09-02 11:30:16.991792+00
20	todo	0002_alter_category_options_alter_task_options	2023-09-02 11:30:16.998575+00
21	todo	0003_task_complete_due	2023-09-02 11:30:17.004055+00
22	todo	0004_task_user	2023-09-02 11:30:17.019411+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
rvc9uxl3ltf4xpdtn5dsbx1gqnz8gzmn	.eJxVjMsOwiAQRf-FtSHATHm4dO83EBhAqgaS0q6M_65NutDtPefcF_NhW6vfRl78nNiZSXb63WKgR247SPfQbp1Tb-syR74r_KCDX3vKz8vh_h3UMOq3pmgQ3KQkYZCyaC1KsqiETqUoZ0BNVlAQYFxUBMJAkRHRWYQSURtk7w_A7Taw:1qcQnr:1_x6WbkVz1eShZQsk2n__XniViHTchk25rO60XMXHfw	2023-09-16 13:36:43.34382+00
\.


--
-- Data for Name: todo_category; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.todo_category (id, name) FROM stdin;
1	Покупки
5	Поездки
\.


--
-- Data for Name: todo_task; Type: TABLE DATA; Schema: public; Owner: dobro
--

COPY public.todo_task (id, title, content, created_at, done_at, category_id, complete_due, user_id) FROM stdin;
5	Купить машину	Ferrary	2023-09-02 12:08:16.587849+00	\N	1	\N	2
2	Купить велосипед	спортивный	2023-09-02 11:59:40.926235+00	2023-09-02 13:37:58+00	1	\N	2
6	Малибу	Съездить отдохнуть	2023-09-02 12:08:51.462133+00	\N	5	2023-09-01 12:08:00+00	2
7	Подарок	Купить подарок жене на ДР	2023-09-02 14:10:00.578935+00	\N	1	2023-09-03 14:00:00+00	3
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 32, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 3, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 16, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 16, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 8, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 22, true);


--
-- Name: todo_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.todo_category_id_seq', 5, true);


--
-- Name: todo_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dobro
--

SELECT pg_catalog.setval('public.todo_task_id_seq', 7, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: todo_category todo_category_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.todo_category
    ADD CONSTRAINT todo_category_pkey PRIMARY KEY (id);


--
-- Name: todo_task todo_task_pkey; Type: CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.todo_task
    ADD CONSTRAINT todo_task_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: todo_task_category_id_fb0c0926; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX todo_task_category_id_fb0c0926 ON public.todo_task USING btree (category_id);


--
-- Name: todo_task_user_id_69f329a5; Type: INDEX; Schema: public; Owner: dobro
--

CREATE INDEX todo_task_user_id_69f329a5 ON public.todo_task USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: todo_task todo_task_category_id_fb0c0926_fk_todo_category_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.todo_task
    ADD CONSTRAINT todo_task_category_id_fb0c0926_fk_todo_category_id FOREIGN KEY (category_id) REFERENCES public.todo_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: todo_task todo_task_user_id_69f329a5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dobro
--

ALTER TABLE ONLY public.todo_task
    ADD CONSTRAINT todo_task_user_id_69f329a5_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
