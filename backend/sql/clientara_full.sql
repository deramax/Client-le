--
-- PostgreSQL database dump
--

\restrict x370ScUhS49KwThcKAKnUBG0UHyvJMYOsYYDMRxfjShqNPn0UGjo9ZuclBmfHU6

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

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

ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_user_id_e4f0a161_fk_accounts_;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_permission_id_113bb443_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_52b62117_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_group_id_bd11a704_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.accounts_notificationread DROP CONSTRAINT IF EXISTS accounts_notificationread_user_id_2d149268_fk_accounts_user_id;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.core_refitem_category_242bb6f5_like;
DROP INDEX IF EXISTS public.core_refitem_category_242bb6f5;
DROP INDEX IF EXISTS public.core_demande_refnum_34b30bd4_like;
DROP INDEX IF EXISTS public.core_demande_refnum_34b30bd4;
DROP INDEX IF EXISTS public.core_demande_fid_id_8945d7ef_like;
DROP INDEX IF EXISTS public.core_clientrecord_refnum_b7cdf157_like;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_user_id_e4f0a161;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_permission_id_113bb443;
DROP INDEX IF EXISTS public.accounts_user_login_c2ed0b12_like;
DROP INDEX IF EXISTS public.accounts_user_groups_user_id_52b62117;
DROP INDEX IF EXISTS public.accounts_user_groups_group_id_bd11a704;
DROP INDEX IF EXISTS public.accounts_role_key_82a0f15e_like;
DROP INDEX IF EXISTS public.accounts_notificationread_user_id_2d149268;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.core_refitem DROP CONSTRAINT IF EXISTS core_refitem_pkey;
ALTER TABLE IF EXISTS ONLY public.core_refitem DROP CONSTRAINT IF EXISTS core_refitem_category_value_46efedba_uniq;
ALTER TABLE IF EXISTS ONLY public.core_demande DROP CONSTRAINT IF EXISTS core_demande_pkey;
ALTER TABLE IF EXISTS ONLY public.core_demande DROP CONSTRAINT IF EXISTS core_demande_fid_id_key;
ALTER TABLE IF EXISTS ONLY public.core_clientrecord DROP CONSTRAINT IF EXISTS core_clientrecord_refnum_key;
ALTER TABLE IF EXISTS ONLY public.core_clientrecord DROP CONSTRAINT IF EXISTS core_clientrecord_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_login_key;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_group_id_59c0b32f_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_role DROP CONSTRAINT IF EXISTS accounts_role_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_role DROP CONSTRAINT IF EXISTS accounts_role_key_key;
ALTER TABLE IF EXISTS ONLY public.accounts_notificationread DROP CONSTRAINT IF EXISTS accounts_notificationread_user_id_notif_id_2dbc7015_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_notificationread DROP CONSTRAINT IF EXISTS accounts_notificationread_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_auditlogentry DROP CONSTRAINT IF EXISTS accounts_auditlogentry_pkey;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.core_refitem;
DROP TABLE IF EXISTS public.core_demande;
DROP TABLE IF EXISTS public.core_clientrecord;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.accounts_user_user_permissions;
DROP TABLE IF EXISTS public.accounts_user_groups;
DROP TABLE IF EXISTS public.accounts_user;
DROP TABLE IF EXISTS public.accounts_role;
DROP TABLE IF EXISTS public.accounts_notificationread;
DROP TABLE IF EXISTS public.accounts_auditlogentry;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_auditlogentry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_auditlogentry (
    id bigint NOT NULL,
    action character varying(200) NOT NULL,
    login character varying(120) NOT NULL,
    ts timestamp with time zone NOT NULL,
    device character varying(40) NOT NULL,
    ip inet
);


--
-- Name: accounts_auditlogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_auditlogentry ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_auditlogentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_notificationread; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_notificationread (
    id bigint NOT NULL,
    notif_id character varying(160) NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: accounts_notificationread_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_notificationread ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_notificationread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_role (
    id bigint NOT NULL,
    key character varying(40) NOT NULL,
    name character varying(120) NOT NULL,
    description character varying(255) NOT NULL,
    locked boolean NOT NULL,
    "order" integer NOT NULL,
    permissions jsonb NOT NULL
);


--
-- Name: accounts_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_role ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    login character varying(120) NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    phone character varying(60) NOT NULL,
    role character varying(40) NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    must_change_password boolean NOT NULL,
    mfa_enabled boolean NOT NULL,
    mfa_secret character varying(64) NOT NULL,
    photo text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.accounts_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: core_clientrecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_clientrecord (
    id bigint NOT NULL,
    refnum character varying(60) NOT NULL,
    nom_client character varying(200) NOT NULL
);


--
-- Name: core_clientrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_clientrecord ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_clientrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_demande; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_demande (
    id bigint NOT NULL,
    fid_id character varying(40) NOT NULL,
    id_fid character varying(20) NOT NULL,
    date_reception character varying(20) NOT NULL,
    site character varying(120) NOT NULL,
    agent_fidelisation character varying(120) NOT NULL,
    refnum character varying(60) NOT NULL,
    nom_client character varying(200) NOT NULL,
    technologie character varying(80) NOT NULL,
    ref_produit character varying(80) NOT NULL,
    ancien_produit character varying(160) NOT NULL,
    ancien_mensualite_ttc double precision NOT NULL,
    date_contrat character varying(20) NOT NULL,
    requete_client character varying(80) NOT NULL,
    motif character varying(160) NOT NULL,
    information_libre text NOT NULL,
    action character varying(80) NOT NULL,
    niveau_decision character varying(40) NOT NULL,
    date_cloture character varying(20) NOT NULL,
    agent_confirmation character varying(120) NOT NULL,
    date_prevue_execution character varying(20) NOT NULL,
    priorite character varying(40) NOT NULL,
    ref_nouv_produit character varying(80) NOT NULL,
    nouveau_produit character varying(160) NOT NULL,
    nouveau_mensualite_ttc double precision NOT NULL,
    nouveau_nom character varying(200) NOT NULL,
    date_nv_contrat character varying(20) NOT NULL,
    audit jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: core_demande_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_demande ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_demande_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_refitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_refitem (
    id bigint NOT NULL,
    category character varying(40) NOT NULL,
    value character varying(160) NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: core_refitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_refitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_refitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Data for Name: accounts_auditlogentry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_auditlogentry (id, action, login, ts, device, ip) FROM stdin;
\.


--
-- Data for Name: accounts_notificationread; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_notificationread (id, notif_id, user_id) FROM stdin;
\.


--
-- Data for Name: accounts_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_role (id, key, name, description, locked, "order", permissions) FROM stdin;
1	administrateur	Administrateur	Accès total et inconditionnel	t	0	{"audit": {"edit": true, "view": true, "create": true, "delete": true}, "clients": {"edit": true, "view": true, "create": true, "delete": true}, "journal": {"edit": true, "view": true, "create": true, "delete": true}, "rapports": {"edit": true, "view": true, "create": true, "delete": true}, "dashboard": {"edit": true, "view": true, "create": true, "delete": true}, "parametres": {"edit": true, "view": true, "create": true, "delete": true}, "notifications": {"edit": true, "view": true, "create": true, "delete": true}, "visualisation": {"edit": true, "view": true, "create": true, "delete": true}}
2	responsable	Responsable fidélisation	Supervision & traitement	f	1	{"audit": {"edit": false, "view": true, "create": false, "delete": false}, "clients": {"edit": true, "view": true, "create": true, "delete": false}, "journal": {"edit": false, "view": true, "create": false, "delete": false}, "rapports": {"edit": false, "view": true, "create": false, "delete": false}, "dashboard": {"edit": false, "view": true, "create": false, "delete": false}, "parametres": {"edit": true, "view": true, "create": false, "delete": false}, "notifications": {"edit": false, "view": true, "create": true, "delete": false}, "visualisation": {"edit": true, "view": true, "create": true, "delete": true}}
3	agent	Agent de fidélisation	Traitement opérationnel des requêtes	f	2	{"audit": {"edit": false, "view": false, "create": false, "delete": false}, "clients": {"edit": true, "view": true, "create": true, "delete": false}, "journal": {"edit": false, "view": false, "create": false, "delete": false}, "rapports": {"edit": false, "view": true, "create": false, "delete": false}, "dashboard": {"edit": false, "view": true, "create": false, "delete": false}, "parametres": {"edit": false, "view": false, "create": false, "delete": false}, "notifications": {"edit": false, "view": true, "create": false, "delete": false}, "visualisation": {"edit": true, "view": true, "create": true, "delete": false}}
4	direction	Direction	Lecture & statistiques, sans modification métier	f	3	{"audit": {"edit": false, "view": false, "create": false, "delete": false}, "clients": {"edit": false, "view": true, "create": false, "delete": false}, "journal": {"edit": false, "view": false, "create": false, "delete": false}, "rapports": {"edit": false, "view": true, "create": false, "delete": false}, "dashboard": {"edit": false, "view": true, "create": false, "delete": false}, "parametres": {"edit": false, "view": true, "create": false, "delete": false}, "notifications": {"edit": false, "view": true, "create": false, "delete": false}, "visualisation": {"edit": false, "view": true, "create": false, "delete": false}}
5	audit	Audit	Lecture seule & accès au journal	f	4	{"audit": {"edit": false, "view": true, "create": false, "delete": false}, "clients": {"edit": false, "view": true, "create": false, "delete": false}, "journal": {"edit": false, "view": true, "create": false, "delete": false}, "rapports": {"edit": false, "view": true, "create": false, "delete": false}, "dashboard": {"edit": false, "view": true, "create": false, "delete": false}, "parametres": {"edit": false, "view": true, "create": false, "delete": false}, "notifications": {"edit": false, "view": true, "create": false, "delete": false}, "visualisation": {"edit": false, "view": true, "create": false, "delete": false}}
\.


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user (id, password, last_login, is_superuser, login, full_name, email, phone, role, is_active, is_staff, must_change_password, mfa_enabled, mfa_secret, photo, created_at) FROM stdin;
1	pbkdf2_sha256$870000$BzDj2UTvQ6igishh07uKls$FgE3e/cldkLiEG/xqbEOCW0763Rzza9kOuEMevQZHuA=	\N	t	admin	Administrateur			administrateur	t	t	f	f			2026-06-19 11:05:24.077574+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
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
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add audit log entry	6	add_auditlogentry
22	Can change audit log entry	6	change_auditlogentry
23	Can delete audit log entry	6	delete_auditlogentry
24	Can view audit log entry	6	view_auditlogentry
25	Can add role	7	add_role
26	Can change role	7	change_role
27	Can delete role	7	delete_role
28	Can view role	7	view_role
29	Can add user	8	add_user
30	Can change user	8	change_user
31	Can delete user	8	delete_user
32	Can view user	8	view_user
33	Can add notification read	9	add_notificationread
34	Can change notification read	9	change_notificationread
35	Can delete notification read	9	delete_notificationread
36	Can view notification read	9	view_notificationread
37	Can add client record	10	add_clientrecord
38	Can change client record	10	change_clientrecord
39	Can delete client record	10	delete_clientrecord
40	Can view client record	10	view_clientrecord
41	Can add demande	11	add_demande
42	Can change demande	11	change_demande
43	Can delete demande	11	delete_demande
44	Can view demande	11	view_demande
45	Can add ref item	12	add_refitem
46	Can change ref item	12	change_refitem
47	Can delete ref item	12	delete_refitem
48	Can view ref item	12	view_refitem
\.


--
-- Data for Name: core_clientrecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_clientrecord (id, refnum, nom_client) FROM stdin;
1	491451	NOMENA ANJARA AINA Mandresy
2	515109	RANDRIAMANANA Mampionona Donatien
3	41644	M. MILLOT Gérard Pierre Jacques
4	483195	RAFIDISON Lovaniaina Patricia
5	472919	RASONARIVO Rihatiana Harson
6	469001	RAHANDONANDRASANA Romis Afabitana
7	5620	RABARY Jean Germain
8	5667	Société. ENERGIS FD
9	5828	Société. AXELLE SARL
10	6875	RASOAMIHAJA Sedera
11	7345	RAJAONARISON Guy Etienne
12	7536	RAMANANARIVO Rossit Lucel
13	8382	PROSPERITY EARTH SARL
14	8608	RAZAFINDRALANDY Voahirana
15	8748	RANAIVO Anthelme Odet
16	9117	RAKOTOMALALA Ange Nirina
17	9293	RESAMPA Antoni Ludovick
18	9823	GIROD Virginie
19	10121	RAMAROKOTO Ketamalala
20	10636	RANDRIANATOANDRO Tahiana
21	11522	ANDRIAMIALISOA Rivoandriantsalama J
22	11800	RATOVONDRAHETY Elisabeth Bodo Farasoa
23	12027	RAMAROSAONA Faraniaina Emilia
24	12053	RAMAMONJISOA Miandra Lalaina
25	12265	RASOAZANANY RASOANILANA Armance
26	13201	MAKAMASY Tsitavane Velomanarina
27	13318	RAKOTOMANANA Harinaina Aivonirina
28	14260	RANDRIAMALALA Njarasoa Charlette
29	14457	RAKOTOMANGA Radonirina Zafinjatovo
30	14500	RAJAONARISON José Serge
31	14919	RAZAFINDRAKOTO MAMONJISOA Roger André
32	15462	RANANJA ANDRIATAHIANA Valérie Nivohanta
33	15702	RAYMOND
34	15870	RAMAROJAONA Fenitra Stella /RANIRIARIMANANA Lantoarisoa
35	17676	RAKOTONIRINA Charles
36	18179	ANDRIAMITANTSOA Samoela Ny Onja Christian
37	19507	RAZAFINIMARO Jean William
38	19695	RASOLONDRAIBE Jean Yves
39	21153	ANDRIAMALALA Hajaniaina Lanto Rivosoa
40	21775	RAKOTOARIVAO Tolotra Nandrasana
41	22293	COLLEGE P'TIT MICHOU
42	22477	ANDRIAMPARANY Vatosoa Vololonandriana
43	22586	RAHAROMISA Hajasoa
44	22666	RABEMIHOATRA Laurent Harijao
45	22912	AOMET SARLU
46	22927	RASOAZANANORO Mirana Lalaina
47	23124	RAKOTONDRATSIMBA Sylvie Marie
48	24079	RAMANANTSOA Sylvie Lalatiana
49	24262	Association Chrétienne ANDAO HITIA/ RASOANARIVO Andrianirina Christian
50	24574	RASAMOELINA Seranirina Sylviane / INFOTYP MADA SHORE
51	25312	RAZAFIMALALA Verosahondra
52	27041	RAMILISON Fanja Tiana Michèle
53	27683	RAFITOSON Redonné
54	28069	ANDRIANANTENAINAVALONA Jean Claude
55	28377	RAZAFINDRAKOTO Andriampanarivo Lalatiana
56	28528	RAKOTOMANGA Anna Nivovololona
57	28700	BERNARD
58	28880	RANDRIANAIVOARISON Claudia
59	30208	RANARIVONY Richard
60	30278	SOULTANALYDylr
61	31551	RAKOTOMALALA Jean Lalaina
62	34424	RATSIANDAVANA Alain Edgard
63	35784	RAZAFIARINELINA Marie Thérèse
64	36879	IAVISOA Heriniaina Viviane Pascaline
65	37266	HUO KANG Ludovic Ronny
66	37700	RAMAROKOTO Liana Lantoantenaina
67	39517	RAZAFINDRABE Zafinirina Andrianarijaona
68	40054	RATSIFANDRIHAMANANA Raivo Tiana
69	40509	RAMIANDRISOA Marie Juliette
70	41625	RAJAONARIVELO Henri
71	48386	ASSOCIATION PROMES
72	48483	RANDRIAMARO-MANANTENA Malala
73	49433	ANDRIAMAMPIANINA Mirana Tifania
74	49750	RAZAKAMALALATIANA Pierrot
75	50081	RAKOTONDRAINIBE Tanya Martina / RAKOTONDRAINIBE Ida Carene
76	50103	RAKOTONDRAINIBE Andrianombonana Haja Tiana
77	56845	RASAMIRAVAKA Tsiry
78	60297	ANDRIANIAINA Armand
79	66956	FIRAISAINA BEMASOANDRO
80	67505	ANDRINIAINA Nantenaina / HARILALA Sylvie Bienvenue Samueline
81	68111	RALAMBO Alain Narcisse
82	68285	RAFALISOLOHERINIRINA Hervé
83	68326	RAJAONARY MAMINJATOVO HENRI
84	68368	RANDRIANARIVELO Erica Nandrianina
85	68645	RASOLOFOSON Delphin
86	68659	Société. YASKA SARLU
87	68745	ALI Abid
88	70275	RATIARISOLO Noro Fy
89	70311	RANARIMANANA Joharitantely Bonnier Nambinina
90	70395	RAZANAMPARANY Malalasoa Marcelle
91	77365	RAHERISON Rija Eric
92	93797	RAHARINJATOVO Fanjava Fandresena
93	101517	RASOAMANANA Renée Colette
94	135850	RALAIVAO Dimbihary Alex Denis
95	141815	RANDRIANARISON Jean Claude Benatoandro
96	143527	RAKOTOHERINIAINA SEHENOARINJAKAMALALA TAHIRY
97	145238	ANDRIANARIVELO Daniel Thierry
98	146186	RASOAVATSARA VEROHANTA
99	152625	RAVALINIAINA Jean Desire
100	152923	COUSIN Thierry
101	173117	Société. HAREL MALLAC TECHNOLOGIE MADAGASCAR
102	182855	CASANA Mario Faller
103	199931	RAJERISON Patricia Wilmine
104	236521	RAMAMONJISOA Anjaramamy Hasinkarefo
105	241073	RATELOSON Andriamandrato Manitra Tojoniaina
106	256571	RASOLOFOMANANA Lovasoa Nirina
107	290655	BOURHIS Jean Raymond
108	306471	RAZAKARIVONY Andrianambinina Andriamarolahy
109	307532	RAHANTAMALALA Esperance Colombe
110	344879	RAVOTIANA Avotriniaina Angelo
111	352583	JAO-VENANTEric
112	368642	RAHARISON Mika Andoniaina Geraldo
113	379924	RASOLOARIMALALA Miora Henintsoa
114	395010	RAZAFIMBOLAFIDY Harilala
115	399682	RAZANAKOTONIRINA Mamy José
116	400136	RANDRIAMAMPIONONA Hobilalaina
117	407524	RAKOTOMALALA Domoina Rollande
118	415176	RABEMIAFARA Claudino
119	416086	RAHARIMANITRA-MALA Toky Jason Herman
120	449857	SOAVELO Hary Toky Nantenaina
121	449947	RAFALIRIVONISON Olivier Gerard
122	452995	RAJO Heriniaina
123	453187	RAMAMONJISOA Fara Rondro
124	453597	ANDRIANIRINA Mamitiana
125	453866	RAJAONARISON Jean Yves Harison
126	454124	IHOLIHARINIVO Lina Isabelle
127	454405	RAKOTOARIVONINA Tiana Hary Zo
128	454660	RATSIMANDRESY Andrianasara Faratiana Hasina
129	454679	RAHERIARISON ANDRIAMANANTENASOA Noëlson
130	454774	RANDROSO Naivo Solo Pascal James
131	454822	ANDRIANATOANDRO Sitraka Todisoa Fy
132	454896	ANDRIAMAMPIANINA Malalatiana
133	455074	RABEARIVELO Lalaina Fanantenana
134	455875	LANDRYS SARLU TIANA Harilalao
135	459720	APEM (Association pour la Promotion de l'Entreprise à Mada)
136	462772	RALAIBEZA Angelo Raphaël
137	467088	RAZANAJOARY Veloarimanana Sahondra
138	467455	Société. MADAGASCAR ASIA PLASTICS SARL
139	468376	RANDRIAMANALINA Haingonirina
140	468777	RANAIVOARISON Fenitra Harilova
141	469138	RASOLOFONJATOVO Harilala Augustin
142	469237	LANCIA HARRYS Liéckelle
143	469632	RANDRIANARISOAIbonia Lazandraibe
144	469713	SWAYZE Akbaraly Moise
145	469748	RAKOTOSON Johary Nantenaina
146	470074	RANDRIANARIMANANA Rija Désiré
147	470145	RAOBISOA RAELY Harimalala/ ASSOCIATION FUSION FIOMBONANANA MIFANASOA
148	470202	HASIMBOLA Ny Antsa
149	470306	ANDRIAMANANIAINA Niry Hantasoa Lutecia
150	470328	RAZAFIMAMY Vonindrahona Finaritra
151	470360	ANDRIAMBOLOLONA Noroniaina Mayah
152	470386	ANDRIAMAHEFARIVO Juano José Mario
153	470455	RAKOTONDRAHAJA Vololomahefa
154	470511	RANDRIANARIVONY Rija Frank
155	470635	HOSENY Fanomeza Clément / ANDRIANARISOA Fabien Chrysanthé
156	470652	RAKOTOMAHANINA Flore Gilberte
157	470702	DANG ép POMMERA Thi-My-Châu
158	470799	RAZAFINDRAKOTO Manjakasoa Murielle
159	470984	RANDRIAMAMPIONONA Elly / RAMILIARISOA Thérèsa Murielle
160	471266	WANG YUYING
161	471439	RAMANANTSOA Alison Judy Anna
162	471797	RASOARINELINANomery
163	471929	RAKOTOMANGA Maholinirina Solo
164	473137	ADAN Bryan
165	474824	AICHA Princesse Mariasy
166	475552	ANDRIHARINANDRASANA Anouchka Dominichinie
167	476048	RAKOTONDRAMANANA Tsitontarivo Robert
168	478467	RAMILISON Onja
169	478662	RALISON Miora Annick Léa
170	480737	RASOAMANANA Francia Onja
171	480854	MA WEIJUN
172	481847	HASIMBOLOLONA Santatra
173	483084	RAKOTONANDRASANA Ny Hasina Mahery
174	483213	RAKOTONDRAHOVA Anditiana Embona /RATREMA FINARITRA Mendrika Fitiavana
175	483641	ANDRIANIRINA Henintsoa Mirana
176	483882	RADIMIARISOA Miora Olga
177	483895	RAHARINANDRASANA Fenohasintsoa Allain
178	483921	MAGO Nirina Sandra
179	483930	ANDRIANIRIANAZAKA Jocellin
180	483936	MOHSIM ALI
181	483978	RAZAFIMAHATRATRA Maholinirina
182	484031	RAKOTOARIJAONA Naja Niaina Nanah
183	484041	RADIMIHARINOSY Hariseheno Hajanirina
184	484232	RAJAONARISON Mihajatiana
185	484614	OLIVOLOLONA Sylvie Fidèle
186	485240	RANDRIAMBELO Rojo Tiana Romaine
187	485378	RAMANAMPAMONJY Mirija Lalaina
188	485483	RAJAONERA Mirana Lolontiana /RAFANJAMBOLOLONIAINA Bakomalala
189	485670	RAMANANTSOAJacqui Daniel
190	485765	ANDRIANOELY Narisoa Justin
191	485796	RAZAFIMATRADRAIBE Aimé Marcel
192	485877	RAKOTONARIVO Zo Andrianina
193	485948	RANAIVOARISON Koloina Ambinintso
194	486211	RAMIALIHARISOA Harimahefa Santatriniaina
195	486225	ZAFIMANANA Rojoniaina Tantely Martial
196	486319	ANDRIANIAINA Landry
197	486363	RAHARISON Nomenjanahary Sombiniaina Cynthia
198	486495	RANAIVOSON Lantonirina Mariella
199	486711	RAKOTOSON Arisoa Finoana
200	486767	JUVENILLA Erasmie
201	487037	RATSILEFITRA Voahirana
202	487187	RABEONY Onjaniaina Jacquie
203	487188	MAMINIAINA Josoa
204	487231	RAKOTONDRABE Cathy Hanitra Harivelo
205	487270	RANDRIANANTENAINA Faniry Emile
206	487325	RASOLOMANANA RANTOTIANA Florent Cedrick
207	487331	RASOANIRIANA Anjara
208	487359	RAKOTONJANAHARY Mamitiana
209	487400	ANDRIANIRINA Nomenjanahary Ezoeson
210	487406	MIRAHERISOA Françia
211	487426	RAKOTOARIMANANA Rado Nirina Nomenjanahary
212	487434	RAMIANDRISOA Evatiana
213	487486	RAKOTONIRINA Tovondrainy Hemandimby
214	487515	NARISOA Tsiory Erica
215	487516	RAMAROSON Tolotraharimanga Jerindriantoky
216	487588	RAKOTONIAINA Njaratiana
217	487621	RAKOTONJANAHARY Tina Malala Ginnah
218	487708	RAMAROKOTO Onintsoa Rovaniaina
219	487794	ARINDRASANA Mialisoa Dorah
220	487814	BEZOKINY Irene Dorcia
221	487933	RAZANAMAHEFA Hanifitiavana Francesca
222	487945	RAMAROSON Nomentsoa Anne Marie/ RAMAROSON Anjaranandrianina Marie Annick
223	488040	BAILLETTE Daniel Edmond Joseph
224	488053	RAKOTONIRINA Gualbert Felix
225	488061	RANDRIANARISOA Domoina / RANDRIANARISOA Masoandrompitiavana Tojonirina
226	488472	ANDRIAFANIRY Niaina Lodhia
227	488616	MARA Sambelahatse
228	488642	RANDRIANJAFY Mbolatantely/ RANAIVOZAFY Tiana Lalaina Andrianjafy
229	488667	HELINIRINA Renee Eva Rasolomampionona/ MAMIARINELINA Asnah Jenny Oliviah
230	488714	RAKOTOMAHAZO Patricia Arisoa
231	488724	RAGOSITERA Bénédicth / MAHAMOUD'ALI Zo Tahina Janahary An-Oufidine
232	488756	RAKOTOBE Daniel Romuald
233	488907	RANDRIANAMBININA Nomenjanahary Mariella
234	489151	RANDRIAMAMENOMORAVELOSON Arnold / FANAMBINANAArofenitra
235	489298	RAMAROSON Tojonirina
236	489772	RAHARISON Harimbolatahina Luc
237	490317	RABENEFA Haritiana Zafizara
238	490542	RAKOTONDRAVONY Narivony Rindra
239	490869	ANDRIANJAFINDRAZANANY Parisolomalalarintsoa / RAKOTOMALALARINTSOA Santatra Fitahiana
240	491573	RAMAROHERY Nirina Tanteliniaina
241	491640	RADAFINIA Voaharimanjaka
242	491980	ADRINAH AZIR AMED FATIMAH / ANDRIAMAMBOLA Fandresena Marie Mathie
243	492434	PUNCHAMGOSS Shanawaz/ANDRIAMIALISOA Laurencia
244	494775	RANDRIAMAMPIANINA Aina Harinavalona
245	495597	NY MAHERITIANA Fanambinatsoa Mirija
246	501497	RANDRIANAIVO Njaratiana Fenosoa Ericà
247	504822	EZOTONDRAZA Emilson Fanoela Solomon
248	505404	SUDIKI Abdallah Oili
249	509546	RAKOTOARISON Micka Nomena
250	511237	ANDRIAMANALINA Fitahiana Ezra
251	512078	ZARA Cecilia /RASOANANDRASANA Marie Trecy
252	512148	RABESOLONIRINA Esthelle
253	238720	RANDRIANARIVONY Harizo Lantoniaina Rézah
254	10768	CITY IMMO
255	259947	CLIC MARKETING
256	26034	VOLOLONIRINAAngéline
257	29569	ANDRIANALISONHoly Irina
258	436380	RAKOTOARISEHENOMiarinantenaina Hobintsalama
259	453680	RAFALIMANANAFenosoa Nathalie
260	454590	ANDRIANASOLO LALADimbiharinetsa Jordy
261	455295	RAKOTOARIZANANY Bina Miharizo/MOHAMED CHEIKH Zacharia
262	455902	MAHAZAKASONRomina
263	466908	HADJI ABDALLAH Ben Mohamed / RAZAFITSALAMARemi Ibrahim
264	469606	RANDRIANJANAHARYKaho André
265	472518	RANDRIANTSOAHeran Tantely
266	472874	RAZAKARIMALALARovaniaia Annita
267	481477	RAKOTOARISOA Vonjinirina Fidèle / RAHARISOAMamisoa
268	487951	RAKOTOANDRIAMIALISOAMirado Ny Aina Antonio
269	488443	RAKOTOARIMANGA Koloinandro Mamiratra /RAKOTONARIVOTinah Emmanuelle Sombiniaina
270	49146	RATOVELOMANANASamoela
271	491876	RAMANARIVOVononanasoa Danielie
272	8907	RABEMILARaivo Soahary
273	491487	RAKOTONIRINA Christian
274	231918	RAKOTOSALAMA Malanto Zaholisoa
275	32607	FJKM Betafo Fanavaozana
276	437188	RANAIVOSON Herimiandrasoa José
277	475362	RAKOTOZAFY Faliarilala Vanessa
278	469524	RAMISARIMANGA Rinasoa Hasimboahangy
279	487538	RIJA Prosper
280	512055	RAKOTOARIMANGA Faniriniaina Noely
281	491979	RANDRIAMIHARISOA Sedimanana Sylvain
282	488800	RAZAFINIRINA Volantantely Edith Louisiane Marie
283	362468	ANDRIANARISOA Haja
284	455298	Société. MADAMONITOR
285	488736	NOMEJANAHARY Volahavana Joanah
286	467707	RAKOTOMANANA Nomenjanahary Fabienne Prisca
287	10165	ANDRIAMIFEHY Njakatahiry
288	485153	RANDRIANARISOA Harimbola Seraphin
289	512599	RAHARIMALALA Anny Sandra
290	491869	ANDRIAMBELOMANANTSIORY Tiana Christina /ANDRIAMBELONTSOA Hendrick Dano
291	488313	RAHARIFERA Tafitanirina Elia
292	491280	RAMANANTSOA Anja Landiniala
293	45201	HATRAIT ép GROLEAS Valérie Georgette Micheline
294	467692	RABENORO TSIORIHAMAMIANA Fanomezana / RAMANANTSOLOFO Maminirina Fabrice
295	493369	WEI Wenlu
296	40264	RAJOELINA Yves Hugues
297	50447	RANDRIANARISOA Sylvia Emmanuelle
298	487592	RANDRIARIVOLA Michael
299	499138	ANDRIANOMENJANAHARY Henri / ANDRIAMIHANTA née RASOARIVONY Rachelle
300	30389	RAZAFINJATOVO Aimé
301	45447	HANITRAMAHATRATRANIAINA Espérance Louisette
302	467706	RAJAOFERA Anthony Stéphan Claude
303	494924	RAKOTOMAHEFA Ny Avo Hajaina
304	491579	ANDRIAMANALINARIVO Hery Nantenaina Henintsoa
305	471896	RAKOTOMANGA Liva Heriniaina
306	491462	RANAIVOSON Tiana Harivelo Solondraibe
307	22640	RAMASIARINORO Rodialisoa
308	478404	RATIARAY Rado Alain Patrick
309	485735	RAKOTOARIMANGA Tinasoa Marcelin
310	18640	RAKOTOMANGA Verohasina
311	45566	RANDRIANAVONY Mihaja
312	10236	RANDRIANASOLO Brigitte Lalasoa
313	481789	ANDRIARIMALALA Ony Nomena Coralie
314	492717	ANDRIANASOLO Tojo Jean Tony
315	513374	RAHARIMANANA Jean Christale
316	68918	RATSIMANIVA Jackson Omer Elysé
317	12360	OLGA
318	491734	RAKOTOSOAVINA Iaina
319	437712	RABENJAARILALA Zolisoa
320	470758	RAKOTOARIVONY Annie Harimboahanginirina
321	490115	RAKOTONDRAINIBE Miranantenaina Nathalie
322	410776	RALAISANORO Sarobidinampoina Abraham
323	467668	BEARIVONY Meja Felantsoa
324	492487	FANOMEZANIARIVO Naftaly Tongatan/ RAMAROSON Rindra Diamondra
325	43372	RANDRIAMITANDRINA Fanomezantsoa
326	505428	PAHIJATO TOLOJANAHARY Prisca
327	487590	RASOANAIVO Mendrika
328	513683	ISSOUF EL Assad
329	485574	RANAIVOARISOA Lys Seheno
330	248169	ANDRIANASOLO Domohina noromalala
331	484415	RAKOTONINDRIANA Gaston
332	493111	HARINTSOA Sylvia Joel
333	43082	RAMBELOMANANA Lolona Ghislaine
334	479344	ANDRIANANTENAINA John Rubis
335	513015	RAKOTOARISOA Tolojanahary Olivier
336	473270	RANDRIAMIFIDY Annie Josepha
337	513899	RAKOTOVAZAHA Sambatra Finoana Mendrika
338	487776	INJANAHARY Haja Henintsoa
339	494072	RAMAROSON Maminiaina Sitraka
340	473475	RATOVONDRAINY Henri Johns
341	514009	DJABOURY Chakrina / SOA ISSIHAKA Mounirah
342	467822	DRIVE 4 WARD KOREA / GHAFOOR Abdul
343	317272	Société. SOCIETE GROUPE AUXILIAIRE
344	490662	RAZANABOLOLONA Tianna
345	482373	RAKOTONATREHANA Ankasitrahana Telina
346	494996	RASOLOARIJAONA Andry Malalatiana Nina Clara
347	462952	Société. ASSOCIATION DES FEMMES HANDICAPEES DE MADAGASCAR
348	6745	RAMAROVELO Hajaniaina Andry
349	490273	ANDRIANTSOA Ainanirina
350	493250	ANDRIANARIVO Sabine Larissa
351	488984	RAZAFIMANANTSOA Nivolalao Nadia
352	28123	RANAIVO Roger Eric
353	489681	RAKOTOMALALA Rivo Roland
354	35323	RABARISON Mamitiana
355	494820	RAKOTOARISOA Tanjonirina Jacob
356	496365	LO HIVE NAM Florence
357	494670	RAKOTOMALALA Mandrindra Fanambinana
358	446411	RAMBELOSON Irène Marie Claude
359	480535	RAHARISON Haingo Arimalala
360	50630	RAJASMINA Marie Claudia Fanja
361	511153	RAKOTOARIVELO Miarilala Andry Toky
362	493387	RAZAFIMANANTSOA Maminiriana Robinson/ RAZAFIMANANTSOA Mamy Nantenaina
363	13651	RAKOTOMALALA Faralahinirina Pierrot
364	492713	RANDRIAMBOAVONJY Lantsaniaina Fannya
365	493477	RAMAMONJISOA Fanjamalala Andriamasinoro
366	10354	HUGUET Née RAKOTONIAINA Annah
367	474804	TANG Rhoni Joel
368	24177	RASOANARIMALALA Harimanana
369	12401	RAKOTONDRABE ANDRIAMAHAY Fidy Ratsiivaina
370	492760	RAMAHOLISON Rivosoa Koloina Mariella
371	514376	IMAMOU Ali
372	493889	RASOANASOLO Harimanana
373	497097	HAMADIMBY Lespoir Jean Nicaisse
374	463359	RAHARISOA Mamison Evelyne
375	426597	RASOAMBOLANORO
376	473483	RANDRIANARIVELO Patricia Georgette
377	450906	RANAIVOSOA Julien Sombiniaina
378	11068	RAHAMALIARISON Hanitrarivelo Oliva
379	492079	RAJAONARISON Tafita Mampionona
380	497399	RAMIARISOLOSON Manda Herivelo
381	471882	ANDRIAMPANJAVA Jacob Félicien
382	30143	RAJAONERA Malalaniaina
383	440426	Société. SOS VILLAGES D'ENFANTS
384	303192	RASOLOTSIATOSIKINIAINA Jussy Marceinnie Katia
385	29698	BEZOKINY Iris Jacky
386	471041	RAVOKATRA Fenoharimina Akim/ RAKOTOARILALA Rina Danielle
387	28760	LAMBERT FIALAMBOLY
388	443807	ANDRIAMIJORO Harinivoson Mino
389	492759	ANDRIAMIARISOA Mialy Sarobidy/ SAROBIDY Jules Hortencia
390	8688	RAKOTOJAONA Antonin Jacques
391	487146	RAHELIARINIVO Sabine
392	493938	RATOVONJANAHARY Harivelo Larousso/ RAHELIARISOA Fanjaniaina
393	493576	RATOVONJANAHARY Harivelo Larousso
394	470090	Tanya Fashion Infinity/ RABAKONIRINA Faniritsoa Tanya
395	482203	ANTSAHIDY Raissa
396	473291	Société. AGENCE DE VOYAGE DUN HUANG
397	493115	RAJERISON Gabriel Jean Luc / JAONARIVELO Angelo
398	495734	RASOLOFONANAHARY Benjamin Radonirina
399	495803	RASOLONIAINA Martine
400	125486	RAVELOJAONA Patricia
401	484162	RANTOANINA Narimiandratiana Mahefatahina
402	493755	RAJAONAH Carole
403	492831	RANDRIAMANANJARA Heritiana Mickael
404	10013	RAKOTONDRABE Joshua Miary
405	514518	RAZOELINIRINA Sarah Annick
406	24635	ANDRIANTSONINA Ihantavololona
407	494856	ANDRIAMALALA Mendrika Mitantsoa
408	467927	RAKOTONIALY Aroniaina Donovan
409	462214	RABODOHASINA Heriniaina Tinasoa
410	457867	BEARISOA Harimalala Minah
411	473847	ROCHEDEREUX Guillaume Paul
412	456126	Société. SAFIDI SARLU
413	69852	M GEMS & MINERAUX SARL
414	8701	MAMODHOUSSEN Hamza
415	514737	RANDRIAMIARISOA Tsiorimampionina Fitahiana
416	488543	FIDIZARA Asmi / RAZAKAKELY Olivier
417	473959	RAFAMATANANTSOA Temitra Fiaro
418	49858	RASOLOSOA Hanitriniaina Elise
419	11659	RAVAOARISOA Marie Jocelyne
420	493397	Faniry Fanomezantsoa
421	7326	Cabinet Afine NY HAVANA
422	443490	RATOVONONY Jean
423	501928	SALVY Christophe /MALALANIAINA Salvy Rianà
424	484309	RAKOTOSEHENO Andry Nomenjanahary
425	494568	ANDRIAMIRADO Onjatiana
426	494933	RANDRIANAIVO Mamy
427	475177	RAHAINGOARIMANANA Faramboahirana Clara
428	22256	TRILOGY DISTRIBUTION
429	223893	RAVELONANOSY Née Catein Annie Chantal
430	474400	ANDRIANAIVOARISOA Davida / RAZAFITSIORY Bodomalala Louise
431	470773	RAOELINA Henintsoa / RAZAIARIMALALA Adeline
432	490522	RAZANADRAVAO Mirana Célestine
433	23908	RAVELOJAONA Françoise Lydia
434	514344	RAIALIMAMENO Corridon Lasnet Eticiana
435	511269	MANDIMBISOA REYMOND Stéphie Nirvana
436	21621	RATSIMBA Manitra Harisoa
437	6058	RAHAJASON Liva Annick
438	490909	RAKOTOARISOA Mamiarimbola Eric
439	7051	RANDIMBIVOLOLONA Johary
440	452912	RANDRIARISOA Volatiana
441	471895	BRUGNONI Giorgio Luca
442	495654	ASSOCIATION ACCES / RABEARIMANANA Noelintsoa Veroniaina
443	495225	NIONY FIONONANA
444	495640	RAZAFINDRAJARY Jean Louis
445	11297	RAFAMANTANANTSOA Lucie
446	496078	ANDRIAMASIMIADANA FANANTENANA Fabrice
447	488718	TSIHOARANTSALAMA Tsanta Henintsoa Tinaeli
448	494865	RAZAFINDRAVELO Solofoniaina
449	505783	RANAIVOMAHEFA Solomampionona
450	8952	ONG MANDA
451	50961	RANDRIANARISOA Paul
452	496959	FRANTCHESCA Maminirina Orlandine
453	471430	RAKOTOMANALINA Jerry Antonio
454	16716	RAVAOARIZAIMANANA Emilia Harivaovao
455	515444	RANDRIAMALALA Adrienne Mireille
456	470959	RANDRIANARISON Sarobidiniaina
457	480530	RAZANADRASOA Suzette
458	515657	FARALAHINANDRASANA Pierre William
459	515470	RAMILISON Andrianandraina Fetra
460	11858	RAONISOAMALALA Jeanette
461	41993	RAVONJIARIMALALA Hélène
462	511168	BARTHELEMY
463	31252	RAKOTOHERY Rado
464	455930	RAHARINJAKA Aina Tiana Stephan
465	14811	RAMAROLAHY Heriniaina Bruno
466	495332	RAKOTONDRAMANANA Andrianirina Alain Bruno
467	471301	RALAMBO Reine Liantsoa
468	495684	RANAIVOSON Tsifaratiana Harinjara
469	17082	CHAPELAIN Jean Charles
470	468529	ANDRIANJAFY KWAN SOON Yohann Govanni
471	515716	RAKOTO HARISOA Mialy Iarivony
472	513424	RANAVALONANDRASANA Mialisoa Odile/RASOAMBOLA Sissi Rosar Viottie
473	496653	RAZAZAROHAVANA Njaratsilavina Sitrakiniaina
474	407315	RANDRIANARIVELO Rija
475	497618	EUROCCASIONS - KAMORO HOTEL / RANDRIAMANAMIHANTASOA Nirilanto Haingoarivelo
476	478323	RAKOTOMAMONJY Jeanne Estella
477	42874	RASOLOFOJAONA Nivo / RAJAOHARISOA William
478	462325	RAKOTONDRAFARA Solofoniaina Fenosoa
479	496723	RAKOTONIAINA Alain André
480	155619	GOOLY Jaykrishan
481	42297	ANDRIAMIHARISOA RAKOTONDRATSIMA
482	29483	RANDRIANARIVELO Maminirina
483	472568	ANDRIAMAHEFA Hariliva Sandra
484	493568	RAKOTOMALALA Rivo Nirin
485	453819	PIERROT LOSLIE Mershab Kretcher
486	173790	BEMANAJA Etienne
487	17283	RALALARIVONY Ralitera Aline
488	481305	RASENDRAMAHAVALISOA RATSIMBA Toavina Tsihoarana
489	23485	RABAKO RALAMBONIRINA Jean Jacques
490	141011	MADASTONE COMPAGNIE
491	496579	RAOELINA Stéphane
492	34276	MIARIMBELO Andriamanjato
493	17287	SIPED
494	487953	LOVANAVALONA Malina
495	495577	RAKOTONONERANA Vonimahaliana Tsiriniaina
496	496631	RAKOTOARISON Mamitiana Christian
497	496045	ANDRIAMIARISOA Mbolahajaniaina Tahiry
498	450559	RABEARISOA Annick Hantanirina
499	486023	RAKOTOARISON Fitahiana Mahery/ ANDRIAMANANTSOA Vaosariaka Arisolo Elina
500	492335	RANDRIAMIHARIMANANTSOA Kantoniaina Rija Mayeul
501	41721	Société. ENTREPRISE INDIVIDUELLE AUREUS/MADSQUARE
502	496055	ARIRAVAKINIAINA Anja Mbolatiavina
503	482411	RANDRIAMARINTSAINA Rodolphe
504	500489	ANDRIANTSILAVINA Randimbison Riantsoa
505	452070	NJARANIRINA Fleurette
506	467561	ANDRIANANTOANINA Mamy Nirina
507	493853	RAZAKARIASA Nicolas Hery Lala
508	12912	RAJAONSON Andriamahenina Nirina Tsarazaka
509	467737	VENI CREATOR MADA
510	274050	AL RIDA
511	474921	RABENANTOANDRO Tantely Harinirin
512	506117	RAKOTOARIVONY Fifaliana Rosa
513	506385	ZAFINANDRASANA Infrid Nancy
514	24967	SOLOFOHARIVELO Mamy Lea
515	17400	Société. SPRING MADAGASCAR
516	492875	RASENDRAMALALAHASINA Sarah/ RASOLONJATOVO Tiavina Alain Tommy
517	49297	RANJALAHY Angelo
518	120	CMA CONSEIL
519	492201	RANOELISON ANDRIAMIHAJA Fanilo Ny Aina
520	495113	ANRIAMBOLA Vonisoa Nantenaina
521	493039	RABOANARY Onja Nantenaina Hanitriniala
522	446452	RANDRIAMIHAJA Zoé Mamy
523	173809	RANDRIAMALALA Jean Jacques
524	11247	ECOCERT Succursale Madagascar
525	71638	RAKOTOARIMANANA Eléo Patricia
526	489598	SOLOFONIRINA Anjamalala Noelinah
527	497209	RAKOTOMALALA Rindra Razah
528	496524	NOMENJANAHARY Mirantsoa Mialiniaina Prisca
529	474937	IOLONTSOA Larotia
530	469586	RATSIMANDRESY Tolotra Fanambinantsoa
531	499019	ANDRIATSIMIALONA Salohy Ny Aina
532	474608	RAKOTOVAO Marie Jocye
533	498544	RANDRIANITOVINA Nambinina Arsène
534	4751	EXPOLANKA Madagascar
535	474929	RAZAFIMIHAJA Sandy Andrianina
536	498143	ASSANALY Arnaud
537	495813	VOARINJATOVO Mihary Valisoa / RATEFIARISON Christian Fitia
538	496102	RAZAFIMANDIMBY Harilantosoa Lalanirina
539	12059	SOCIETE LILA ROUGH GEM STONES
540	456220	Andriamandy Colette Bakoly
541	498735	RAKOTOMANANTSOA Andrianjaka
542	485139	MIRADJI Velo Ali
543	498389	RATSIMISETA Andriamisaharimanana Siméon
544	472854	RANDRIANALISON TANTELY Betty Rosemarie
545	489295	FANAMPERANTSOA Solotiana Rivesty
546	498768	ANDRIAMANDIMBIARISOA Harilala Nadia
547	497145	FACULTE EGS ANKATSO
548	495212	RAZANADAHY Fenoherizo Manalinandrianina
549	68345	RATSIHOSENA RAMINAHY Nantenaina Joelle
550	497827	RAVALOARISOA Volana Nokasaina
551	8031	LALARIVELO Mbinina Olivier Rija
552	495192	MAHATOHITRARIVO Elihirizy Mizanjara
553	177708	RAHELIARILALAO Bienvenue
554	417139	ANDRIANARIJAONA Diavolana
555	496795	TAMONY Bruno
556	496725	RANDRIAMANANTENA Rivosoa Ihary
557	461149	RALAINIRINA Norohanitriniaina Miora Lydia
558	475405	RAOELISON Famantanantsoa Estela
559	497703	ZAFIMAHATRATRA Poulteau Albert
560	499656	Société. ATM Architectures et Travaux Madagascar
561	499781	RAZAFINJANAHARY Nirina Stefana
562	496941	RANDRIANARIVO Nirina Mirella/ RANDRIANARIVO Franck Lalaina
563	173099	Société. Boutique K-BLIND
564	495968	RAKOTOARISOA Fanomezantsoa Miradoniaina
565	9211	RAMBININTSAOTRA Vololotiana
566	9169	RAKOTOZAFY Anjaratiana Arivola /RAKOTOZAFY Solo
567	455857	RANDRINDRAHONANDO Mahefasoa Nicolas
568	495417	ANILAH Mioratiana Fiononana
569	10993	RANAIVO Roland
570	10087	RASMICANTE RAJ MITHALAL
571	308580	RANANJASON Julienne
572	39189	RAMAMONJISOA Solo Harilala
573	497549	RASOANIRINA Lalao Françoise
574	467945	RAKOTOSON Hanitra Andrianandrasana
575	46095	RAZAFINDRALAMBO Zo Andriniaina
576	469805	RAZAKARIJAONA Andrianina Loic
577	459243	MAHAZAKA Clérmont Gervais
578	363566	LANCELOT François Claude Joël
579	498300	RAKOTOMANGA Koloinando Mamiratra Malalatiana
580	492677	RAVELOJAONA Veronirina Fanja Harilalao
581	254632	RANDRIAMBELO Hasina Ranjamalala Romaine
582	85106	RAFIDISON Soloniaina Narindra
583	374336	MAHEFARISON Itokiana Ghislain
584	497296	ANDRIATINANIRINA Ando Romeo
585	474053	VALISOA Harilalaina
586	494665	ARIRAVAKINIAINA Anja Mbolatiavina/ TAHIRISOA Nandrandraina
587	444766	ANDRIAMANALINAAndritiana Princia
588	471091	ANDRIAMAMPIRODO Onitiana Valerie
589	468058	ANDRIAMASY Hery Harison
590	99991	RALAHINOMENJANAHARY Liantsoa Mankasitraka
591	451850	RAMANITRASAHOLY Landiniaina
592	497356	ANDRIANALINTSOA Mendrika Jaela
593	44344	RAVOSON Olisoa
594	461287	RAKOTOARIMANANA Mahandry Ny Aina Fihorenantsoa
595	9838	AMADEA
596	42627	RANDRIAMANANAZY Soloniaina Guy
597	468186	ANDRIANARIMANANA Tsiory Fanomezana
598	470938	RASOLOFONIAINA Koloina Christel/ ANDRIANTAHINJANAHARY TSIMANARSON Narindrandraibe Princy
599	495288	RAZAFIMAMONJY Rary/RAZAFIMAMONJY Manony
600	455258	RASOLOHARINILAINA Hasina Nokoloina Espérance
601	59055	WEI Xian
602	498602	RAMANAMPAMONJY Andry Mampionona Fifaliana/ ANDRIANAKANGA Minoharimenja Diana
603	489274	RANARISON Mialinirina Dolly
604	481466	RAMAMIARIMANANA Haja Tahina Clement
605	96616	LABO MEN SARL /RAZAFIMBOLA Ho wing Mine Lucette
606	515238	OPHONE TELECOM SARLU
607	456729	RABENAIVOARIVELO Andrianirina Juliot
608	46511	RALANTOMAHEFA
609	470836	ANDRIANANTENAINA Ando
610	501589	RANDRIANOELINA Andrianavony Jules
611	499810	RATODIARISOA Haingo Lalao
612	497984	RAVOLOLOMAMPIANINA Hanitrarivelo
613	6056	IFPA- Institut de Formation Professionne
614	498449	RALISON Nandrianina Gracia
615	498573	RANDRIAMAMPIONONA Uluc
616	39900	RANDRIANARISOLOFO Tsirinaina Henintsoa
617	7532	RAHELIMANANTSOA Rondro Lucette
618	274011	RAZANAMAHERY Clémentine
619	516691	BRUNEL Ryan Weshley
620	499119	N° 499119 - M. ROJOTIANA Santatra
621	23653	KOLINA Yvonne Heritiana
622	486875	TOVARA Angelo Emilien
623	514354	RAMONJAMANANA Rivo Andrianaivo Nirina
624	8099	RANDRIAMANALINA Nirinah Gérard
625	467817	RAZANAJATOVO Rina Sedera/ RAMILISON Eddy Aina
626	7685	ANDRIANAIVO Alain Paul
627	448463	RANDRIAMANANA Mino Ranto
628	467457	RAKOTOMANANA Jean Claude
629	470863	ANDRIAMITONDRA Maeva Tiana Jessica
630	480598	RAMBOA Harinirina Ravelo
631	360939	ANDRIANTSIMBA Jaona Mbinintsoa
632	471147	ODILE Germaine
633	468289	RANARIVOLOLONA Felantsoa
634	13315	RAVOLANORO Rosa
635	443270	RABEARINOSY Kanty Razafitseheno
636	488462	RANDRIAMIHAJA Fanomezantsoa Alain
637	499079	RATIAHAVANA Dimbisoa Landry
638	456639	RATOVONIRINA Inna Toky
639	497388	BRUSCAGNIN Tiana Miranda
640	475664	RASOANIAINA Riana Lydie / RANDRIANJATOVO Lova Henintsoa
\.


--
-- Data for Name: core_demande; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_demande (id, fid_id, id_fid, date_reception, site, agent_fidelisation, refnum, nom_client, technologie, ref_produit, ancien_produit, ancien_mensualite_ttc, date_contrat, requete_client, motif, information_libre, action, niveau_decision, date_cloture, agent_confirmation, date_prevue_execution, priorite, ref_nouv_produit, nouveau_produit, nouveau_mensualite_ttc, nouveau_nom, date_nv_contrat, audit, created_at, updated_at) FROM stdin;
1	FID-2025-00002	2	2025-07-30	Masay	Fitiavana	145238	ANDRIANARIVELO Daniel Thierry	4G	566595	4G_Gold	0	2018-07-09	Résiliation	Autres	annulation + basculement	Basculement	En Attente	2026-05-07					4G_1T	99000		2026-07-31	[]	2026-06-19 11:05:24.154792+00	2026-06-19 11:05:24.154812+00
2	FID-2025-00003	3	2025-09-04	Antanimena	Jessica	25312	RAZAFIMALALA Verosahondra	Airfiber	897877	Airfiber_Unlimited 20	189000	2023-01-04	Résiliation	Problème financier	Problème financier	Downgrade	Cloturé	2026-01-29		2026-01-31		965413	Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.154845+00	2026-06-19 11:05:24.15485+00
3	FID-2025-00004	4	2025-09-10	Antanimena	Nathalie	19507	RAZAFINIMARO Jean William	4G	929517	4G_512 Ko	169000	2021-02-03	Résiliation	Autres	Retraité	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.154881+00	2026-06-19 11:05:24.154885+00
4	FID-2025-00005	5	2025-10-04	Antanimena	Nathalie	238720	RANDRIANARIVONY Harizo Lantoniaina Rézah	4G	636588	4G_Gold	189000	2019-01-14	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.154919+00	2026-06-19 11:05:24.154924+00
5	FID-2025-00006	6	2025-10-08	Masay	Jessica	143527	RAKOTOHERINIAINA SEHENOARINJAKAMALALA TAHIRY	4G	528591	4G_512 Ko	169000	2018-01-25	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.154952+00	2026-06-19 11:05:24.154955+00
6	FID-2025-00007	7	2025-10-09	Antanimena	Nathalie	306471	RAZAKARIVONY Andrianambinina Andriamarolahy	4G	898261	4G_Gold	189000	2023-01-25	Résiliation	Autres	Bande 20	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.154982+00	2026-06-19 11:05:24.154985+00
7	FID-2025-00008	8	2025-10-11	Antanimena	Nathalie	9117	RAKOTOMALALA Ange Nirina	4G	905949	4G_BOX postpayé 65Go	119000	2024-01-31	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155013+00	2026-06-19 11:05:24.155016+00
8	FID-2025-00009	9	2025-10-13	Masay	Jessica	70395	RAZANAMPARANY Malalasoa Marcelle	4G	805115	4G_Gold	189000	2020-01-13	Résiliation	Changement de projet	Changement de projet	Downgrade	Cloturé	2026-01-31		2026-01-31		965280	Airfiber_Unlimited 50	149000			[]	2026-06-19 11:05:24.155042+00	2026-06-19 11:05:24.155046+00
9	FID-2025-00010	10	2025-10-14	Antanimena	Nathalie	5620	RABARY Jean Germain	4G	884179	4G_Gold	169000	2014-01-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155072+00	2026-06-19 11:05:24.155075+00
10	FID-2025-00011	11	2025-10-14	Antanimena	Jessica	199931	RAJERISON Patricia Wilmine	4G	812834	4G_Gold	189000	2020-01-27	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.15511+00	2026-06-19 11:05:24.155113+00
11	FID-2025-00012	12	2025-10-14	Antanimena	Nathalie	468777	RANAIVOARISON Fenitra Harilova	Airfiber	905786	Airfiber_First	99000	2024-01-20	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155175+00	2026-06-19 11:05:24.155214+00
12	FID-2025-00013	13	2025-10-16	Antanimena	Anja	11800	RATOVONDRAHETY Elisabeth Bodo Farasoa	4G	905967	4G_50Go	99000	2024-01-30	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				49000			[]	2026-06-19 11:05:24.155246+00	2026-06-19 11:05:24.15525+00
13	FID-2025-00014	14	2025-10-20	Antanimena	Fitiavana	28880	RANDRIANAIVOARISON Claudia	4G	568815	4G_Gold	189000	2023-01-05	Résiliation	Insatisfaction	Insatisfaction	Downgrade	Cloturé	2026-01-30		2026-01-30		965203	4G_200Go	49000			[]	2026-06-19 11:05:24.155277+00	2026-06-19 11:05:24.155281+00
14	FID-2025-00015	15	2025-10-20	Antanimena	Nathalie	399682	RAZANAKOTONIRINA Mamy José	Airfiber	883831	Airfiber_Plus	189000	2022-01-04	Résiliation	Mobilité géographique	Déplacement fréquent	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155354+00	2026-06-19 11:05:24.15536+00
15	FID-2025-00016	16	2025-10-21	Antanimena	Nathalie	483936	MOHSIM ALI	4G	928044	4G_200Go	49000	2025-01-08	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.15539+00	2026-06-19 11:05:24.155393+00
16	FID-2025-00017	17	2025-10-22	Masay	Jessica	24079	RAMANANTSOA Sylvie Lalatiana	4G	270323	4G_512 Ko	169000	2016-02-01	Résiliation	Autres	Non utilisation	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155421+00	2026-06-19 11:05:24.155424+00
17	FID-2025-00018	18	2025-10-22	Antanimena	Jessica	241073	RATELOSON Andriamandrato Manitra Tojoniaina	4G	639162	4G_Gold	189000	2019-01-21	Résiliation	Autres	Changement d'opérateur	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.15545+00	2026-06-19 11:05:24.155453+00
18	FID-2025-00019	19	2025-10-23	Antanimena	Tino	467088	RAZANAJOARY Veloarimanana Sahondra	4G	898474	4G_Gold	189000	2023-02-03	Résiliation	Problème financier	Problème financier	Downgrade	Cloturé	2026-02-02		2026-01-31		965497	4G_200Go	49000			[]	2026-06-19 11:05:24.15548+00	2026-06-19 11:05:24.155483+00
19	FID-2025-00020	20	2025-10-27	Masay	Anja	290655	BOURHIS Jean Raymond	4G	941751	4G_500Go	99000	2025-05-28	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.155509+00	2026-06-19 11:05:24.155512+00
20	FID-2025-00021	21	2025-10-27	Antanimena	Nathalie	470074	RANDRIANARIMANANA Rija Désiré	Airfiber	929637	Airfiber_First	149000	2025-01-31	Résiliation	Changement de projet	Changement de projet	Downgrade	Cloturé	2026-01-31				965385	Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.155538+00	2026-06-19 11:05:24.155541+00
21	FID-2025-00022	22	2025-10-28	Masay	Jessica	8382	PROSPERITY EARTH SARL	4G	242611	4G_Gold	189000	2015-01-07	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155566+00	2026-06-19 11:05:24.155569+00
22	FID-2025-00023	23	2025-10-28	Antanimena	Nathalie	28700	BERNARD	4G	886545	4G_512 Ko	169000	2014-02-05	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155594+00	2026-06-19 11:05:24.155597+00
23	FID-2025-00024	24	2025-10-28	Antanimena	Anja	483978	RAZAFIMAHATRATRA Maholinirina	4G	928103	4G_200Go	49000	2025-01-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155623+00	2026-06-19 11:05:24.155626+00
24	FID-2025-00025	25	2025-10-29	Antanimena	Anja	146186	RASOAVATSARA VEROHANTA	4G	531851	4G_512 Ko	169000	2018-02-03	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155651+00	2026-06-19 11:05:24.155654+00
25	FID-2025-00026	26	2025-10-30	Antanimena	Jessica	68285	RAFALISOLOHERINIRINA Hervé	4G	412858	4G_Gold	189000	2017-02-21	Résiliation	Autres	Non utilisation	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.155679+00	2026-06-19 11:05:24.155682+00
26	FID-2025-00027	27	2025-10-31	Antanimena	Anja	24262	Association Chrétienne ANDAO HITIA/ RASOANARIVO Andrianirina Christian	3G	246709	3G_500	17500	2015-02-03	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155708+00	2026-06-19 11:05:24.15571+00
27	FID-2025-00028	28	2025-10-31	Antanimena	Jessica	60297	ANDRIANIAINA Armand	4G	905426	4G_200Go	99000	2024-01-03	Résiliation	Autres	Retraité	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155736+00	2026-06-19 11:05:24.155738+00
28	FID-2025-00029	29	2025-10-31	Antanimena	Nathalie	470386	ANDRIAMAHEFARIVO Juano José Mario	Airfiber	927545	Airfiber_First	99000	2024-02-19	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.155764+00	2026-06-19 11:05:24.155767+00
29	FID-2025-00030	30	2025-11-03	Masay	Fitiavana	236521	RAMAMONJISOA Anjaramamy Hasinkarefo	4G	868080	4G_Gold	189000	2017-01-31	Résiliation	Autres	Non utilisation	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155828+00	2026-06-19 11:05:24.155834+00
30	FID-2025-00031	31	2025-11-03	Masay	Anja	483641	ANDRIANIRINA Henintsoa Mirana	Airfiber	927644	Airfiber_First	99000	2025-01-02	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155864+00	2026-06-19 11:05:24.155867+00
31	FID-2025-00032	32	2025-11-04	Antanimena	Nathalie	68326	RAJAONARY MAMINJATOVO HENRI	4G	413345	4G_512 Ko	169000	2017-02-23	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.155893+00	2026-06-19 11:05:24.155896+00
32	FID-2025-00033	33	2025-11-04	Antanimena	Jessica	483895	RAHARINANDRASANA Fenohasintsoa Allain	4G	927988	4G_200Go	49000	2025-01-07	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155922+00	2026-06-19 11:05:24.155925+00
33	FID-2025-00034	34	2025-11-04	Antanimena	Nathalie	483930	ANDRIANIRIANAZAKA Jocellin	4G	928036	4G_200Go	49000	2025-01-08	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155952+00	2026-06-19 11:05:24.155955+00
34	FID-2025-00035	35	2025-11-05	Antanimena	Fitiavana	40054	RATSIFANDRIHAMANANA Raivo Tiana	4G	242518	4G_512 Ko	169000	2015-01-06	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.155981+00	2026-06-19 11:05:24.155984+00
35	FID-2025-00036	36	2025-11-05	Antanimena	Nathalie	485765	ANDRIANOELY Narisoa Justin	Airfiber	930491	Airfiber_First	99000	2025-02-08	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15601+00	2026-06-19 11:05:24.156013+00
36	FID-2025-00037	37	2025-11-06	Antanimena	Jessica	395010	RAZAFIMBOLAFIDY Harilala	4G	906975	4G_BOX postpayé 65Go	93000	2020-01-03	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156039+00	2026-06-19 11:05:24.156042+00
37	FID-2025-00038	38	2025-11-06	Antanimena	Nathalie	483213	RAKOTONDRAHOVA Anditiana Embona /RATREMA FINARITRA Mendrika Fitiavana	Airfiber	926997	Airfiber_First	99000	2024-12-26	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156068+00	2026-06-19 11:05:24.156071+00
38	FID-2025-00039	39	2025-11-07	Antanimena	Jessica	48483	RANDRIAMARO-MANANTENA Malala	4G	268662	4G_512 Ko	169000	2016-01-08	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156102+00	2026-06-19 11:05:24.156105+00
39	FID-2025-00040	40	2025-11-07	Antanimena	Nathalie	307532	RAHANTAMALALA Esperance Colombe	4G	928527	4G_500Go	0	2025-01-15	Résiliation	Insatisfaction	Insatisfaction	Annulation	Cloturé			2026-01-31			4G_500Go	49000			[]	2026-06-19 11:05:24.156156+00	2026-06-19 11:05:24.156161+00
40	FID-2025-00041	41	2025-11-07	Antanimena	Nathalie	483882	RADIMIARISOA Miora Olga	Airfiber	927971	Airfiber_Ultra	149000	2015-01-07	Résiliation	Raison personnelle	Pesonnelle	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156189+00	2026-06-19 11:05:24.156192+00
41	FID-2025-00042	42	2025-11-10	Antanimena	Anja	484031	RAKOTOARIJAONA Naja Niaina Nanah	4G	928172	4G_200Go	49000	2025-01-10	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156218+00	2026-06-19 11:05:24.156221+00
42	FID-2025-00043	43	2025-11-11	Antanimena	Nathalie	67505	ANDRINIAINA Nantenaina / HARILALA Sylvie Bienvenue Samueline	4G	932799	4G_200Go	49000	2025-02-28	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156248+00	2026-06-19 11:05:24.156251+00
43	FID-2025-00044	44	2025-11-11	Masay	Anja	470202	HASIMBOLA Ny Antsa	Airfiber	905855	Airfiber_First	99000	2024-01-25	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156277+00	2026-06-19 11:05:24.15628+00
44	FID-2025-00045	45	2025-11-13	Antanimena	Anja	39517	RAZAFINDRABE Zafinirina Andrianarijaona	4G	241998	4G_512 Ko	169000	2015-01-03	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156306+00	2026-06-19 11:05:24.156309+00
45	FID-2025-00046	46	2025-11-13	Masay	Nathalie	470145	RAOBISOA RAELY Harimalala/ ASSOCIATION FUSION FIOMBONANANA MIFANASOA	4G	905735	4G_50Go	99000	2024-01-18	Résiliation	Changement de projet	Fin du projet	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156335+00	2026-06-19 11:05:24.156338+00
46	FID-2025-00047	47	2025-11-14	Antanimena	Fitiavana	22293	COLLEGE P'TIT MICHOU	4G	882237	4G_Gold	189000	2024-02-07	Résiliation	Autres	Arret TV	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156364+00	2026-06-19 11:05:24.156367+00
47	FID-2025-00048	48	2025-11-14	Antanimena	Nathalie	22927	RASOAZANANORO Mirana Lalaina	4G	882222	4G_512 Ko	169000	2013-02-26	Résiliation	Double emploi	Double emploi	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156393+00	2026-06-19 11:05:24.156396+00
48	FID-2025-00049	49	2025-11-14	Masay	Jessica	28528	RAKOTOMANGA Anna Nivovololona	4G	874699	4G_512 Ko	169000	2014-01-28	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156422+00	2026-06-19 11:05:24.156425+00
49	FID-2025-00050	50	2025-11-17	Antanimena	Nathalie	18179	ANDRIAMITANTSOA Samoela Ny Onja Christian	Airfiber	934710	Airfiber_First	149000	2025-02-24	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15645+00	2026-06-19 11:05:24.156453+00
50	FID-2025-00051	51	2025-11-17	Antanimena	Nathalie	473137	ADAN Bryan	4G	928459	4G_200Go	49000	2025-01-15	Résiliation	Changement de projet	Changement de projet	Aucun changement	Cloturé	2025-01-24				928459	4G_200Go	49000			[]	2026-06-19 11:05:24.156479+00	2026-06-19 11:05:24.156481+00
51	FID-2025-00052	52	2025-11-20	Antanimena	Anja	470328	RAZAFIMAMY Vonindrahona Finaritra	Airfiber	914625	Airfiber_First	99000	2024-02-10	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156507+00	2026-06-19 11:05:24.15651+00
52	FID-2025-00053	53	2025-11-21	Antanimena	Anja	484614	OLIVOLOLONA Sylvie Fidèle	Airfiber	928954	Airfiber_First	149000	2025-01-21	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156535+00	2026-06-19 11:05:24.156538+00
53	FID-2025-00054	54	2025-11-21	Antanimena	Fitiavana	486767	JUVENILLA Erasmie	4G	931912	4G_200Go	49000	2025-02-18	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156564+00	2026-06-19 11:05:24.156567+00
54	FID-2025-00055	55	2025-11-24	Antanimena	Nathalie	14500	RAJAONARISON José Serge	4G	822834	4G_512 Ko	169000	2020-02-19	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156592+00	2026-06-19 11:05:24.156595+00
55	FID-2025-00056	56	2025-11-24	Antanimena	Nathalie	152923	COUSIN Thierry	Airfiber	925428	Airfiber_Plus	189000	2018-02-28	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15662+00	2026-06-19 11:05:24.156623+00
56	FID-2025-00057	57	2025-11-24	Masay	Jessica	344879	RAVOTIANA Avotriniaina Angelo	Airfiber	907752	Airfiber_Plus	0	2024-04-03	Résiliation	Insatisfaction	Annulation+basculement	Annulation	Cloturé	2026-04-28				971091	Airfiber_Unlimited 50	99000		2026-04-28	[]	2026-06-19 11:05:24.156648+00	2026-06-19 11:05:24.156651+00
57	FID-2025-00058	58	2025-11-24	Antanimena	Nathalie	485483	RAJAONERA Mirana Lolontiana /RAFANJAMBOLOLONIAINA Bakomalala	4G	930028	4G_200Go	49000	2025-02-05	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156676+00	2026-06-19 11:05:24.156679+00
58	FID-2025-00059	59	2025-11-26	Antanimena	Nathalie	13201	MAKAMASY Tsitavane Velomanarina	4G	929687	4G_200Go	99000	2025-01-31	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156705+00	2026-06-19 11:05:24.156708+00
59	FID-2025-00060	60	2025-11-28	Masay	Jessica	27683	RAFITOSON Redonné	4G	883367	4G_Gold	189000	2021-12-21	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156733+00	2026-06-19 11:05:24.156736+00
60	FID-2025-00061	61	2025-11-28	Antanimena	Anja	407524	RAKOTOMALALA Domoina Rollande	4G	929881	4G_500Go	189000	2025-02-04	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156761+00	2026-06-19 11:05:24.156764+00
61	FID-2025-00062	62	2025-11-28	Antanimena	Nathalie	470652	RAKOTOMAHANINA Flore Gilberte	Airfiber	907189	Airfiber_First	0	2024-03-18	Résiliation	Autres	Départ	Annulation	Cloturé	2026-03-04	Nathalie			967593	Airfiber_Unlimited 50	99000		2026-03-04	[]	2026-06-19 11:05:24.15679+00	2026-06-19 11:05:24.156793+00
62	FID-2025-00063	63	2025-11-28	Antanimena	Nathalie	480854	MA WEIJUN	Airfiber	923798	Airfiber_First	149000	2024-11-23	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156818+00	2026-06-19 11:05:24.156821+00
63	FID-2025-00064	64	2025-11-29	Antanimena	Nathalie	13318	RAKOTOMANANA Harinaina Aivonirina	4G	641876	4G_Gold	189000	2019-01-24	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156846+00	2026-06-19 11:05:24.156849+00
64	FID-2025-00065	65	2025-12-01	Antanimena	Nathalie	14919	RAZAFINDRAKOTO MAMONJISOA Roger André	4G	246530	4G_Gold	189000	2015-01-30	Résiliation	Raison personnelle	Décès utilisateur	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.156875+00	2026-06-19 11:05:24.156878+00
65	FID-2025-00066	66	2025-12-01	Antanimena	Anja	470455	RAKOTONDRAHAJA Vololomahefa	Airfiber	906481	Airfiber_First	99000	2024-02-28	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.156903+00	2026-06-19 11:05:24.156906+00
66	FID-2025-00067	67	2025-12-01	Antanimena	Nathalie	470702	DANG ép POMMERA Thi-My-Châu	Airfiber	907348	Airfiber_First	149000	2024-03-22	Résiliation	Changement de projet	Changement de projet	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.156932+00	2026-06-19 11:05:24.156935+00
67	FID-2025-00068	68	2025-12-02	Antanimena	Jessica	22586	RAHAROMISA Hajasoa	4G	874140	4G_512 Ko	169000	2013-02-05	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15696+00	2026-06-19 11:05:24.156963+00
68	FID-2025-00069	69	2025-12-02	Antanimena	Jessica	400136	RANDRIAMAMPIONONA Hobilalaina	Airfiber	933500	Airfiber_First	99000	2025-03-06	Résiliation	Problème financier	Problème financier	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.156988+00	2026-06-19 11:05:24.156991+00
69	FID-2025-00070	70	2025-12-03	Antanimena	Nathalie	9823	GIROD Virginie	4G	415925	4G_Gold	189000	2017-03-15	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.157016+00	2026-06-19 11:05:24.157019+00
70	FID-2025-00071	71	2025-12-03	Antanimena	Nathalie	68368	RANDRIANARIVELO Erica Nandrianina	4G	809342	4G_Gold	189000	2020-01-21	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157044+00	2026-06-19 11:05:24.157047+00
71	FID-2025-00072	72	2025-12-03	Antanimena	Jessica	485796	RAZAFIMATRADRAIBE Aimé Marcel	4G	930483	4G_200Go	49000	2025-02-08	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157072+00	2026-06-19 11:05:24.157075+00
72	FID-2025-00073	73	2025-12-03	Antanimena	Jessica	485796	RAZAFIMATRADRAIBE Aimé Marcel	4G	930482	4G_200Go	49000	2025-02-08	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157106+00	2026-06-19 11:05:24.157109+00
73	FID-2025-00074	74	2025-12-03	Antanimena	Nathalie	487187	RABEONY Onjaniaina Jacquie	Airfiber	932311	Airfiber_First	99000	2025-02-22	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157159+00	2026-06-19 11:05:24.157165+00
74	FID-2025-00075	75	2025-12-03	Antanimena	Nathalie	487434	RAMIANDRISOA Evatiana	4G	932648	4G_200Go	49000	2025-02-26	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				99000			[]	2026-06-19 11:05:24.157193+00	2026-06-19 11:05:24.157196+00
75	FID-2025-00076	76	2025-12-03	Antanimena	Nathalie	68368	RANDRIANARIVELO Erica Nandrianina	4G	614607	4G_512 Ko	169000	2017-02-27	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157222+00	2026-06-19 11:05:24.157226+00
76	FID-2025-00077	77	2025-12-04	Antanimena	Fitiavana	5828	Société. AXELLE SARL	4G	271565	4G_Gold	189000	2016-02-19	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157252+00	2026-06-19 11:05:24.157255+00
77	FID-2025-00078	78	2025-12-04	Antanimena	Anja	56845	RASAMIRAVAKA Tsiry	4G	906561	4G_85Go	125000	2020-02-21	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157281+00	2026-06-19 11:05:24.157284+00
78	FID-2025-00079	79	2025-12-04	Antanimena	Jessica	449947	RAFALIRIVONISON Olivier Gerard	4G	932811	4G_200Go	99000	2025-02-28	Résiliation	Autres	Retraité	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157312+00	2026-06-19 11:05:24.157315+00
79	FID-2025-00080	80	2025-12-04	Antanimena	Jessica	453597	ANDRIANIRINA Mamitiana	4G	871553	4G_Gold	189000	2021-02-23	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157341+00	2026-06-19 11:05:24.157343+00
80	FID-2025-00081	81	2025-12-04	Antanimena	Jessica	475552	ANDRIHARINANDRASANA Anouchka Dominichinie	4G	915334	4G_200Go	99000	2024-07-16	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157369+00	2026-06-19 11:05:24.157372+00
81	FID-2025-00082	82	2025-12-04	Antanimena	Nathalie	487400	ANDRIANIRINA Nomenjanahary Ezoeson	4G	932602	4G_200Go	49000	2025-02-26	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157397+00	2026-06-19 11:05:24.1574+00
82	FID-2025-00083	83	2025-12-05	Antanimena	Fitiavana	49750	RAZAKAMALALATIANA Pierrot	4G	353269	4G_512 Ko	169000	2016-03-17	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.157426+00	2026-06-19 11:05:24.157428+00
83	FID-2025-00084	84	2025-12-08	Antanimena	Nathalie	10636	RANDRIANATOANDRO Tahiana	Airfiber	906376	Airfiber_Plus	189000	2024-02-24	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157453+00	2026-06-19 11:05:24.157456+00
84	FID-2025-00085	85	2025-12-08	Antanimena	Jessica	379924	RASOLOARIMALALA Miora Henintsoa	4G	932642	4G_200Go	49000	2025-02-26	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157482+00	2026-06-19 11:05:24.157485+00
85	FID-2025-00086	86	2025-12-08	Antanimena	Fitiavana	478467	RAMILISON Onja	Airfiber	932375	Airfiber_First	149000	2025-02-24	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15751+00	2026-06-19 11:05:24.157513+00
86	FID-2025-00087	87	2025-12-09	Antanimena	Jessica	11522	ANDRIAMIALISOA Rivoandriantsalama J	4G	272590	4G_Gold	189000	2022-02-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157539+00	2026-06-19 11:05:24.157542+00
87	FID-2025-00088	88	2025-12-09	Antanimena	Nathalie	12027	RAMAROSAONA Faraniaina Emilia	4G	645418	4G_512 Ko	169000	2019-02-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157568+00	2026-06-19 11:05:24.157571+00
88	FID-2025-00089	89	2025-12-09	Antanimena	Fitiavana	415176	RABEMIAFARA Claudino	4G	823265	4G_Gold	189000	2020-02-20	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157598+00	2026-06-19 11:05:24.1576+00
89	FID-2025-00090	90	2025-12-09	Antanimena	Nathalie	453866	RAJAONARISON Jean Yves Harison	4G	935209	4G_200Go	49000	2025-03-27	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.15773+00	2026-06-19 11:05:24.157735+00
90	FID-2025-00091	91	2025-12-09	Antanimena	Nathalie	487188	MAMINIAINA Josoa	4G	932317	4G_200Go	49000	2025-02-22	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157764+00	2026-06-19 11:05:24.157767+00
91	FID-2025-00092	92	2025-12-10	Antanimena	Anja	487516	RAMAROSON Tolotraharimanga Jerindriantoky	Airfiber	932754	Airfiber_First	99000	2025-02-27	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157793+00	2026-06-19 11:05:24.157796+00
92	FID-2025-00093	93	2025-12-10	Masay	Sabine	492434	PUNCHAMGOSS Shanawaz/ANDRIAMIALISOA Laurencia	4G	940968	4G_200Go	49000	2025-05-22	Résiliation	Autres	Non utilisation	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.157822+00	2026-06-19 11:05:24.157825+00
93	FID-2025-00094	94	2025-12-11	Antanimena	Nathalie	486211	RAMIALIHARISOA Harimahefa Santatriniaina	4G	931014	4G_500Go	99000	2025-02-14	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157851+00	2026-06-19 11:05:24.157854+00
94	FID-2025-00095	95	2025-12-11	Antanimena	Nathalie	487588	RAKOTONIAINA Njaratiana	4G	932855	4G_200Go	49000	2025-02-28	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.15788+00	2026-06-19 11:05:24.157883+00
95	FID-2025-00096	96	2025-12-12	Antanimena	Anja	452995	RAJO Heriniaina	4G	871677	4G_Gold	189000	2021-02-26	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157909+00	2026-06-19 11:05:24.157912+00
96	FID-2025-00097	97	2025-12-12	Antanimena	Nathalie	485948	RANAIVOARISON Koloina Ambinintso	Airfiber	930691	Airfiber_First	99000	2025-02-11	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-02-28				99000			[]	2026-06-19 11:05:24.157937+00	2026-06-19 11:05:24.15794+00
97	FID-2025-00098	98	2025-12-13	Antanimena	Nathalie	469237	LANCIA HARRYS Liéckelle	Airfiber	906540	Airfiber_First	99000	2025-02-28	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.157966+00	2026-06-19 11:05:24.157969+00
98	FID-2025-00099	99	2025-12-15	Antanimena	Anja	14457	RAKOTOMANGA Radonirina Zafinjatovo	Airfiber	929028	Airfiber_First	189000	2025-01-23	Résiliation	Mobilité géographique	Affectation	Résiliation	Cloturé	2025-12-15		2026-02-28				0			[]	2026-06-19 11:05:24.157994+00	2026-06-19 11:05:24.157997+00
99	FID-2025-00100	100	2025-12-15	Antanimena	Nathalie	486225	ZAFIMANANA Rojoniaina Tantely Martial	Airfiber	931046	Airfiber_First	0	2025-02-14	Résiliation	Changement de projet	Changement de projet	Annulation	Cloturé	2026-02-13				965911	Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.158027+00	2026-06-19 11:05:24.15803+00
100	FID-2025-00101	101	2025-12-16	Antanimena	Anja	15870	RAMAROJAONA Fenitra Stella /RANIRIARIMANANA Lantoarisoa	4G	886481	4G_512 Ko	169000	2012-03-30	Résiliation	Raison personnelle	Décès titulaire	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.158055+00	2026-06-19 11:05:24.158058+00
101	FID-2025-00102	102	2025-12-16	Antanimena	Nathalie	50103	RAKOTONDRAINIBE Andrianombonana Haja Tiana	Airfiber	907721	Airfiber_Plus	189000	2024-04-02	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.158085+00	2026-06-19 11:05:24.158087+00
102	FID-2025-00103	103	2025-12-16	Antanimena	Jessica	468376	RANDRIAMANALINA Haingonirina	4G	902047	4G_10Go	30000	2023-08-08	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158149+00	2026-06-19 11:05:24.158154+00
103	FID-2025-00104	104	2025-12-16	Antanimena	Jessica	470306	ANDRIAMANANIAINA Niry Hantasoa Lutecia	Airfiber	906104	Airfiber_Ultra	249000	2024-02-08	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158186+00	2026-06-19 11:05:24.158189+00
104	FID-2025-00105	105	2025-12-17	Antanimena	Fitiavana	467455	Société. MADAGASCAR ASIA PLASTICS SARL	Airfiber	938520	Airfiber_Unlimited 30	189000	2025-04-29	Résiliation	Changement de projet	Cessation d'activité	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158216+00	2026-06-19 11:05:24.158219+00
105	FID-2025-00106	106	2025-12-17	Antanimena	Anja	484041	RADIMIHARINOSY Hariseheno Hajanirina	Airfiber	928188	Airfiber_First	99000	2025-01-10	Résiliation	Raison personnelle	Éboulement de sa maison	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.158246+00	2026-06-19 11:05:24.158249+00
106	FID-2025-00107	107	2025-12-18	Antanimena	Nathalie	37700	RAMAROKOTO Liana Lantoantenaina	Airfiber	916981	Airfiber_Plus	189000	2020-02-27	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158274+00	2026-06-19 11:05:24.158277+00
107	FID-2025-00108	108	2025-12-19	Antanimena	Nathalie	470360	ANDRIAMBOLOLONA Noroniaina Mayah	Airfiber	906242	Airfiber_First	99000	2024-02-16	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158303+00	2026-06-19 11:05:24.158306+00
108	FID-2025-00109	109	2025-12-22	Masay	Sabine	8608	RAZAFINDRALANDY Voahirana	4G	839285	4G_512 Ko	169000	2012-02-09	Résiliation	Double emploi	Double emploi	Résiliation	Cloturé	2026-12-22		2026-02-28				0			[]	2026-06-19 11:05:24.158331+00	2026-06-19 11:05:24.158334+00
109	FID-2025-00110	110	2025-12-22	Antanimena	Anja	27041	RAMILISON Fanja Tiana Michèle	Airfiber	932706	Airfiber_Ultra	0	2025-02-27	Résiliation	Problème financier	Problème financier	Annulation	Cloturé	2026-02-27	Anja			932706	Airfiber_Unlimited 50	149000		2026-02-27	[]	2026-06-19 11:05:24.158359+00	2026-06-19 11:05:24.158362+00
110	FID-2025-00111	111	2025-12-22	Antanimena	Nathalie	487231	RAKOTONDRABE Cathy Hanitra Harivelo	4G	932531	4G_200Go	49000	2025-02-25	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.158389+00	2026-06-19 11:05:24.158391+00
111	FID-2025-00112	112	2025-12-22	Antanimena	Anja	487359	RAKOTONJANAHARY Mamitiana	4G	932542	4G_200Go	49000	2025-02-25	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2025-12-22		2026-02-28				0			[]	2026-06-19 11:05:24.158417+00	2026-06-19 11:05:24.15842+00
112	FID-2025-00113	113	2025-12-26	Antanimena	Jessica	9293	RESAMPA Antoni Ludovick	4G	511043	4G_512 Ko	169000	2012-08-13	Résiliation	Mobilité géographique	Départ	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.158445+00	2026-06-19 11:05:24.158448+00
113	FID-2025-00114	114	2025-12-26	Antanimena	Nathalie	28069	ANDRIANANTENAINAVALONA Jean Claude	4G	935771	4G_200Go	99000	2025-04-01	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé	2025-12-26		2026-03-31				0			[]	2026-06-19 11:05:24.158473+00	2026-06-19 11:05:24.158476+00
114	FID-2025-00115	115	2025-12-26	Antanimena	Jessica	487515	NARISOA Tsiory Erica	4G	932755	4G_200Go	0	2025-02-27	Résiliation	Insatisfaction	Insatisfaction	Annulation	Cloturé	2026-02-16	Anja			932755	4G_200Go	0		2025-02-28	[]	2026-06-19 11:05:24.158501+00	2026-06-19 11:05:24.158504+00
115	FID-2025-00116	116	2025-12-29	Antanimena	Nathalie	35784	RAZAFIARINELINA Marie Thérèse	Airfiber	898104	Airfiber_Plus	189000	2023-01-16	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.158529+00	2026-06-19 11:05:24.158532+00
116	FID-2025-00117	117	2025-12-29	Antanimena	Anja	49433	ANDRIAMAMPIANINA Mirana Tifania	4G	271837	4G_512 Ko	169000	2016-02-26	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2025-12-29		2026-02-28				0			[]	2026-06-19 11:05:24.158558+00	2026-06-19 11:05:24.158561+00
117	FID-2025-00118	118	2025-12-29	Antanimena	Nathalie	70275	RATIARISOLO Noro Fy	Airfiber	915048	Airfiber_Plus	0	2017-04-29	Résiliation	Changement de projet	Changement de projet	Basculement	Cloturé	2026-04-28	Anja			971140	Airfiber_Unlimited 50	99000		2026-04-29	[]	2026-06-19 11:05:24.158587+00	2026-06-19 11:05:24.15859+00
118	FID-2025-00119	119	2025-12-29	Antanimena	Anja	152625	RAVALINIAINA Jean Desire	4G	539040	4G_512 Ko	169000	2018-02-27	Résiliation	Problème financier	Problème banque	Résiliation	Cloturé	2025-12-29		2026-02-28				0			[]	2026-06-19 11:05:24.158615+00	2026-06-19 11:05:24.158618+00
119	FID-2025-00120	120	2025-12-30	Antanimena	Anja	459720	APEM (Association pour la Promotion de l'Entreprise à Mada)	4G	886046	4G_Gold	189000	2022-03-07	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2025-12-30		2026-03-31				0			[]	2026-06-19 11:05:24.158643+00	2026-06-19 11:05:24.158646+00
120	FID-2025-00121	121	2025-12-31	Antanimena	Nathalie	8748	RANAIVO Anthelme Odet	4G	872102	4G_512 Ko	169000	2021-03-08	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2025-12-31		2026-03-31				0			[]	2026-06-19 11:05:24.158672+00	2026-06-19 11:05:24.158675+00
121	FID-2026-00122	122	2026-01-05	Antanimena	Anja	7345	RAJAONARISON Guy Etienne	4G	509217	4G_512 Ko	169000	2013-01-26	Résiliation	Autres	Non utilisation	Refusée	Cloturé	2026-01-05				509217	4G_512 Ko	169000			[]	2026-06-19 11:05:24.158701+00	2026-06-19 11:05:24.158703+00
122	FID-2026-00123	123	2026-01-05	Antanimena	Jessica	14260	RANDRIAMALALA Njarasoa Charlette	4G	886449	4G_512 Ko	169000	2013-03-07	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-05		2026-03-31				0			[]	2026-06-19 11:05:24.158729+00	2026-06-19 11:05:24.158732+00
123	FID-2026-00124	124	2026-01-05	Antanimena	Anja	22666	RABEMIHOATRA Laurent Harijao	Airfiber	906666	Airfiber_Plus	189000	2024-03-04	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-05		2026-03-31				0			[]	2026-06-19 11:05:24.158757+00	2026-06-19 11:05:24.15876+00
124	FID-2026-00125	125	2026-01-05	Antanimena	Anja	68645	RASOLOFOSON Delphin	4G	416396	4G_512 Ko	169000	2017-03-19	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé	2026-01-05		2026-03-31				0			[]	2026-06-19 11:05:24.158786+00	2026-06-19 11:05:24.158788+00
125	FID-2026-00126	126	2026-01-05	Antanimena	Anja	454679	RAHERIARISON ANDRIAMANANTENASOA Noëlson	4G	874203	4G_Gold	189000	2021-04-13	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-05		2026-04-30				0			[]	2026-06-19 11:05:24.158814+00	2026-06-19 11:05:24.158816+00
126	FID-2026-00127	127	2026-01-05	Antanimena	Nathalie	476048	RAKOTONDRAMANANA Tsitontarivo Robert	4G	933852	4G_200Go	49000	2025-03-08	Résiliation	Double emploi	Double emploi	Résiliation	Cloturé	2026-01-05		2026-03-31				0			[]	2026-06-19 11:05:24.158842+00	2026-06-19 11:05:24.158845+00
127	FID-2026-00128	128	2026-01-05	Antanimena	Nathalie	483195	RAFIDISON Lovaniaina Patricia	4G	926975	4G_200Go	0	2026-01-06	Résiliation	Autres	Annulation	Upgrade	Cloturé	2026-01-05				926975	4G_500Go	49000			[]	2026-06-19 11:05:24.15887+00	2026-06-19 11:05:24.158873+00
128	FID-2026-00129	129	2026-01-05	Antanimena	Nathalie	483921	MAGO Nirina Sandra	4G	928025	4G_500Go	99000	2026-01-31	Résiliation	Problème financier	Problème financier	Downgrade	Cloturé	2026-01-05				928025	4G_200Go	49000			[]	2026-06-19 11:05:24.158898+00	2026-06-19 11:05:24.158901+00
129	FID-2026-00130	130	2026-01-05	Antanimena	Anja	486319	ANDRIANIAINA Landry	4G	931266	4G_Litebox 200Go	49000	2025-02-15	Résiliation	Insatisfaction	Insatisfaction	Refusée	Cloturé	2026-01-05				931266	4G_Litebox 200Go	49000			[]	2026-06-19 11:05:24.158926+00	2026-06-19 11:05:24.158929+00
130	FID-2026-00131	131	2026-01-05	Antanimena	Anja	488040	BAILLETTE Daniel Edmond Joseph	4G	933497	4G_200Go	49000	2025-03-06	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-05		2026-03-31				0			[]	2026-06-19 11:05:24.158956+00	2026-06-19 11:05:24.158959+00
131	FID-2026-00132	132	2026-01-06	Masay	Sabine	6875	RASOAMIHAJA Sedera	4G	203095	4G_512 Ko	0	2014-05-06	Résiliation	Autres	ZNC après 2 ème intervention	Résiliation	Cloturé			2026-01-06				0			[]	2026-06-19 11:05:24.158985+00	2026-06-19 11:05:24.158988+00
132	FID-2026-00133	133	2026-01-06	Antanimena	Anja	19695	RASOLONDRAIBE Jean Yves	4G	541214	4G_512 Ko	169000	2018-03-06	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-06		2026-03-31				0			[]	2026-06-19 11:05:24.159013+00	2026-06-19 11:05:24.159016+00
133	FID-2026-00134	134	2026-01-06	Antanimena	Jessica	22912	AOMET SARLU	4G	949547	4G_Litebox 10Go	80000	2021-03-19	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé			2026-01-31				0			[]	2026-06-19 11:05:24.159041+00	2026-06-19 11:05:24.159044+00
134	FID-2026-00135	135	2026-01-06	Antanimena	Nathalie	41625	RAJAONARIVELO Henri	4G	249326	4G_512 Ko	169000	2026-01-06	Résiliation	Autres	Changement d'opérateur	Résiliation	Cloturé	2026-01-06		2026-03-31				0			[]	2026-06-19 11:05:24.15907+00	2026-06-19 11:05:24.159072+00
135	FID-2026-00136	136	2026-01-06	Antanimena	Nathalie	135850	RALAIVAO Dimbihary Alex Denis	Airfiber	899207	Airfiber_Plus	189000	2023-03-16	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-06		2026-03-31				0			[]	2026-06-19 11:05:24.159103+00	2026-06-19 11:05:24.159106+00
136	FID-2026-00137	137	2026-01-06	Antanimena	Nathalie	256571	RASOLOFOMANANA Lovasoa Nirina	4G	655949	4G_Gold	189000	2019-03-13	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-06		2026-03-31				0			[]	2026-06-19 11:05:24.15916+00	2026-06-19 11:05:24.159165+00
137	FID-2026-00138	138	2026-01-06	Masay	Tino	416086	RAHARIMANITRA-MALA Toky Jason Herman	4G	910627	4G_85Go	125000	2020-02-24	Résiliation	Insatisfaction	Insatisfaction	Refusée	Cloturé	2026-01-06				910627	4G_85Go	125000			[]	2026-06-19 11:05:24.15923+00	2026-06-19 11:05:24.159236+00
138	FID-2026-00139	139	2026-01-06	Masay	Tino	454124	IHOLIHARINIVO Lina Isabelle	Airfiber	898949	Airfiber_Plus	189000	2023-02-28	Résiliation	Autres	AR et non utilisation	Résiliation	Cloturé	2026-01-06		2026-02-28				0			[]	2026-06-19 11:05:24.159263+00	2026-06-19 11:05:24.159266+00
139	FID-2026-00140	140	2026-01-06	Antanimena	Anja	488061	RANDRIANARISOA Domoina / RANDRIANARISOA Masoandrompitiavana Tojonirina	4G	933527	4G_200Go	49000	2025-03-06	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-06		2026-03-31				0			[]	2026-06-19 11:05:24.159293+00	2026-06-19 11:05:24.159296+00
140	FID-2026-00141	141	2026-01-06	Antanimena	Anja	141815	RANDRIANARISON Jean Claude Benatoandro	Airfiber	934254	Airfiber_First	0	2025-03-13	Résiliation	Problème financier	Problème financier	Annulation	Cloturé	2026-02-10	Anja			934254	Airfiber_Unlimited 20	99000		2026-03-31	[]	2026-06-19 11:05:24.159321+00	2026-06-19 11:05:24.159324+00
141	FID-2026-00142	142	2026-01-07	Masay	Tino	30278	SOULTANALYDylr	4G	200429	4G_512 Ko	169000	2014-04-18	Résiliation	Insatisfaction	demande info procédure résiliation	Résiliation	En Attente			2026-01-07		200429	4G_512 Ko	169000			[]	2026-06-19 11:05:24.15935+00	2026-06-19 11:05:24.159353+00
142	FID-2026-00143	143	2026-01-07	Antanimena	Nathalie	478662	RALISON Miora Annick Léa	4G	926535	4G_200Go	49000	2024-12-20	Résiliation	Autres		Changement de Nom	Cloturé	2026-01-07						49000	RAZAFINDRAMANITRA Tahirinomena Sylvio Ismael		[]	2026-06-19 11:05:24.159379+00	2026-06-19 11:05:24.159382+00
143	FID-2026-00144	144	2026-01-07	Antanimena	Anja	488714	RAKOTOMAHAZO Patricia Arisoa	Airfiber	934371	Airfiber_Ultra	0	2026-03-14	Résiliation	Autres	Annulation	Upgrade	Cloturé	2026-01-07					Airfiber_Unlimited 50	149000			[]	2026-06-19 11:05:24.159408+00	2026-06-19 11:05:24.15941+00
144	FID-2026-00145	145	2026-01-07	Antanimena	Anja	511237	ANDRIAMANALINA Fitahiana Ezra	4G	963408	4G_Litebox Prépayé	0	2026-01-02	Résiliation	Autres		Changement de Nom	Cloturé	2026-01-07						0	ANDRIAMIARANA Mendrika Gammekov		[]	2026-06-19 11:05:24.159436+00	2026-06-19 11:05:24.159439+00
145	FID-2026-00146	146	2026-01-07	Masay	Tino	455902	MAHAZAKASONRomina	Airfiber	932159	Airfiber_First	99000	2025-02-21	Résiliation	Raison personnelle	Raison personnel	Refusée	Cloturé	2026-01-07				932159	Airfiber_First	99000			[]	2026-06-19 11:05:24.159465+00	2026-06-19 11:05:24.159468+00
146	FID-2026-00147	147	2026-01-07	Masay	Tino	472518	RANDRIANTSOAHeran Tantely	4G	950391	4G_200Go	49000	2025-08-30	Résiliation	Autres	Non utilisation	Refusée	Cloturé	2026-01-07				950391	4G_200Go	49000			[]	2026-06-19 11:05:24.159493+00	2026-06-19 11:05:24.159496+00
147	FID-2026-00001	1	2026-01-08	Masay	Tino	469001	RAHANDONANDRASANA Romis Afabitana	4G	933160	4G_200Go	49000	2025-03-03	Résiliation	Double emploi	Double utilisation	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.159521+00	2026-06-19 11:05:24.159524+00
148	FID-2026-00148	148	2026-01-08	Antanimena	Anja	5667	Société. ENERGIS FD	4G	389090	4G_Gold	189000	2016-12-06	Résiliation	Changement de projet	Changement de projet	Basculement	Cloturé	2026-01-08				389090	4G_Gold	189000			[]	2026-06-19 11:05:24.15955+00	2026-06-19 11:05:24.159553+00
149	FID-2026-00149	149	2026-01-08	Antanimena	Nathalie	7536	RAMANANARIVO Rossit Lucel	4G	885547	4G_512 Ko	169000	2010-10-05	Résiliation	Changement de projet	Changement de projet	Refusée	Cloturé	2026-01-08				885547	4G_512 Ko	169000			[]	2026-06-19 11:05:24.159578+00	2026-06-19 11:05:24.159581+00
150	FID-2026-00150	150	2026-01-08	Antanimena	Jessica	28377	RAZAFINDRAKOTO Andriampanarivo Lalatiana	4G	933188	4G_400Go	149000	2025-03-03	Résiliation	Double emploi	Double emploi	Résiliation	Cloturé	2026-01-08		2026-03-31				0			[]	2026-06-19 11:05:24.159607+00	2026-06-19 11:05:24.15961+00
151	FID-2026-00151	151	2026-01-08	Antanimena	Anja	68745	ALI Abid	4G	417064	4G_Gold	189000	2017-03-25	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-08		2026-03-31				0			[]	2026-06-19 11:05:24.159635+00	2026-06-19 11:05:24.159638+00
152	FID-2026-00152	152	2026-01-08	Antanimena	Nathalie	487933	RAZANAMAHEFA Hanifitiavana Francesca	4G	933348	4G_200Go	49000	2025-03-05	Résiliation	Insatisfaction	Insatisfaction	Downgrade	Cloturé						4G_Litebox Prépayé	0			[]	2026-06-19 11:05:24.159665+00	2026-06-19 11:05:24.159668+00
153	FID-2026-00153	153	2026-01-08	Antanimena	Anja	487945	RAMAROSON Nomentsoa Anne Marie/ RAMAROSON Anjaranandrianina Marie Annick	4G	933361	4G_200Go	49000	2025-03-05	Résiliation	Problème financier	Problème financier	Downgrade	Cloturé						4G_Litebox Prépayé	0			[]	2026-06-19 11:05:24.159694+00	2026-06-19 11:05:24.159697+00
154	FID-2026-00154	154	2026-01-08	Masay	Tino	454590	ANDRIANASOLO LALADimbiharinetsa Jordy	4G	873981	4G_Gold	189000	2021-04-08	Résiliation	Changement de projet	Changement du projet	Résiliation	En Attente	2026-01-08		2026-04-30				0			[]	2026-06-19 11:05:24.159722+00	2026-06-19 11:05:24.159725+00
155	FID-2026-00155	155	2026-01-08	Antanimena	Nathalie	488642	RANDRIANJAFY Mbolatantely/ RANAIVOZAFY Tiana Lalaina Andrianjafy	4G	934272	4G_200Go	49000	2025-03-13	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé	2026-01-08		2026-03-31				0			[]	2026-06-19 11:05:24.15975+00	2026-06-19 11:05:24.159753+00
156	FID-2026-00156	156	2026-01-08	Antanimena	Nathalie	488642	RANDRIANJAFY Mbolatantely/ RANAIVOZAFY Tiana Lalaina Andrianjafy	4G	934271	4G_200Go	49000	2025-03-13	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé	2026-01-08		2026-03-31				0			[]	2026-06-19 11:05:24.159779+00	2026-06-19 11:05:24.159782+00
157	FID-2026-00157	157	2026-01-09	Antanimena	Jessica	70311	RANARIMANANA Joharitantely Bonnier Nambinina	Airfiber	899233	Airfiber_Plus	189000	2023-03-18	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-09		2026-03-31				0			[]	2026-06-19 11:05:24.159807+00	2026-06-19 11:05:24.15981+00
158	FID-2026-00158	158	2026-01-09	Masay	Tino	469632	RANDRIANARISOAIbonia Lazandraibe	Airfiber	904630	Airfiber_VIP	99000	2023-11-30	Résiliation	Changement de projet	Changement du projet	Refusée	Cloturé	2026-01-09				904630	Airfiber_VIP	99000			[]	2026-06-19 11:05:24.159835+00	2026-06-19 11:05:24.159838+00
159	FID-2026-00159	159	2026-01-09	Masay	Tino	481847	HASIMBOLOLONA Santatra	4G	933686	4G_200Go	49000	2025-03-07	Résiliation	Changement de projet	Changement du projet	Résiliation	En Attente	2026-01-09		2026-03-31				0			[]	2026-06-19 11:05:24.159864+00	2026-06-19 11:05:24.159867+00
160	FID-2026-00160	160	2026-01-09	Masay	Tino	485670	RAMANANTSOAJacqui Daniel	Airfiber	930314	Airfiber_First	149000	2025-02-07	Résiliation	Problème financier	problème financier	Downgrade	Cloturé	2026-03-31	Tino			969423	Airfiber_Unlimited 20	99000		2026-03-31	[]	2026-06-19 11:05:24.159893+00	2026-06-19 11:05:24.159895+00
161	FID-2026-00161	161	2026-01-09	Antanimena	Nathalie	488472	ANDRIAFANIRY Niaina Lodhia	4G	934045	4G_200Go	49000	2025-03-10	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-09		2026-03-31				0			[]	2026-06-19 11:05:24.159921+00	2026-06-19 11:05:24.159924+00
162	FID-2026-00162	162	2026-01-09	Masay	Tino	469606	RANDRIANJANAHARYKaho André	Airfiber	904553	Airfiber_VIP	99000	2023-11-27	Résiliation	Mobilité géographique	Démenagement à l'étranger	Refusée	Cloturé	2026-01-09				904553	Airfiber_VIP	99000			[]	2026-06-19 11:05:24.15995+00	2026-06-19 11:05:24.159953+00
163	FID-2026-00163	163	2026-01-10	Antanimena	Nathalie	31551	RAKOTOMALALA Jean Lalaina	4G	927732	4G_200Go	49000	2026-01-10	Upgrade	Autres	Upgrade	Upgrade	Cloturé	2026-01-10					4G_500Go	99000			[]	2026-06-19 11:05:24.159978+00	2026-06-19 11:05:24.159981+00
164	FID-2026-00164	164	2026-01-10	Antanimena	Nathalie	182855	CASANA Mario Faller	4G	583734	4G_Gold	0	2026-01-10	Résiliation	Autres	Bande 20 + Rajout 4G_200Go(964193)	Basculement	Cloturé	2026-01-10				963856	Airfiber_Unlimited 30	149000			[]	2026-06-19 11:05:24.160006+00	2026-06-19 11:05:24.160009+00
165	FID-2026-00165	165	2026-01-10	Antanimena	Nathalie	486495	RANAIVOSON Lantonirina Mariella	Airfiber	931403	Airfiber_First	99000	2025-02-15	Résiliation	Problème financier	Problème financier	Basculement	Cloturé	2026-02-05				965661	Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.160034+00	2026-06-19 11:05:24.160037+00
166	FID-2026-00166	166	2026-01-12	Antanimena	Anja	12053	RAMAMONJISOA Miandra Lalaina	4G	838305	4G_512 Ko	0	2020-03-18	Résiliation	Insatisfaction	Insatisfaction	Annulation	Cloturé	2026-03-26				969023	Airfiber_Unlimited 20	99000		2026-03-26	[]	2026-06-19 11:05:24.160063+00	2026-06-19 11:05:24.160066+00
167	FID-2026-00167	167	2026-01-12	Antanimena	Anja	21775	RAKOTOARIVAO Tolotra Nandrasana	4G	878939	4G_10Go	80000	2013-03-31	Résiliation	Raison personnelle	Décès utilisateur	Résiliation	Cloturé	2026-01-12		2026-03-31				0			[]	2026-06-19 11:05:24.160098+00	2026-06-19 11:05:24.160101+00
168	FID-2026-00168	168	2026-01-12	Antanimena	Anja	68659	Société. YASKA SARLU	4G	416502	4G_Gold	189000	2017-03-20	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé	2026-01-12		2026-03-31				0			[]	2026-06-19 11:05:24.160154+00	2026-06-19 11:05:24.160159+00
169	FID-2026-00169	169	2026-01-12	Antanimena	Nathalie	101517	RASOAMANANA Renée Colette	4G	795149	4G_Gold	189000	2019-12-18	Upgrade	Insatisfaction	Insatisfaction	Upgrade	Cloturé	2026-01-12					Airfiber_Unlimited 30	189000			[]	2026-06-19 11:05:24.160189+00	2026-06-19 11:05:24.160192+00
170	FID-2026-00170	170	2026-01-12	Antanimena	Anja	453187	RAMAMONJISOA Fara Rondro	4G	948911	4G_200Go	0	2025-08-07	Résiliation	Autres	ZNC après intervention	Résiliation	Cloturé			2026-01-12				0			[]	2026-06-19 11:05:24.160219+00	2026-06-19 11:05:24.160222+00
171	FID-2026-00171	171	2026-01-12	Antanimena	Anja	487037	RATSILEFITRA Voahirana	Airfiber	932124	Airfiber_First	0	2026-02-20	Résiliation	Autres	Annulation	Upgrade	Cloturé						Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.160248+00	2026-06-19 11:05:24.160251+00
172	FID-2026-00172	172	2026-01-12	Antanimena	Tino	488616	MARA Sambelahatse	Airfiber	934238	Airfiber_First	99000	2025-03-13	Résiliation	Problème financier	Problème financier	Résiliation	Cloturé	2026-01-12		2026-03-31				0			[]	2026-06-19 11:05:24.160277+00	2026-06-19 11:05:24.16028+00
173	FID-2026-00173	173	2026-01-12	Antanimena	Tino	490317	RABENEFA Haritiana Zafizara	4G	936480	4G_500Go	99000	2025-04-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-12		2026-04-30				0			[]	2026-06-19 11:05:24.160306+00	2026-06-19 11:05:24.160309+00
174	FID-2026-00174	174	2026-01-12	Antanimena	Anja	505404	SUDIKI Abdallah Oili	4G	955641	4G_200Go	49000	2026-01-12	Upgrade	Autres	Upgrade	Upgrade	Cloturé	2026-01-12					4G_500Go	99000			[]	2026-06-19 11:05:24.160336+00	2026-06-19 11:05:24.160339+00
175	FID-2026-00175	175	2026-01-12	Masay	sabine	487951	RAKOTOANDRIAMIALISOAMirado Ny Aina Antonio	4G	933368	4G_200Go	49000	2025-03-05	Résiliation	Mobilité géographique	Déplacement fréquent	Refusée	Cloturé	2026-01-12				933368	4G_200Go	49000			[]	2026-06-19 11:05:24.160365+00	2026-06-19 11:05:24.160368+00
176	FID-2026-00176	176	2026-01-13	Antanimena	Tino	173117	Société. HAREL MALLAC TECHNOLOGIE MADAGASCAR	4G	563885	4G_Gold	189000	2022-04-12	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.160393+00	2026-06-19 11:05:24.160396+00
177	FID-2026-00177	177	2026-01-13	Antanimena	Tino	77365	RAHERISON Rija Eric	4G	451663	4G_Gold	189000	2017-07-31	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente	2026-05-11	Fitiavana	2026-07-31				0			[]	2026-06-19 11:05:24.160421+00	2026-06-19 11:05:24.160424+00
178	FID-2026-00178	178	2026-01-13	Antanimena	Tino	173117	Société. HAREL MALLAC TECHNOLOGIE MADAGASCAR	4G	647495	4G_Gold	189000	2019-02-15	Résiliation	Changement de projet	Changement de projet	Refusée	Cloturé	2026-01-13				647495	4G_Gold	189000			[]	2026-06-19 11:05:24.16045+00	2026-06-19 11:05:24.160453+00
179	FID-2026-00179	179	2026-01-13	Antanimena	Nathalie	470635	HOSENY Fanomeza Clément / ANDRIANARISOA Fabien Chrysanthé	4G	956722	4G_200Go	49000	2025-11-06	Résiliation	Mobilité géographique	Déplacement fréquent	Refusée	Cloturé	2026-01-13				956722	4G_200Go	49000			[]	2026-06-19 11:05:24.160478+00	2026-06-19 11:05:24.160481+00
180	FID-2026-00180	180	2026-01-13	Antanimena	Anja	487708	RAMAROKOTO Onintsoa Rovaniaina	4G	933002	4G_200Go	49000	2025-03-01	Résiliation	Insatisfaction	Insatisfaction	Refusée	Cloturé	2026-01-13				933002	4G_200Go	49000			[]	2026-06-19 11:05:24.160507+00	2026-06-19 11:05:24.160509+00
181	FID-2026-00181	181	2026-01-13	Antanimena	Tino	488724	RAGOSITERA Bénédicth / MAHAMOUD'ALI Zo Tahina Janahary An-Oufidine	4G	934377	4G_200Go	49000	2025-03-14	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-13		2026-03-31				0			[]	2026-06-19 11:05:24.160535+00	2026-06-19 11:05:24.160538+00
182	FID-2026-00182	182	2026-01-14	Antanimena	Nathalie	50081	RAKOTONDRAINIBE Tanya Martina / RAKOTONDRAINIBE Ida Carene	4G	274292	4G_512 Ko	169000	2016-04-05	Résiliation	Mobilité géographique	Déménagement	Résiliation	Cloturé	2026-01-14		2026-04-30				0			[]	2026-06-19 11:05:24.160563+00	2026-06-19 11:05:24.160566+00
183	FID-2026-00183	183	2026-01-14	Antanimena	Tino	488907	RANDRIANAMBININA Nomenjanahary Mariella	4G	934626	4G_500Go	99000	2025-03-13	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-14		2026-03-31				0			[]	2026-06-19 11:05:24.160591+00	2026-06-19 11:05:24.160594+00
184	FID-2026-00184	184	2026-01-15	Antanimena	Anja	93797	RAHARINJATOVO Fanjava Fandresena	4G	905963	4G_50Go	99000	2024-02-01	Résiliation	Mobilité géographique	Déménagement	Refusée	Cloturé	2026-01-15				905963	4G_50Go	99000			[]	2026-06-19 11:05:24.16062+00	2026-06-19 11:05:24.160622+00
185	FID-2026-00185	185	2026-01-15	Masay	Tino	352583	JAO-VENANTEric	Airfiber	902493	Airfiber_Plus	189000	2023-09-03	Résiliation	Raison personnelle	Problème facture	Refusée	Cloturé	2026-01-15				902493	Airfiber_Plus	189000			[]	2026-06-19 11:05:24.160648+00	2026-06-19 11:05:24.16065+00
186	FID-2026-00186	186	2026-01-15	Antanimena	Anja	469138	RASOLOFONJATOVO Harilala Augustin	Airfiber	907415	Airfiber_Plus	189000	2024-03-22	Résiliation	Insatisfaction	Insatisfaction	Résiliation	Cloturé	2026-01-15		2026-03-31				0			[]	2026-06-19 11:05:24.160676+00	2026-06-19 11:05:24.160678+00
187	FID-2026-00187	187	2026-01-15	Masay	Sabine	453680	RAFALIMANANAFenosoa Nathalie	4G	907253	4G_BOX postpayé 65Go	0	2026-01-15	Résiliation	Problème financier	Problème financier	Downgrade	Cloturé	2026-01-15				964653	4G_200Go	49000			[]	2026-06-19 11:05:24.160704+00	2026-06-19 11:05:24.160707+00
188	FID-2026-00188	188	2026-01-15	Masay	Tino	489151	RANDRIAMAMENOMORAVELOSON Arnold / FANAMBINANAArofenitra	4G	934928	4G_500Go	99000	2025-03-22	Résiliation	Mobilité géographique	Démenagement Province	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.160749+00	2026-06-19 11:05:24.160752+00
189	FID-2026-00189	189	2026-01-16	Antanimena	Nathalie	36879	IAVISOA Heriniaina Viviane Pascaline	Airfiber	905794	Airfiber_Plus	0	2026-01-16	Résiliation	Autres	annulation	Downgrade	Cloturé					964251	Airfiber_Unlimited 50	149000			[]	2026-06-19 11:05:24.160778+00	2026-06-19 11:05:24.160781+00
190	FID-2026-00190	190	2026-01-16	Antanimena	Nathalie	466908	HADJI ABDALLAH Ben Mohamed / RAZAFITSALAMARemi Ibrahim	Airfiber	899470	Airfiber_Ultra	0	2023-03-30	Résiliation	Changement de projet	Réactivation REFNUM+annulation	Réactivation	Cloturé	2026-04-01	Anja			969504	Airfiber_Unlimited 50	99000		2026-04-01	[]	2026-06-19 11:05:24.160806+00	2026-06-19 11:05:24.160809+00
219	FID-2026-00219	219	2026-01-29	Antanimena	Jessica	30208	RANARIVONY Richard	Airfiber	899707	Airfiber_Plus	189000	2023-04-08	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.161701+00	2026-06-19 11:05:24.161704+00
191	FID-2026-00191	191	2026-01-19	Antanimena	Tino	455295	RAKOTOARIZANANY Bina Miharizo/MOHAMED CHEIKH Zacharia	Airfiber	907334	Airfiber_Plus	189000	2024-03-22	Résiliation	Problème financier	problème financier	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.160834+00	2026-06-19 11:05:24.160837+00
192	FID-2026-00192	192	2026-01-19	Antanimena	Anja	491876	RAMANARIVOVononanasoa Danielie	Airfiber	938715	Airfiber_Ultra	149000	2025-04-30	Résiliation	Changement de projet	changement de projet	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.160863+00	2026-06-19 11:05:24.160866+00
193	FID-2026-00193	193	2026-01-20	Antanimena	Anja	487270	RANDRIANANTENAINA Faniry Emile	4G	932635	4G_200Go	49000	2025-02-26	Résiliation	Autres	changement d'opérateur	Refusée	Cloturé	2026-01-20						49000			[]	2026-06-19 11:05:24.160892+00	2026-06-19 11:05:24.160895+00
194	FID-2026-00194	194	2026-01-20	Antanimena	Nathalie	509546	RAKOTOARISON Micka Nomena	4G	961002	4G_500Go	49000	2025-12-02	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-01-20						49000			[]	2026-06-19 11:05:24.16092+00	2026-06-19 11:05:24.160923+00
195	FID-2026-00195	195	2026-01-20	Masay	Tino	49146	RATOVELOMANANASamoela	4G	270660	4G_512 Ko	0	2016-02-05	Résiliation	Raison personnelle	décès titulaire + BASCULEMENT en 4G_200Go	Changement de Nom	Cloturé	2026-01-20				965407	4G_200Go	49000	RATRIMOARIVONY Ando		[]	2026-06-19 11:05:24.160949+00	2026-06-19 11:05:24.160952+00
196	FID-2026-00196	196	2026-01-21	Antanimena	Anja	454822	ANDRIANATOANDRO Sitraka Todisoa Fy	4G	909424	4G_500Go	99000	2024-04-29	Résiliation	Mobilité géographique	déménagement	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.160977+00	2026-06-19 11:05:24.16098+00
197	FID-2026-00197	197	2026-01-21	Antanimena	Nathalie	486363	RAHARISON Nomenjanahary Sombiniaina Cynthia	4G	931223	4G_200Go	49000	2025-02-14	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-01-21						49000			[]	2026-06-19 11:05:24.161005+00	2026-06-19 11:05:24.161008+00
198	FID-2026-00198	198	2026-01-21	Antanimena	Anja	504822	EZOTONDRAZA Emilson Fanoela Solomon	4G	954923	4G_200Go	49000	2025-10-15	Résiliation	Mobilité géographique	affectation	Refusée	Cloturé	2026-01-21						49000			[]	2026-06-19 11:05:24.161034+00	2026-06-19 11:05:24.161037+00
199	FID-2026-00199	199	2026-01-21	Masay	Tino	10768	CITY IMMO	4G	667167	4G_Gold	0	2012-02-27	Résiliation	Insatisfaction	Insatisfaction	Downgrade	Cloturé	2026-01-21						149000			[]	2026-06-19 11:05:24.161061+00	2026-06-19 11:05:24.161064+00
200	FID-2026-00200	200	2026-01-21	Masay	Tino	481477	RAKOTOARISOA Vonjinirina Fidèle / RAHARISOAMamisoa	4G	937158	4G_200Go	49000	2025-04-15	Résiliation	Problème financier	Problème financier	Refusée	Cloturé	2026-01-21						49000			[]	2026-06-19 11:05:24.16109+00	2026-06-19 11:05:24.161096+00
201	FID-2026-00201	201	2026-01-22	Antanimena	Anja	12265	RASOAZANANY RASOANILANA Armance	4G	717096	4G_512 Ko	169000	2019-07-24	Résiliation	Raison personnelle	décès titulaire	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.161146+00	2026-06-19 11:05:24.161151+00
202	FID-2026-00202	202	2026-01-22	Antanimena	Nathalie	485240	RANDRIAMBELO Rojo Tiana Romaine	Airfiber	929726	Airfiber_Plus	189000	2025-02-01	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-01-22						189000			[]	2026-06-19 11:05:24.16118+00	2026-06-19 11:05:24.161183+00
203	FID-2026-00203	203	2026-01-22	Masay	Nathalie	472874	RAZAKARIMALALARovaniaia Annita	4G	935011	4G_400Go	149000	2025-03-24	Résiliation	Mobilité géographique	Démenagement en province	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.16121+00	2026-06-19 11:05:24.161213+00
204	FID-2026-00204	204	2026-01-23	Antanimena	Anja	454405	RAKOTOARIVONINA Tiana Hary Zo	4G	873511	4G_Gold	189000	2021-03-31	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.161239+00	2026-06-19 11:05:24.161242+00
205	FID-2026-00205	205	2026-01-23	Antanimena	Nathalie	487794	ARINDRASANA Mialisoa Dorah	4G	933138	4G_200Go	49000	2025-03-03	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-01-23						49000			[]	2026-06-19 11:05:24.161268+00	2026-06-19 11:05:24.16127+00
206	FID-2026-00206	206	2026-01-23	Antanimena	Nathalie	487814	BEZOKINY Irene Dorcia	4G	933179	4G_200Go	49000	2025-03-03	Résiliation	Mobilité géographique	déménagement	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.161296+00	2026-06-19 11:05:24.161299+00
207	FID-2026-00207	207	2026-01-23	Antanimena	Anja	491640	RADAFINIA Voaharimanjaka	4G	938390	4G_500Go	99000	2025-04-28	Résiliation	Problème financier	problème financier	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.161325+00	2026-06-19 11:05:24.161328+00
208	FID-2026-00208	208	2026-01-23	Masay	Tino	8907	RABEMILARaivo Soahary	4G	880114	4G_Gold	189000	2021-09-09	Basculement	Problème financier	Problème financier	Refusée	Cloturé	2026-01-23						189000			[]	2026-06-19 11:05:24.161353+00	2026-06-19 11:05:24.161356+00
209	FID-2026-00209	209	2026-01-24	Antanimena	Jessica	21153	ANDRIAMALALA Hajaniaina Lanto Rivosoa	Airfiber	907426	Airfiber_Plus	189000	2024-03-25	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.161381+00	2026-06-19 11:05:24.161384+00
210	FID-2026-00210	210	2026-01-26	Antanimena	Anja	462772	RALAIBEZA Angelo Raphaël	Airfiber	906222	Airfiber_First	99000	2025-01-26	Résiliation	Autres	basculement	Basculement	Cloturé					964971	Airfiber_Unlimited 20	99000			[]	2026-06-19 11:05:24.16141+00	2026-06-19 11:05:24.161413+00
211	FID-2026-00211	211	2026-01-26	Antanimena	Anja	484232	RAJAONARISON Mihajatiana	4G	928423	4G_200Go	49000	2025-01-14	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-01-26						49000			[]	2026-06-19 11:05:24.161438+00	2026-06-19 11:05:24.161441+00
212	FID-2026-00212	212	2026-01-26	Antanimena	Anja	488756	RAKOTOBE Daniel Romuald	4G	934427	4G_200Go	49000	2025-03-15	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.16147+00	2026-06-19 11:05:24.161475+00
213	FID-2026-00213	213	2026-01-26	Antanimena	Anja	489298	RAMAROSON Tojonirina	4G	935117	4G_500Go	99000	2025-03-26	Résiliation	Autres	basculement	Basculement	Cloturé	2026-01-26				935117	4G_Litebox Prépayé	0			[]	2026-06-19 11:05:24.161517+00	2026-06-19 11:05:24.161523+00
214	FID-2026-00214	214	2026-01-27	Antanimena	Nathalie	10121	RAMAROKOTO Ketamalala	4G	906283	4G_30Go	0	2026-02-19	Résiliation	Autres	annulation	Upgrade	Cloturé	2026-01-27					4G_200Go	49000			[]	2026-06-19 11:05:24.161552+00	2026-06-19 11:05:24.161555+00
215	FID-2026-00215	215	2026-01-27	Antanimena	Anja	40509	RAMIANDRISOA Marie Juliette	4G	250171	4G_512 Ko	0	2026-01-27	Résiliation	Autres	échange de service	Basculement	Cloturé					964935	Airfiber_Unlimited 30	0			[]	2026-06-19 11:05:24.161581+00	2026-06-19 11:05:24.161584+00
216	FID-2026-00216	216	2026-01-27	Masay	Tino	488443	RAKOTOARIMANGA Koloinandro Mamiratra /RAKOTONARIVOTinah Emmanuelle Sombiniaina	4G	937428	4G_200Go	49000	2025-04-18	Résiliation	Changement de projet	changement du projet	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.161613+00	2026-06-19 11:05:24.161616+00
217	FID-2026-00217	217	2026-01-28	Antanimena	Nathalie	487331	RASOANIRIANA Anjara	4G	932505	4G_200Go	49000	2025-02-25	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-01-28						49000			[]	2026-06-19 11:05:24.161643+00	2026-06-19 11:05:24.161646+00
218	FID-2026-00218	218	2026-01-28	Antanimena	Nathalie	487621	RAKOTONJANAHARY Tina Malala Ginnah	4G	932899	4G_200Go	98000	2025-02-28	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-01-28						98000			[]	2026-06-19 11:05:24.161672+00	2026-06-19 11:05:24.161675+00
220	FID-2026-00220	220	2026-01-29	Antanimena	Anja	368642	RAHARISON Mika Andoniaina Geraldo	Airfiber	939020	Airfiber_Unlimited 30	0	2025-05-02	Résiliation	Mobilité géographique	déménagement	Annulation	Cloturé	2026-04-30	Tino			970128	Airfiber_Unlimited 20	149000	RAHARISON Harrys Fitzgérald	2026-04-30	[]	2026-06-19 11:05:24.16173+00	2026-06-19 11:05:24.161733+00
221	FID-2026-00221	221	2026-01-29	Antanimena	Nathalie	471439	RAMANANTSOA Alison Judy Anna	Airfiber	908775	Airfiber_Plus	189000	2024-04-24	Résiliation	Mobilité géographique	déménagement	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.161759+00	2026-06-19 11:05:24.161761+00
222	FID-2026-00222	222	2026-01-29	Antanimena	Anja	485378	RAMANAMPAMONJY Mirija Lalaina	4G	929864	4G_200Go	0	2025-02-03	Résiliation	Autres	annulation	Basculement	Cloturé	2026-01-29						49000			[]	2026-06-19 11:05:24.161787+00	2026-06-19 11:05:24.16179+00
223	FID-2026-00223	223	2026-01-29	Antanimena	Anja	485877	RAKOTONARIVO Zo Andrianina	4G	930592	4G_200Go	49000	2025-02-10	Résiliation	Double emploi	double emploi	Refusée	Cloturé	2026-01-29						49000			[]	2026-06-19 11:05:24.161816+00	2026-06-19 11:05:24.161818+00
224	FID-2026-00224	224	2026-01-29	Antanimena	Nathalie	512148	RABESOLONIRINA Esthelle	4G	964678	4G_200Go	49000	2026-01-23	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-01-29						49000			[]	2026-06-19 11:05:24.161844+00	2026-06-19 11:05:24.161847+00
225	FID-2026-00225	225	2026-01-29	Masay	Tino	41644	M. MILLOT Gérard Pierre Jacques	4G	328906	4G_512 Ko	169000	2016-07-25	Résiliation	Changement de projet	changement du projet	Résiliation	En Attente	2026-05-02	Jessica	2026-07-31				0			[]	2026-06-19 11:05:24.161872+00	2026-06-19 11:05:24.161875+00
226	FID-2026-00226	226	2026-01-30	Antanimena	Nathalie	512078	ZARA Cecilia /RASOANANDRASANA Marie Trecy	4G	964585	4G_200Go	0	2026-01-21	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé			2026-01-30				0			[]	2026-06-19 11:05:24.161901+00	2026-06-19 11:05:24.161904+00
227	FID-2026-00227	227	2026-01-31	Antanimena	Anja	488667	HELINIRINA Renee Eva Rasolomampionona/ MAMIARINELINA Asnah Jenny Oliviah	4G	934307	4G_200Go	49000	2025-03-13	Résiliation	Double emploi	double emploi	Refusée	Cloturé	2026-01-31						49000			[]	2026-06-19 11:05:24.161929+00	2026-06-19 11:05:24.161932+00
228	FID-2026-00228	228	2026-02-02	Antanimena	Tino	436380	RAKOTOARISEHENOMiarinantenaina Hobintsalama	4G	847041	4G_Gold	0	2020-04-11	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.161957+00	2026-06-19 11:05:24.16196+00
229	FID-2026-00229	229	2026-02-02	Antanimena	Tino	29569	ANDRIANALISONHoly Irina	4G	199076	4G_512 Ko	0	2014-04-04	Résiliation	Mobilité géographique	déménagement province	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.161985+00	2026-06-19 11:05:24.161988+00
230	FID-2026-00230	230	2026-02-02	Antanimena	Tino	26034	VOLOLONIRINAAngéline	Airfiber	917612	Airfiber_Plus	0	2021-04-03	Résiliation	Raison personnelle	problème personnell	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.162014+00	2026-06-19 11:05:24.162017+00
231	FID-2026-00231	231	2026-02-02	Antanimena	Tino	259947	CLIC MARKETING	4G	659568	4G_Gold	189000	2019-03-25	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-02-02						189000			[]	2026-06-19 11:05:24.162042+00	2026-06-19 11:05:24.162045+00
232	FID-2026-00233	233	2026-02-03	Masay	Anja	487325	RASOLOMANANA RANTOTIANA Florent Cedrick	4G	932498	4G_200Go	49000	2025-02-25	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-02-03						49000			[]	2026-06-19 11:05:24.16207+00	2026-06-19 11:05:24.162073+00
233	FID-2026-00234	234	2026-02-03	Masay	Jessica	470984	RANDRIAMAMPIONONA Elly / RAMILIARISOA Thérèsa Murielle	4G	907895	4G_Litebox 50Go	0	2024-04-05	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.162103+00	2026-06-19 11:05:24.162106+00
234	FID-2026-00235	235	2026-02-03	Antanimena	Tino	471797	RASOARINELINANomery	Airfiber	909268	Airfiber_First	0	2024-04-27	Résiliation	Mobilité géographique	déménagement province	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.162174+00	2026-06-19 11:05:24.162181+00
235	FID-2026-00236	236	2026-02-04	Masay	Anja	469001	RAHANDONANDRASANA Romis Afabitana	4G	965558	4G_200Go	0	2025-04-30	Résiliation	Autres	changement de nom	Annulation	Cloturé	2026-02-04	Anja			965558	4G_200Go	49000	RANDRIANAIVO Valérie Celse	2026-04-30	[]	2026-06-19 11:05:24.162225+00	2026-06-19 11:05:24.162229+00
236	FID-2026-00237	237	2026-02-04	Antanimena	Tino	37266	HUO KANG Ludovic Ronny	4G	934230	4G_200Go	49000	2025-03-12	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-02-04						49000			[]	2026-06-19 11:05:24.162278+00	2026-06-19 11:05:24.162283+00
237	FID-2026-00238	238	2026-02-04	Antanimena	Tino	454774	RANDROSO Naivo Solo Pascal James	Airfiber	913396	Airfiber_Plus	189000	2021-04-17	Résiliation	Problème financier	prolème personnelle	Résiliation	Cloturé		Jessica	2026-04-30				0			[]	2026-06-19 11:05:24.162332+00	2026-06-19 11:05:24.162338+00
238	FID-2026-00239	239	2026-02-04	Antanimena	Tino	454660	RATSIMANDRESY Andrianasara Faratiana Hasina	4G	907490	4G_BOX postpayé 65Go	119000	2021-04-12	Résiliation	Changement de projet	Changement de projet	Résiliation	Cloturé		Anja	2026-04-30				0			[]	2026-06-19 11:05:24.162366+00	2026-06-19 11:05:24.162369+00
239	FID-2026-00240	240	2026-02-04	Antanimena	Tino	15462	RANANJA ANDRIATAHIANA Valérie Nivohanta	4G	883656	4G_512 Ko	169000	2012-04-28	Résiliation	Autres	Retraité	Résiliation	Cloturé		Anja	2026-04-30				0			[]	2026-06-19 11:05:24.162395+00	2026-06-19 11:05:24.162398+00
240	FID-2026-00241	241	2026-02-04	Antanimena	Tino	455074	RABEARIVELO Lalaina Fanantenana	4G	907373	4G_85Go	149000	2021-04-29	Résiliation	Problème financier	problème personnelle	Résiliation	Cloturé		Nathalie	2026-04-30				0			[]	2026-06-19 11:05:24.162424+00	2026-06-19 11:05:24.162427+00
241	FID-2026-00242	242	2026-02-04	Antanimena	Tino	24574	RASAMOELINA Seranirina Sylviane / INFOTYP MADA SHORE	4G	917599	4G_200Go	99000	2024-08-30	Basculement	Raison personnelle		Upgrade	Cloturé	2026-02-04						99000			[]	2026-06-19 11:05:24.162453+00	2026-06-19 11:05:24.162456+00
242	FID-2026-00243	243	2026-02-04	Masay	Anja	455875	LANDRYS SARLU TIANA Harilalao	4G	877251	4G_Gold	189000	2020-11-06	Résiliation	Changement de projet	Changement de projet	Refusée	Cloturé							189000			[]	2026-06-19 11:05:24.162482+00	2026-06-19 11:05:24.162485+00
243	FID-2026-00244	244	2026-02-04	Masay	Anja	487486	RAKOTONIRINA Tovondrainy Hemandimby	4G	932710	4G_200Go	49000	2025-02-27	Résiliation	Insatisfaction	déménagement	Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.162511+00	2026-06-19 11:05:24.162514+00
244	FID-2026-00245	245	2026-02-04	Masay	Anja	491573	RAMAROHERY Nirina Tanteliniaina	4G	938292	4G_200Go	49000	2025-04-28	Résiliation	Problème financier		Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.162539+00	2026-06-19 11:05:24.162542+00
245	FID-2026-00246	246	2026-02-04	Masay	Anja	470202	HASIMBOLA Ny Antsa	Airfiber	965505	Airfiber_First	0	2024-01-25	Réactivation	Autres	Réactivation REFNUM	Réactivation	Cloturé	2026-02-04	Anja			965505	Airfiber_Unlimited 50	149000		2026-02-04	[]	2026-06-19 11:05:24.162567+00	2026-06-19 11:05:24.16257+00
246	FID-2026-00247	247	2026-02-05	Antanimena	Tino	23124	RAKOTONDRATSIMBA Sylvie Marie	4G	500194	4G_512 Ko	169000	2013-03-06	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé		Nathalie	2026-03-31				0			[]	2026-06-19 11:05:24.162598+00	2026-06-19 11:05:24.162601+00
247	FID-2026-00248	248	2026-02-06	Antanimena	Nathalie	474824	AICHA Princesse Mariasy	Airfiber	957197	Airfiber_Unlimited 20	99000	2025-11-08	Résiliation	Mobilité géographique	déménagement province	Refusée	Cloturé	2026-02-06						99000			[]	2026-06-19 11:05:24.162628+00	2026-06-19 11:05:24.16263+00
248	FID-2026-00249	249	2026-02-06	Antanimena	Nathalie	487406	MIRAHERISOA Françia	4G	932609	4G_200Go	49000	2025-02-26	Résiliation	Mobilité géographique	déménagement province	Refusée	Cloturé	2026-02-06						49000			[]	2026-06-19 11:05:24.162656+00	2026-06-19 11:05:24.162659+00
249	FID-2026-00250	250	2026-02-06	Antanimena	Tino	469748	RAKOTOSON Johary Nantenaina	4G	904892	4G_200Go	99000	2023-12-09	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.162685+00	2026-06-19 11:05:24.162687+00
250	FID-2026-00251	251	2026-02-06	Masay	Anja	501497	RANDRIANAIVO Njaratiana Fenosoa Ericà	4G	951377	4G_200Go	49000	2025-09-10	Résiliation	Mobilité géographique	départ à l'étranger	Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.162713+00	2026-06-19 11:05:24.162716+00
251	FID-2026-00252	252	2026-02-07	Antanimena	Nathalie	470511	RANDRIANARIVONY Rija Frank	4G	937610	4G_200Go	49000	2025-04-19	Basculement	Problème financier	problème personnelle	Basculement	En Attente						4G_Prépayé	0			[]	2026-06-19 11:05:24.162741+00	2026-06-19 11:05:24.162744+00
252	FID-2026-00253	253	2026-02-07	Antanimena	Nathalie	68111	RALAMBO Alain Narcisse	4G	411252	4G_Gold	0	2017-02-10	Résiliation	Autres		Annulation	Cloturé	2026-02-27	Nathalie				4G_200Go	49000			[]	2026-06-19 11:05:24.162769+00	2026-06-19 11:05:24.162772+00
253	FID-2026-00254	254	2026-02-09	Antanimena	Anja	488053	RAKOTONIRINA Gualbert Felix	4G	933518	4G_200Go	49000	2025-03-06	Résiliation	Mobilité géographique	déménagement province	Annulation	Cloturé	2026-04-27	Tino					49000			[]	2026-06-19 11:05:24.162798+00	2026-06-19 11:05:24.162801+00
254	FID-2026-00255	255	2026-02-09	Antanimena	Tino	15702	RAYMOND	4G	818054	4G_Gold	189000	2012-03-27	Résiliation	Autres	Retraité	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.162826+00	2026-06-19 11:05:24.162829+00
255	FID-2026-00256	256	2026-02-09	Masay	Anja	469713	SWAYZE Akbaraly Moise	Airfiber	938283	Airfiber_Unlimited 20	99000	2025-04-25	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.162855+00	2026-06-19 11:05:24.162857+00
256	FID-2026-00257	257	2026-02-09	Masay	Anja	469713	SWAYZE Akbaraly Moise	4G	904777	4G_200Go	49000	2025-04-25	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.162883+00	2026-06-19 11:05:24.162886+00
257	FID-2026-00258	258	2026-02-09	Masay	Anja	449857	SOAVELO Hary Toky Nantenaina	4G	945194	4G_200Go	49000	2025-07-02	Résiliation	Changement de projet		Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.162911+00	2026-06-19 11:05:24.162914+00
258	FID-2026-00259	259	2026-02-10	Masay	Anja	48386	ASSOCIATION PROMES	Airfiber	897482	Airfiber_Ultra	199000	2022-12-16	Résiliation	Autres	Non utilisation	Refusée	Cloturé							199000			[]	2026-06-19 11:05:24.162944+00	2026-06-19 11:05:24.162947+00
259	FID-2026-00260	260	2026-02-10	Masay	Anja	48386	ASSOCIATION PROMES	Airfiber	897481	Airfiber_Ultra	199000	2022-12-16	Résiliation	Autres	Non utilisation	Refusée	Cloturé							199000			[]	2026-06-19 11:05:24.162973+00	2026-06-19 11:05:24.162976+00
260	FID-2026-00261	261	2026-02-10	Masay	Anja	48386	ASSOCIATION PROMES	Airfiber	897475	Airfiber_Ultra	199000	2022-12-16	Résiliation	Autres	Non utilisation	Refusée	Cloturé							199000			[]	2026-06-19 11:05:24.163002+00	2026-06-19 11:05:24.163005+00
261	FID-2026-00262	262	2026-02-10	Masay	Nathalie	470799	RAZAFINDRAKOTO Manjakasoa Murielle	4G	909578	4G_85Go	0	2025-04-30	Résiliation	Changement de projet		Annulation	Cloturé	2026-04-30	Anja				4G_500Go	79000		2026-04-30	[]	2026-06-19 11:05:24.163031+00	2026-06-19 11:05:24.163034+00
262	FID-2026-00263	263	2026-02-10	Masay	Anja	490542	RAKOTONDRAVONY Narivony Rindra	4G	938132	4G_200Go	49000	2025-04-25	Résiliation	Autres	Non utilisation	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.163059+00	2026-06-19 11:05:24.163062+00
263	FID-2026-00264	264	2026-02-10	Antanimena	Jessica	17676	RAKOTONIRINA Charles	4G	938786	4G_200Go	99000	2025-04-14	Résiliation	Changement de projet		Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.163088+00	2026-06-19 11:05:24.163097+00
264	FID-2026-00265	265	2026-02-10	Antanimena	Nathalie	454896	ANDRIAMAMPIANINA Malalatiana	4G	874883	4G_Gold	189000	2021-04-21	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.163148+00	2026-06-19 11:05:24.163155+00
265	FID-2026-00266	266	2026-02-10	Antanimena	Nathalie	66956	FIRAISAINA BEMASOANDRO	Airfiber	936478	Airfiber_Ultra	249000	2025-04-09	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.163221+00	2026-06-19 11:05:24.163226+00
266	FID-2026-00267	267	2026-02-12	Masay	Anja	480737	RASOAMANANA Francia Onja	4G	930396	4G_200Go	49000	2025-02-08	Résiliation	Changement de projet		Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.163255+00	2026-06-19 11:05:24.163258+00
267	FID-2026-00268	268	2026-02-12	Masay	Anja	486711	RAKOTOSON Arisoa Finoana	4G	931725	4G_200Go	49000	2025-02-16	Résiliation	Changement de projet		Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.163284+00	2026-06-19 11:05:24.163287+00
268	FID-2026-00269	269	2026-02-12	Masay	Anja	495597	NY MAHERITIANA Fanambinatsoa Mirija	Airfiber	943665	Airfiber_VIP	99000	2025-06-15	Résiliation	Insatisfaction	débit insuffisant	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.163313+00	2026-06-19 11:05:24.163316+00
269	FID-2026-00270	270	2026-02-12	Masay	Anja	490869	ANDRIANJAFINDRAZANANY Parisolomalalarintsoa / RAKOTOMALALARINTSOA Santatra Fitahiana	4G	940613	4G_Litebox 200Go	49000	2025-05-19	Résiliation	Autres	non renouvellement contrat	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.163341+00	2026-06-19 11:05:24.163345+00
270	FID-2026-00271	271	2026-02-12	Masay	Anja	483084	RAKOTONANDRASANA Ny Hasina Mahery	4G	926816	4G_200Go	49000	2024-12-23	Résiliation	Changement de projet		Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.163374+00	2026-06-19 11:05:24.163376+00
271	FID-2026-00272	272	2026-02-12	Masay	Anja	471929	RAKOTOMANGA Maholinirina Solo	Airfiber	909459	Airfiber_First	0	2024-04-29	Résiliation	Autres	NS plus intéressante et moins chère	Annulation	Cloturé	2026-03-18	Anja			968816	Airfiber_Unlimited 50	99000		2026-04-29	[]	2026-06-19 11:05:24.163402+00	2026-06-19 11:05:24.163405+00
272	FID-2026-00273	273	2026-02-12	Antanimena	Anja	471266	WANG YUYING	4G	908391	4G_85Go	149000	2024-04-16	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé		Nathalie	2026-04-30				0			[]	2026-06-19 11:05:24.16343+00	2026-06-19 11:05:24.163433+00
273	FID-2026-00274	274	2026-02-12	Antanimena	Tino	487426	RAKOTOARIMANANA Rado Nirina Nomenjanahary	4G	932637	4G_200Go	49000	2025-02-26	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-02-12						49000			[]	2026-06-19 11:05:24.163459+00	2026-06-19 11:05:24.163462+00
274	FID-2026-00275	275	2026-02-12	Antanimena	Tino	489772	RAHARISON Harimbolatahina Luc	Airfiber	937211	Airfiber_Unlimited 50	149000	2025-04-15	Résiliation	Problème financier	Problème personnelle	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.163487+00	2026-06-19 11:05:24.16349+00
275	FID-2026-00276	276	2026-02-13	Antanimena	Tino	491980	ADRINAH AZIR AMED FATIMAH / ANDRIAMAMBOLA Fandresena Marie Mathie	4G	938854	4G_200Go	49000	2025-04-30	Résiliation	Problème financier	Problème personnelle	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.163516+00	2026-06-19 11:05:24.163519+00
276	FID-2026-00277	277	2026-02-13	Antanimena	Tino	34424	RATSIANDAVANA Alain Edgard	4G	228145	4G_512 Ko	169000	2014-07-02	Résiliation	Autres	Décès titulaire	Résiliation	Cloturé	2026-03-02		2026-02-28				0			[]	2026-06-19 11:05:24.163546+00	2026-06-19 11:05:24.163549+00
277	FID-2026-00278	278	2026-02-14	Antanimena	Nathalie	22477	ANDRIAMPARANY Vatosoa Vololonandriana	Airfiber	918748	Airfiber_Plus	189000	2021-04-19	Résiliation	Mobilité géographique	déménagemenet faratsiho	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.163574+00	2026-06-19 11:05:24.163577+00
278	FID-2026-00279	279	2026-02-16	Antanimena	Tino	231918	RAKOTOSALAMA Malanto Zaholisoa	Airfiber	941617	Airfiber_Unlimited 20	149000	2025-05-31	Résiliation	Insatisfaction	problème technique	Résiliation	En Attente	2026-03-30	Tino	2026-05-30				0			[]	2026-06-19 11:05:24.163605+00	2026-06-19 11:05:24.163608+00
279	FID-2026-00280	280	2026-02-16	Antanimena	Tino	32607	FJKM Betafo Fanavaozana	4G	218253	4G_512 Ko	169000	2014-06-10	Résiliation	Autres	Retraité	Résiliation	En Attente	2026-05-04	Anja	2026-07-31				0			[]	2026-06-19 11:05:24.163634+00	2026-06-19 11:05:24.163637+00
280	FID-2026-00281	281	2026-02-16	Antanimena	Fitiavana	437188	RANAIVOSON Herimiandrasoa José	4G	848022	4G_Gold	189000	2020-04-19	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.163662+00	2026-06-19 11:05:24.163665+00
281	FID-2026-00282	282	2026-02-16	Antanimena	Tino	475362	RAKOTOZAFY Faliarilala Vanessa	Airfiber	915015	Airfiber_First	149000	2024-07-10	Basculement	Autres	demande client	Basculement	Cloturé	2026-02-16				966369	Airfiber_Unlimited 30	149000		2026-02-16	[]	2026-06-19 11:05:24.16369+00	2026-06-19 11:05:24.163693+00
282	FID-2026-00283	283	2026-02-17	Masay	Tino	491487	RAKOTONIRINA Christian	4G	938165	4G_200Go	49000	2025-04-25	Résiliation	Insatisfaction		Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.163719+00	2026-06-19 11:05:24.163722+00
283	FID-2026-00284	284	2026-02-17	Antanimena	Nathalie	469524	RAMISARIMANGA Rinasoa Hasimboahangy	4G	939443	4G_500Go	99000	2025-05-06	Résiliation	Mobilité géographique	déménagement province	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.163747+00	2026-06-19 11:05:24.16375+00
284	FID-2026-00285	285	2026-02-17	Antanimena	Nathalie	487538	RIJA Prosper	4G	932790	4G_200Go	49000	2025-02-28	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.163776+00	2026-06-19 11:05:24.163779+00
285	FID-2026-00286	286	2026-02-17	Antanimena	Nathalie	512055	RAKOTOARIMANGA Faniriniaina Noely	4G	964551	4G_200Go	49000	2026-01-21	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.163805+00	2026-06-19 11:05:24.163808+00
286	FID-2026-00287	287	2026-02-18	Antanimena	Tino	491979	RANDRIAMIHARISOA Sedimanana Sylvain	4G	938851	4G_200Go	49000	2025-04-30	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.163833+00	2026-06-19 11:05:24.163836+00
287	FID-2026-00288	288	2026-02-18	Masay	Anja	488800	RAZAFINIRINA Volantantely Edith Louisiane Marie	4G	934480	4G_500Go	99000	2025-03-16	Résiliation	Mobilité géographique	déménagement	Résiliation	En Attente			2026-03-31				0			[]	2026-06-19 11:05:24.163861+00	2026-06-19 11:05:24.163864+00
288	FID-2026-00289	289	2026-02-18	Masay	Anja	362468	ANDRIANARISOA Haja	4G	934612	4G_500Go	0	2025-03-18	Basculement	Autres	annulation	Annulation	En Attente	2026-02-18				934612	4G_200Go	49000		2026-03-31	[]	2026-06-19 11:05:24.163889+00	2026-06-19 11:05:24.163892+00
289	FID-2026-00290	290	2026-02-19	Masay	Fitiavana	455298	Société. MADAMONITOR	4G	875799	4G_Gold	189000	2021-05-07	Résiliation	Mobilité géographique	départ utilisateur	Résiliation	En Attente		Anja	2026-05-30				0			[]	2026-06-19 11:05:24.163918+00	2026-06-19 11:05:24.16392+00
290	FID-2026-00291	291	2026-02-19	Antanimena	Nathalie	467707	RAKOTOMANANA Nomenjanahary Fabienne Prisca	Airfiber	938807	Airfiber_Unlimited 20	99000	2025-04-28	Résiliation	Problème financier	problème financier	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.163946+00	2026-06-19 11:05:24.163949+00
291	FID-2026-00292	292	2026-02-19	Antanimena	Nathalie	10165	ANDRIAMIFEHY Njakatahiry	4G	879872	4G_512 Ko	169000	2013-03-28	Résiliation	Problème financier	problème financier	Résiliation	Cloturé			2026-03-31				0			[]	2026-06-19 11:05:24.163974+00	2026-06-19 11:05:24.163977+00
292	FID-2026-00293	293	2026-02-19	Antanimena	Nathalie	485153	RANDRIANARISOA Harimbola Seraphin	Airfiber	929604	Airfiber_First	149000	2025-01-30	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-02-19						149000			[]	2026-06-19 11:05:24.164003+00	2026-06-19 11:05:24.164005+00
293	FID-2026-00294	294	2026-02-20	Antanimena	Nathalie	512599	RAHARIMALALA Anny Sandra	4G	965297	4G_200Go	49000	2026-01-31	Upgrade	Autres	demande client	Upgrade	Cloturé	2026-02-20				966612	4G_500Go	79000		2026-02-20	[]	2026-06-19 11:05:24.164031+00	2026-06-19 11:05:24.164033+00
294	FID-2026-00295	295	2026-02-23	Masay	Anja	488736	NOMEJANAHARY Volahavana Joanah	4G	934393	4G_200Go	49000	2025-03-14	Résiliation	Changement de projet		Refusée	Cloturé							49000			[]	2026-06-19 11:05:24.164059+00	2026-06-19 11:05:24.164062+00
295	FID-2026-00296	296	2026-02-23	Antanimena	Anja	491869	ANDRIAMBELOMANANTSIORY Tiana Christina /ANDRIAMBELONTSOA Hendrick Dano	4G	938707	4G_200Go	49000	2025-04-30	Résiliation	Mobilité géographique	déménagement à Ambatondrazaka	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.164087+00	2026-06-19 11:05:24.164094+00
296	FID-2026-00297	297	2026-02-23	Antanimena	Tino	488313	RAHARIFERA Tafitanirina Elia	4G	933849	4G_200Go	49000	2025-03-08	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-02-23						49000			[]	2026-06-19 11:05:24.164142+00	2026-06-19 11:05:24.164148+00
297	FID-2026-00298	298	2026-02-23	Antanimena	Tino	491280	RAMANANTSOA Anja Landiniala	4G	937893	4G_200Go	49000	2025-04-22	Résiliation	Changement de projet	changement de projet	Annulation	Cloturé	2026-04-22					4G_200Go	49000			[]	2026-06-19 11:05:24.164179+00	2026-06-19 11:05:24.164182+00
298	FID-2026-00299	299	2026-02-24	Masay	Anja	45201	HATRAIT ép GROLEAS Valérie Georgette Micheline	4G	258528	4G_512 Ko	169000	2015-08-25	Basculement	Autres		Basculement	Cloturé	2026-02-23				966849	Airfiber_Unlimited 30	169000		2026-02-24	[]	2026-06-19 11:05:24.16421+00	2026-06-19 11:05:24.164213+00
299	FID-2026-00300	300	2026-02-24	Antanimena	Tino	40264	RAJOELINA Yves Hugues	4G	718691	4G_Gold	189000	2019-07-29	Résiliation	Autres	décès titulaire	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.16424+00	2026-06-19 11:05:24.164243+00
300	FID-2026-00301	301	2026-02-24	Antanimena	Tino	50447	RANDRIANARISOA Sylvia Emmanuelle	4G	275624	4G_512 Ko	169000	2016-04-30	Résiliation	Problème financier	problème financier	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.164269+00	2026-06-19 11:05:24.164272+00
301	FID-2026-00302	302	2026-02-26	Masay	Anja	467692	RABENORO TSIORIHAMAMIANA Fanomezana / RAMANANTSOLOFO Maminirina Fabrice	Airfiber	938669	Airfiber_Unlimited 30	149000	2025-04-29	Résiliation	Insatisfaction	débit insuffisant	Résiliation	En Attente			2026-04-30				0			[]	2026-06-19 11:05:24.164298+00	2026-06-19 11:05:24.164301+00
302	FID-2026-00303	303	2026-02-26	Masay	Anja	493369	WEI Wenlu	Airfiber	940727	Airfiber_Unlimited 20	99000	2025-05-20	Résiliation	Autres	Non utilisation	Résiliation	En Attente			2026-05-30				0			[]	2026-06-19 11:05:24.164326+00	2026-06-19 11:05:24.164329+00
303	FID-2026-00304	304	2026-02-26	Antanimena	Tino	487592	RANDRIARIVOLA Michael	4G	932865	4G_500Go	99000	2025-02-28	Résiliation	Problème financier	Problème financier	Basculement	Cloturé	2026-02-27					4G_200Go	49000		2026-03-02	[]	2026-06-19 11:05:24.164355+00	2026-06-19 11:05:24.164357+00
304	FID-2026-00305	305	2026-02-26	Antanimena	Nathalie	499138	ANDRIANOMENJANAHARY Henri / ANDRIAMIHANTA née RASOARIVONY Rachelle	4G	950006	4G_200Go	49000	2025-08-28	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé			2026-02-28				0			[]	2026-06-19 11:05:24.164383+00	2026-06-19 11:05:24.164386+00
305	FID-2026-00306	306	2026-02-26	Antanimena	Tino	30389	RAZAFINJATOVO Aimé	4G	904041	4G_Prépayé	0	2023-11-02	Upgrade	Autres	demande client	Upgrade	Cloturé	2026-02-26				966983	4G_200Go	49000		2026-02-26	[]	2026-06-19 11:05:24.164412+00	2026-06-19 11:05:24.164415+00
306	FID-2026-00307	307	2026-02-26	Antanimena	Tino	45447	HANITRAMAHATRATRANIAINA Espérance Louisette	Airfiber	940945	Airfiber_Unlimited 20	99000	2025-05-22	Résiliation	Autres	Chômage	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.16444+00	2026-06-19 11:05:24.164443+00
307	FID-2026-00308	308	2026-02-26	Masay	Anja	467706	RAJAOFERA Anthony Stéphan Claude	Airfiber	939010	Airfiber_Unlimited 20	0	2025-05-02	Résiliation	Problème financier	problème financier	Annulation	Cloturé	2026-03-05	Anja				Airfiber_Unlimited 50	99000		2026-04-30	[]	2026-06-19 11:05:24.164469+00	2026-06-19 11:05:24.164472+00
308	FID-2026-00309	309	2026-02-27	Antanimena	Tino	494924	RAKOTOMAHEFA Ny Avo Hajaina	4G	945142	4G_200Go	49000	2025-07-01	Résiliation	Mobilité géographique	Bourse à l'étranger	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.164497+00	2026-06-19 11:05:24.1645+00
309	FID-2026-00310	310	2026-02-27	Antanimena	Nathalie	491579	ANDRIAMANALINARIVO Hery Nantenaina Henintsoa	4G	938290	4G_200Go	49000	2025-04-28	Résiliation	Autres	affectaction	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.164526+00	2026-06-19 11:05:24.164529+00
310	FID-2026-00311	311	2026-02-27	Antanimena	Nathalie	471896	RAKOTOMANGA Liva Heriniaina	4G	938127	4G_200Go	0	2025-04-25	Résiliation	Zone Non Couvert	Déménagement en ZNC	Annulation	Cloturé	2026-04-28	Tino					49000	RAKOTOMANGA Herintsoa Loavinaina		[]	2026-06-19 11:05:24.164555+00	2026-06-19 11:05:24.164558+00
311	FID-2026-00312	312	2026-02-27	Antanimena	Tino	491462	RANAIVOSON Tiana Harivelo Solondraibe	4G	938129	4G_200Go	49000	2025-04-25	Upgrade	Autres	demande client	Upgrade	Cloturé	2026-02-27				967116	4G_500Go	79000		2026-02-27	[]	2026-06-19 11:05:24.164583+00	2026-06-19 11:05:24.164586+00
312	FID-2026-00313	313	2026-02-27	Antanimena	Tino	22640	RAMASIARINORO Rodialisoa	4G	642600	4G_Gold	189000	2019-01-31	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé			2026-02-27				0			[]	2026-06-19 11:05:24.164614+00	2026-06-19 11:05:24.164617+00
313	FID-2026-00314	314	2026-02-28	Antanimena	Tino	478404	RATIARAY Rado Alain Patrick	4G	939512	4G_200Go	49000	2025-05-07	Résiliation	Problème financier	problème personnelle	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.164643+00	2026-06-19 11:05:24.164646+00
314	FID-2026-00315	315	2026-02-28	Antanimena	Tino	485735	RAKOTOARIMANGA Tinasoa Marcelin	4G	930406	4G_200Go	49000	2025-02-08	Résiliation	Insatisfaction	insatisfaction	Changement de Nom	Cloturé	2026-05-18						49000	RAKOTONDRAMANANA Fenosoa Sitraka Rolland		[]	2026-06-19 11:05:24.164671+00	2026-06-19 11:05:24.164674+00
315	FID-2026-00316	316	2026-02-28	Antanimena	Jessica	18640	RAKOTOMANGA Verohasina	4G	887957	4G_512 Ko	169000	2022-05-27	Résiliation	Insatisfaction	Insatisfaction téchnique	Résiliation	En Attente		Tino	2026-05-31				0			[]	2026-06-19 11:05:24.164703+00	2026-06-19 11:05:24.164706+00
316	FID-2026-00317	317	2026-03-02	Masay	Tino	68918	RATSIMANIVA Jackson Omer Elysé	4G	418451	4G_Gold	189000	2017-04-04	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-03-02						189000			[]	2026-06-19 11:05:24.164732+00	2026-06-19 11:05:24.164735+00
317	FID-2026-00318	318	2026-03-02	Antanimena	Tino	45566	RANDRIANAVONY Mihaja	4G	547981	4G_Gold	0	2018-03-30	Résiliation	Autres	annulation+basculement	Annulation	En Attente	2026-03-31					4G_500Go	99000		2026-03-31	[]	2026-06-19 11:05:24.16476+00	2026-06-19 11:05:24.164763+00
318	FID-2026-00319	319	2026-03-02	Antanimena	Tino	10236	RANDRIANASOLO Brigitte Lalasoa	4G	872123	4G_10Go	80000	2021-03-08	Downgrade	Autres	demande client	Downgrade	En Attente	2026-03-31					4G_200Go	49000		2026-03-31	[]	2026-06-19 11:05:24.164789+00	2026-06-19 11:05:24.164792+00
319	FID-2026-00320	320	2026-03-02	Antanimena	Tino	481789	ANDRIARIMALALA Ony Nomena Coralie	4G	942541	4G_200Go	49000	2025-06-02	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.164817+00	2026-06-19 11:05:24.16482+00
320	FID-2026-00321	321	2026-03-02	Masay	Tino	492717	ANDRIANASOLO Tojo Jean Tony	4G	941824	4G_200Go	49000	2025-05-29	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-05-31			4G_200Go	0			[]	2026-06-19 11:05:24.164846+00	2026-06-19 11:05:24.164849+00
321	FID-2026-00322	322	2026-03-02	Masay	Tino	513374	RAHARIMANANA Jean Christale	4G	966434	4G_200Go	49000	2026-02-18	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-03-02				966434	4G_200Go	49000			[]	2026-06-19 11:05:24.164875+00	2026-06-19 11:05:24.164877+00
322	FID-2026-00323	323	2026-03-02	Antanimena	Anja	494775	RANDRIAMAMPIANINA Aina Harinavalona	Airfiber	942656	Airfiber_Unlimited 50	149000	2025-06-03	Résiliation	Raison personnelle	débit insuffisant	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.164903+00	2026-06-19 11:05:24.164906+00
323	FID-2026-00324	324	2026-03-02	Antanimena	Anja	470758	RAKOTOARIVONY Annie Harimboahanginirina	4G	907505	4G_50Go	0	2024-03-27	Résiliation	Autres	annulation+basculement	Annulation	Cloturé	2026-03-02	Anja			967377	4G_500Go	79000		2026-03-02	[]	2026-06-19 11:05:24.164932+00	2026-06-19 11:05:24.164935+00
324	FID-2026-00325	325	2026-03-02	Antanimena	Anja	490115	RAKOTONDRAINIBE Miranantenaina Nathalie	4G	936206	4G_500Go	0	2025-04-05	Résiliation	Autres	annulation	Annulation	Cloturé	2026-03-02	Anja			936206	4G_200Go	49000		2026-04-05	[]	2026-06-19 11:05:24.164961+00	2026-06-19 11:05:24.164964+00
325	FID-2026-00326	326	2026-03-02	Antanimena	Anja	410776	RALAISANORO Sarobidinampoina Abraham	4G	914112	4G_200Go	99000	2024-06-26	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.16499+00	2026-06-19 11:05:24.164993+00
326	FID-2026-00327	327	2026-03-03	Masay	Tino	12360	OLGA	4G	872210	4G_Gold	0	2021-03-10	Résiliation	Autres	demande client	Annulation	Cloturé	2026-03-03					4G_500Go	99000		2026-03-31	[]	2026-06-19 11:05:24.165019+00	2026-06-19 11:05:24.165022+00
327	FID-2026-00328	328	2026-03-03	Masay	Tino	491734	RAKOTOSOAVINA Iaina	Airfiber	938555	Airfiber_Unlimited 20	0	2025-04-29	Résiliation	Changement de projet	Client gagnant lors de tombola du tirage au sort promo pack-avril25	Annulation	Cloturé	2026-04-30					Airfiber_Unlimited 50	99000	RAKOTOSON Tendrinirina Judicael	2026-04-30	[]	2026-06-19 11:05:24.165047+00	2026-06-19 11:05:24.16505+00
328	FID-2026-00329	329	2026-03-03	Masay	Jessica	437712	RABENJAARILALA Zolisoa	4G	853622	4G_Gold	189000	2020-05-29	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Tino	2026-05-31			4G_Gold	0			[]	2026-06-19 11:05:24.165076+00	2026-06-19 11:05:24.165079+00
329	FID-2026-00330	330	2026-03-03	Antanimena	Anja	467668	BEARIVONY Meja Felantsoa	Airfiber	909813	Airfiber_First	0	2024-05-02	Résiliation	Autres	annulation+basculement	Annulation	En Attente	2026-04-30	Anja			967576	Airfiber_Unlimited 50	99000		2026-04-30	[]	2026-06-19 11:05:24.165108+00	2026-06-19 11:05:24.165111+00
330	FID-2026-00331	331	2026-03-03	Antanimena	Anja	492487	FANOMEZANIARIVO Naftaly Tongatan/ RAMAROSON Rindra Diamondra	4G	939527	4G_500Go	99000	2025-05-07	Résiliation	Insatisfaction	débit insuffisant	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165166+00	2026-06-19 11:05:24.165171+00
331	FID-2026-00332	332	2026-03-03	Antanimena	Nathalie	43372	RANDRIAMITANDRINA Fanomezantsoa	4G	254094	4G_512 Ko	169000	2015-06-12	Résiliation	Mobilité géographique	départ	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.165197+00	2026-06-19 11:05:24.1652+00
332	FID-2026-00333	333	2026-03-03	Antanimena	Anja	505428	PAHIJATO TOLOJANAHARY Prisca	4G	955670	4G_200Go	49000	2025-10-18	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-03-03				955670	4G_200Go	49000			[]	2026-06-19 11:05:24.165226+00	2026-06-19 11:05:24.165229+00
333	FID-2026-00334	334	2026-03-03	Antanimena	Anja	487590	RASOANAIVO Mendrika	4G	932853	4G_200Go	49000	2025-02-28	Changement de Nom	Problème financier		Changement de Nom	Cloturé	2026-03-03				932853	4G_200Go	49000	RAZAFINDRAZAKA Giane Elisa	2025-02-28	[]	2026-06-19 11:05:24.165257+00	2026-06-19 11:05:24.16526+00
334	FID-2026-00335	335	2026-03-03	Antanimena	Anja	513683	ISSOUF EL Assad	4G	966883	4G_200Go	0	2026-02-24	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé	2026-03-31		2026-03-31				0			[]	2026-06-19 11:05:24.165287+00	2026-06-19 11:05:24.16529+00
335	FID-2026-00336	336	2026-03-04	Masay	Tino	485574	RANAIVOARISOA Lys Seheno	Airfiber	930172	Airfiber_First	0	2025-02-06	Basculement	Autres	demande client	Basculement	Cloturé	2026-03-04					Airfiber_Unlimited 30	149000		2026-03-04	[]	2026-06-19 11:05:24.165315+00	2026-06-19 11:05:24.165318+00
336	FID-2026-00337	337	2026-03-04	Masay	Tino	248169	ANDRIANASOLO Domohina noromalala	4G	646930	4G_Gold	189000	2019-02-14	Résiliation	Mobilité géographique	déménagement étranger	Résiliation	En Attente	2026-03-06	Tino	2026-05-31			4G_Gold	0			[]	2026-06-19 11:05:24.165343+00	2026-06-19 11:05:24.165346+00
337	FID-2026-00338	338	2026-03-04	Masay	Tino	484415	RAKOTONINDRIANA Gaston	4G	930561	4G_200Go	0	2025-02-10	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	En Attente			2026-03-31			4G_200Go	0			[]	2026-06-19 11:05:24.165372+00	2026-06-19 11:05:24.165375+00
338	FID-2026-00339	339	2026-03-04	Antanimena	Nathalie	493111	HARINTSOA Sylvia Joel	Airfiber	940399	Airfiber_Unlimited 50	149000	2025-05-16	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165401+00	2026-06-19 11:05:24.165404+00
339	FID-2026-00340	340	2026-03-04	Antanimena	Anja	43082	RAMBELOMANANA Lolona Ghislaine	4G	253331	4G_512 Ko	0	2015-06-02	Résiliation	Mobilité géographique	départ	Annulation	Cloturé	2026-03-04	Anja			967553	Airfiber_Unlimited 20	99000	RAMBELOMANANA Lolona Ghislaine	2026-03-04	[]	2026-06-19 11:05:24.16543+00	2026-06-19 11:05:24.165432+00
340	FID-2026-00341	341	2026-03-04	Antanimena	Nathalie	479344	ANDRIANANTENAINA John Rubis	4G	941827	4G_200Go	49000	2025-05-29	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165458+00	2026-06-19 11:05:24.165461+00
341	FID-2026-00342	342	2026-03-04	Antanimena	Nathalie	513015	RAKOTOARISOA Tolojanahary Olivier	4G	965929	4G_500Go	0	2026-02-13	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé	2026-03-31		2026-03-31				0			[]	2026-06-19 11:05:24.165486+00	2026-06-19 11:05:24.165489+00
342	FID-2026-00343	343	2026-03-05	Antanimena	Tino	473270	RANDRIAMIFIDY Annie Josepha	4G	939231	4G_500Go	99000	2025-05-05	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165516+00	2026-06-19 11:05:24.165519+00
343	FID-2026-00344	344	2026-03-05	Antanimena	Tino	513899	RAKOTOVAZAHA Sambatra Finoana Mendrika	4G	967227	4G_200Go	49000	2026-02-28	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé					967227	4G_200Go	49000			[]	2026-06-19 11:05:24.165545+00	2026-06-19 11:05:24.165547+00
344	FID-2026-00345	345	2026-03-05	Antanimena	Tino	487776	INJANAHARY Haja Henintsoa	4G	933102	4G_200Go	49000	2025-03-03	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente		Nathalie	2026-05-31				0			[]	2026-06-19 11:05:24.165573+00	2026-06-19 11:05:24.165576+00
345	FID-2026-00346	346	2026-03-05	Masay	Fitiavana	494072	RAMAROSON Maminiaina Sitraka	Airfiber	941686	Airfiber_Unlimited 20	99000	2025-05-27	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-05-31			Airfiber_Unlimited 20	0			[]	2026-06-19 11:05:24.165605+00	2026-06-19 11:05:24.165608+00
346	FID-2026-00347	347	2026-03-06	Antanimena	Nathalie	473475	RATOVONDRAINY Henri Johns	Airfiber	939693	Airfiber_Unlimited 20	149000	2025-05-09	Résiliation	Autres	Retraité	Résiliation	En Attente		Tino	2026-05-31				0			[]	2026-06-19 11:05:24.165633+00	2026-06-19 11:05:24.165636+00
347	FID-2026-00348	348	2026-03-06	Antanimena	Anja	514009	DJABOURY Chakrina / SOA ISSIHAKA Mounirah	4G	967380	4G_200Go	49000	2026-03-02	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé					967380	4G_200Go	49000			[]	2026-06-19 11:05:24.165662+00	2026-06-19 11:05:24.165665+00
348	FID-2026-00349	349	2026-03-06	Antanimena	Anja	467822	DRIVE 4 WARD KOREA / GHAFOOR Abdul	4G	900437	4G_85Go	149000	2023-05-15	Résiliation	Mobilité géographique	départ	Résiliation	En Attente		Nathalie	2026-05-31				0			[]	2026-06-19 11:05:24.16569+00	2026-06-19 11:05:24.165693+00
349	FID-2026-00350	350	2026-03-06	Antanimena	Anja	317272	Société. SOCIETE GROUPE AUXILIAIRE	4G	896574	4G_Gold	189000	2022-12-01	Basculement	Problème financier		Basculement	En Attente	2026-03-31				969413	4G_500Go	99000		2026-03-31	[]	2026-06-19 11:05:24.165719+00	2026-06-19 11:05:24.165722+00
350	FID-2026-00351	351	2026-03-06	Antanimena	Tino	490662	RAZANABOLOLONA Tianna	4G	937151	4G_200Go	49000	2025-04-15	Résiliation	Insatisfaction		Refusée	Cloturé					937151	4G_200Go	49000			[]	2026-06-19 11:05:24.165747+00	2026-06-19 11:05:24.16575+00
351	FID-2026-00352	352	2026-03-06	Antanimena	Nathalie	482373	RAKOTONATREHANA Ankasitrahana Telina	4G	928205	4G_200Go	49000	2025-01-10	Changement de Nom	Problème financier		Changement de Nom	Cloturé	2026-03-06	Nathalie			928205	4G_200Go	49000	RAKOTOARIMANANA Tsiazonangoly Larinà	2025-01-10	[]	2026-06-19 11:05:24.165775+00	2026-06-19 11:05:24.165778+00
352	FID-2026-00353	353	2026-03-06	Antanimena	Tino	494996	RASOLOARIJAONA Andry Malalatiana Nina Clara	4G	942904	4G_200Go	49000	2025-06-06	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165803+00	2026-06-19 11:05:24.165806+00
353	FID-2026-00354	354	2026-03-06	Antanimena	Nathalie	462952	Société. ASSOCIATION DES FEMMES HANDICAPEES DE MADAGASCAR	Airfiber	910716	Airfiber_Plus	189000	2024-05-10	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165831+00	2026-06-19 11:05:24.165834+00
354	FID-2026-00355	355	2026-03-06	Antanimena	Tino	6745	RAMAROVELO Hajaniaina Andry	4G	942235	4G_200Go	49000	2025-05-31	Résiliation	Insatisfaction	débit insuffisant	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165859+00	2026-06-19 11:05:24.165862+00
355	FID-2026-00356	356	2026-03-06	Masay	Fitiavana	490273	ANDRIANTSOA Ainanirina	4G	936413	4G_500Go	99000	2025-04-08	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-03-06					4G_500Go	99000			[]	2026-06-19 11:05:24.165888+00	2026-06-19 11:05:24.16589+00
356	FID-2026-00357	357	2026-03-07	Antanimena	Anja	493250	ANDRIANARIVO Sabine Larissa	4G	940568	4G_200Go	49000	2025-05-17	Résiliation	Double emploi		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165916+00	2026-06-19 11:05:24.165919+00
357	FID-2026-00358	358	2026-03-07	Antanimena	Tino	488984	RAZAFIMANANTSOA Nivolalao Nadia	Airfiber	934726	Airfiber_First	99000	2025-03-20	Basculement	Autres		Basculement	Cloturé	2026-03-07				968397	Airfiber_Unlimited 20	99000		2026-03-07	[]	2026-06-19 11:05:24.165944+00	2026-06-19 11:05:24.165947+00
358	FID-2026-00359	359	2026-03-07	Antanimena	Anja	28123	RANAIVO Roger Eric	4G	940847	4G_200Go	49000	2025-05-21	Résiliation	Insatisfaction	lenteur débit	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.165971+00	2026-06-19 11:05:24.165974+00
359	FID-2026-00360	360	2026-03-09	Masay	Tino	472919	RASONARIVO Rihatiana Harson	Airfiber	910946	Airfiber_First	149000	2024-05-14	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Fitiavana	2026-05-31			Airfiber_First	0			[]	2026-06-19 11:05:24.165999+00	2026-06-19 11:05:24.166002+00
360	FID-2026-00361	361	2026-03-09	Antanimena	Anja	489681	RAKOTOMALALA Rivo Roland	4G	944919	4G_200Go	49000	2025-06-28	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.166027+00	2026-06-19 11:05:24.16603+00
361	FID-2026-00362	362	2026-03-09	Antanimena	Anja	35323	RABARISON Mamitiana	Airfiber	921478	Airfiber_Plus	189000	2024-10-22	Basculement	Autres		Basculement	Cloturé	2026-03-09				967946	Airfiber_Unlimited 30	189000		2026-03-09	[]	2026-06-19 11:05:24.166055+00	2026-06-19 11:05:24.166058+00
362	FID-2026-00363	363	2026-03-09	Antanimena	Anja	494820	RAKOTOARISOA Tanjonirina Jacob	Airfiber	942693	Airfiber_Unlimited 20	99000	2025-06-04	Résiliation	Mobilité géographique	départ	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.166087+00	2026-06-19 11:05:24.16609+00
363	FID-2026-00364	364	2026-03-09	Antanimena	Anja	496365	LO HIVE NAM Florence	4G	944644	4G_200Go	49000	2025-06-27	Résiliation	Autres	retraité	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.166141+00	2026-06-19 11:05:24.166147+00
364	FID-2026-00365	365	2026-03-09	Antanimena	Tino	494670	RAKOTOMALALA Mandrindra Fanambinana	4G	942488	4G_200Go	49000	2025-06-02	Résiliation	Changement de projet		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166176+00	2026-06-19 11:05:24.166179+00
365	FID-2026-00366	366	2026-03-09	Masay	Fitiavana	446411	RAMBELOSON Irène Marie Claude	4G	860427	4G_Gold	189000	2020-07-31	Résiliation	Mobilité géographique	Déménagement en ZNC	Résiliation	En Attente			2026-04-30			4G_Gold	0			[]	2026-06-19 11:05:24.166206+00	2026-06-19 11:05:24.166209+00
366	FID-2026-00367	367	2026-03-10	Masay	Fitiavana	480535	RAHARISON Haingo Arimalala	4G	922976	4G_Litebox 50Go	0	2024-11-11	Basculement	Problème financier	Retenue recouvrement	Basculement	Cloturé	2026-03-10					4G_500Go	79000		2026-03-31	[]	2026-06-19 11:05:24.166234+00	2026-06-19 11:05:24.166238+00
367	FID-2026-00368	368	2026-03-10	Masay	Fitiavana	50630	RAJASMINA Marie Claudia Fanja	4G	276422	4G_512 Ko	0	2016-05-14	Résiliation	Changement de projet	annulation résiliation + basculement	Annulation	En Attente	2026-05-09					4G_500Go	79000		2026-05-31	[]	2026-06-19 11:05:24.166263+00	2026-06-19 11:05:24.166266+00
368	FID-2026-00369	369	2026-03-10	Antanimena	Tino	492713	RANDRIAMBOAVONJY Lantsaniaina Fannya	4G	939844	4G_200Go	49000	2025-05-10	Résiliation	Changement de projet		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166292+00	2026-06-19 11:05:24.166295+00
369	FID-2026-00370	370	2026-03-10	Antanimena	Tino	493477	RAMAMONJISOA Fanjamalala Andriamasinoro	4G	940878	4G_200Go	49000	2025-05-21	Résiliation	Insatisfaction	lenteur débit	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166321+00	2026-06-19 11:05:24.166324+00
370	FID-2026-00371	371	2026-03-10	Antanimena	Tino	10354	HUGUET Née RAKOTONIAINA Annah	4G	884197	4G_512 Ko	169000	2011-04-19	Résiliation	Autres	problème santé	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.166349+00	2026-06-19 11:05:24.166352+00
371	FID-2026-00372	372	2026-03-10	Antanimena	Tino	474804	TANG Rhoni Joel	Airfiber	939760	Airfiber_Unlimited 20	149000	2025-05-09	Résiliation	Problème financier		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166378+00	2026-06-19 11:05:24.166381+00
372	FID-2026-00373	373	2026-03-11	Masay	Fitiavana	511153	RAKOTOARIVELO Miarilala Andry Toky	4G	963287	4G_200Go	49000	2025-12-30	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-03-11					4G_200Go	49000			[]	2026-06-19 11:05:24.166407+00	2026-06-19 11:05:24.16641+00
373	FID-2026-00374	374	2026-03-11	Masay	Fitiavana	493387	RAZAFIMANANTSOA Maminiriana Robinson/ RAZAFIMANANTSOA Mamy Nantenaina	4G	940748	4G_500Go	0	2025-05-20	Résiliation	Changement de projet	annulation résiliation+basculement	Annulation	Cloturé	2026-05-22	Anja				4G_1T	99000		2026-05-22	[]	2026-06-19 11:05:24.166436+00	2026-06-19 11:05:24.166439+00
374	FID-2026-00375	375	2026-03-11	Antanimena	Tino	24177	RASOANARIMALALA Harimanana	Airfiber	940890	Airfiber_Unlimited 30	189000	2025-05-21	Résiliation	Autres	retraité	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166464+00	2026-06-19 11:05:24.166467+00
375	FID-2026-00376	376	2026-03-12	Masay	Fitiavana	13651	RAKOTOMALALA Faralahinirina Pierrot	4G	631389	4G_Gold	189000	2018-12-31	Résiliation	Insatisfaction	Service envoi facture automatique et arrêt TV	Refusée	Cloturé	2026-03-12					4G_Gold	189000			[]	2026-06-19 11:05:24.166492+00	2026-06-19 11:05:24.166495+00
376	FID-2026-00377	377	2026-03-12	Antanimena	Tino	12401	RAKOTONDRABE ANDRIAMAHAY Fidy Ratsiivaina	4G	889166	4G_512 Ko	169000	2022-07-19	Résiliation	Autres	Cessation d'activité	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.166521+00	2026-06-19 11:05:24.166524+00
377	FID-2026-00378	378	2026-03-12	Antanimena	Tino	492760	RAMAHOLISON Rivosoa Koloina Mariella	4G	939901	4G_200Go	49000	2025-05-11	Résiliation	Changement de projet		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166552+00	2026-06-19 11:05:24.166555+00
378	FID-2026-00379	379	2026-03-12	Antanimena	Anja	514376	IMAMOU Ali	4G	967866	4G_200Go	0	2026-03-07	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé	2026-03-12		2026-03-12				0			[]	2026-06-19 11:05:24.16658+00	2026-06-19 11:05:24.166583+00
379	FID-2026-00380	380	2026-03-13	Antanimena	Anja	493889	RASOANASOLO Harimanana	4G	941417	4G_200Go	49000	2025-05-24	Résiliation	Changement de projet		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166611+00	2026-06-19 11:05:24.166613+00
380	FID-2026-00381	381	2026-03-13	Masay	Jessica	497399	RAMIARISOLOSON Manda Herivelo	4G	946033	4G_200Go	49000	2025-07-11	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Fitiavana	2026-07-31			4G_200Go	0			[]	2026-06-19 11:05:24.166639+00	2026-06-19 11:05:24.166642+00
381	FID-2026-00382	382	2026-03-13	Masay	Fitiavana	471882	ANDRIAMPANJAVA Jacob Félicien	4G	909387	4G_50Go	0	2024-04-29	Basculement	Autres	Retenue recouvrement	Basculement	Cloturé	2026-03-13				968189	4G_500Go	79000		2026-03-13	[]	2026-06-19 11:05:24.166667+00	2026-06-19 11:05:24.16667+00
382	FID-2026-00383	383	2026-03-14	Antanimena	Tino	497097	HAMADIMBY Lespoir Jean Nicaisse	Airfiber	945674	Airfiber_Unlimited 50	149000	2025-07-07	Résiliation	Insatisfaction		Résiliation	En Attente	2026-05-05	Jessica	2026-07-31				0			[]	2026-06-19 11:05:24.166697+00	2026-06-19 11:05:24.1667+00
383	FID-2026-00384	384	2026-03-14	Antanimena	Tino	463359	RAHARISOA Mamison Evelyne	4G	939613	4G_200Go	49000	2025-05-08	Résiliation	Insatisfaction		Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.166726+00	2026-06-19 11:05:24.166729+00
384	FID-2026-00385	385	2026-03-14	Antanimena	Tino	426597	RASOAMBOLANORO	4G	835231	4G_Gold	189000	2020-03-14	Basculement	Autres	demande client	Basculement	Cloturé	2026-03-16				968331	4G_500Go	99000		2026-03-16	[]	2026-06-19 11:05:24.166755+00	2026-06-19 11:05:24.166758+00
385	FID-2026-00386	386	2026-03-16	Antanimena	Fitiavana	473483	RANDRIANARIVELO Patricia Georgette	Airfiber	911961	Airfiber_First	149000	2024-05-28	Résiliation	Problème financier	problème financier	Résiliation	En Attente		Anja	2026-05-31				0			[]	2026-06-19 11:05:24.166784+00	2026-06-19 11:05:24.166787+00
386	FID-2026-00387	387	2026-03-16	Antanimena	Anja	450906	RANAIVOSOA Julien Sombiniaina	4G	905943	4G_50Go	99000	2024-01-31	Basculement	Autres	data insuffisant	Basculement	Cloturé	2026-03-31				969432	4G_500Go	99000		2026-03-31	[]	2026-06-19 11:05:24.166813+00	2026-06-19 11:05:24.166816+00
387	FID-2026-00388	388	2026-03-16	Antanimena	Anja	11068	RAHAMALIARISON Hanitrarivelo Oliva	4G	939664	4G_200Go	49000	2025-05-07	Résiliation	Autres	double emploi	Refusée	Cloturé	2026-03-16				939664	4G_200Go	49000			[]	2026-06-19 11:05:24.166842+00	2026-06-19 11:05:24.166844+00
388	FID-2026-00389	389	2026-03-16	Masay	Fitiavana	30143	RAJAONERA Malalaniaina	4G	766622	4G_Gold	189000	2019-11-19	Résiliation	Mobilité géographique	Déménagement à l'étranger	Résiliation	En Attente		Tino	2026-05-31			4G_Gold	0			[]	2026-06-19 11:05:24.16687+00	2026-06-19 11:05:24.166873+00
389	FID-2026-00390	390	2026-03-16	Masay	Fitiavana	440426	Société. SOS VILLAGES D'ENFANTS	4G	851924	4G_Gold	0	2020-05-16	Basculement	Autres	bande 20	Basculement	Cloturé	2026-03-16	Tino				Airfiber_Unlimited 30	189000		2026-03-16	[]	2026-06-19 11:05:24.166899+00	2026-06-19 11:05:24.166901+00
390	FID-2026-00391	391	2026-03-16	Masay	Tino	303192	RASOLOTSIATOSIKINIAINA Jussy Marceinnie Katia	Airfiber	919453	Airfiber_Plus	189000	2019-06-22	Résiliation	Mobilité géographique	Déménagement	Résiliation	En Attente			2026-06-30			Airfiber_Plus	0			[]	2026-06-19 11:05:24.166927+00	2026-06-19 11:05:24.16693+00
391	FID-2026-00392	392	2026-03-17	Antanimena	Tino	492079	RAJAONARISON Tafita Mampionona	4G	938989	4G_500Go	99000	2025-05-02	Résiliation	Changement de projet		Refusée	Cloturé	2026-03-17				938989	4G_500Go	99000			[]	2026-06-19 11:05:24.166956+00	2026-06-19 11:05:24.166959+00
392	FID-2026-00393	393	2026-03-17	Antanimena	Anja	29698	BEZOKINY Iris Jacky	4G	613756	4G_Gold	0	2018-11-20	Basculement	Autres	Couplage 4G	Basculement	Cloturé	2026-03-17				968433	Airfiber_Unlimited 30	189000		2026-03-17	[]	2026-06-19 11:05:24.166985+00	2026-06-19 11:05:24.166988+00
393	FID-2026-00394	394	2026-03-18	Masay	Tino	471041	RAVOKATRA Fenoharimina Akim/ RAKOTOARILALA Rina Danielle	Airfiber	907995	Airfiber_Plus	189000	2024-04-08	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-04-18				907995	Airfiber_Plus	189000			[]	2026-06-19 11:05:24.167013+00	2026-06-19 11:05:24.167016+00
394	FID-2026-00395	395	2026-03-18	Antanimena	Anja	443807	ANDRIAMIJORO Harinivoson Mino	4G	855955	4G_Gold	189000	2020-06-20	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167042+00	2026-06-19 11:05:24.167045+00
395	FID-2026-00396	396	2026-03-18	Antanimena	Anja	492759	ANDRIAMIARISOA Mialy Sarobidy/ SAROBIDY Jules Hortencia	4G	939900	4G_200Go	49000	2025-05-11	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-03-18				939900	4G_200Go	49000			[]	2026-06-19 11:05:24.167071+00	2026-06-19 11:05:24.167074+00
396	FID-2026-00397	397	2026-03-19	Masay	Tino	28760	LAMBERT FIALAMBOLY	Airfiber	944713	Airfiber_Unlimited 50	249000	2025-06-30	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167103+00	2026-06-19 11:05:24.167107+00
397	FID-2026-00398	398	2026-03-19	Antanimena	Anja	470090	Tanya Fashion Infinity/ RABAKONIRINA Faniritsoa Tanya	Airfiber	914866	Airfiber_First	149000	2024-07-08	Résiliation	Mobilité géographique	déménagement	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.167159+00	2026-06-19 11:05:24.167164+00
398	FID-2026-00399	399	2026-03-19	Antanimena	Anja	482203	ANTSAHIDY Raissa	4G	940640	4G_200Go	49000	2025-05-19	Résiliation	Mobilité géographique	Déménagement ZNC	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.167229+00	2026-06-19 11:05:24.167235+00
399	FID-2026-00400	400	2026-03-19	Antanimena	Anja	473291	Société. AGENCE DE VOYAGE DUN HUANG	4G	911693	4G_Litebox 50Go	99000	2024-05-23	Résiliation	Autres	changement d'opérateur telma	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.167262+00	2026-06-19 11:05:24.167265+00
400	FID-2026-00401	401	2026-03-19	Antanimena	Anja	493115	RAJERISON Gabriel Jean Luc / JAONARIVELO Angelo	4G	940410	4G_200Go	49000	2025-05-16	Résiliation	Insatisfaction	mauvaise réception	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.167292+00	2026-06-19 11:05:24.167295+00
401	FID-2026-00402	402	2026-03-21	Antanimena	Anja	495734	RASOLOFONANAHARY Benjamin Radonirina	Airfiber	943833	Airfiber_Unlimited 20	99000	2025-06-17	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167321+00	2026-06-19 11:05:24.167324+00
402	FID-2026-00403	403	2026-03-23	Masay	Fitiavana	8688	RAKOTOJAONA Antonin Jacques	Airfiber	914237	Airfiber_Plus	169000	2012-11-14	Résiliation	Autres	Utilisateur réduit	Refusée	Cloturé	2026-03-23					Airfiber_Plus	169000			[]	2026-06-19 11:05:24.167469+00	2026-06-19 11:05:24.167477+00
403	FID-2026-00404	404	2026-03-23	Masay	Fitiavana	487146	RAHELIARINIVO Sabine	Airfiber	944145	Airfiber_Unlimited 50	149000	2025-06-14	Résiliation	Changement de projet	changement de projet	Annulation	Cloturé	2026-05-20	Tino			944195	Airfiber_Unlimited 50	99000		2026-07-01	[]	2026-06-19 11:05:24.167505+00	2026-06-19 11:05:24.167508+00
404	FID-2026-00405	405	2026-03-23	Antanimena	Anja	495803	RASOLONIAINA Martine	Airfiber	943929	Airfiber_Unlimited 20	99000	2025-06-19	Résiliation	Mobilité géographique	Déménagement ZNC	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167534+00	2026-06-19 11:05:24.167538+00
405	FID-2026-00406	406	2026-03-23	Antanimena	Tino	125486	RAVELOJAONA Patricia	4G	878072	4G_Gold	189000	2021-07-03	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167564+00	2026-06-19 11:05:24.167567+00
406	FID-2026-00407	407	2026-03-23	Antanimena	Tino	484162	RANTOANINA Narimiandratiana Mahefatahina	4G	928345	4G_200Go	49000	2025-01-13	Upgrade	Autres	data insuffisant	Upgrade	Cloturé	2026-03-23				968853	4G_500Go	79000		2026-03-23	[]	2026-06-19 11:05:24.167593+00	2026-06-19 11:05:24.167596+00
407	FID-2026-00408	408	2026-03-23	Antanimena	Tino	493755	RAJAONAH Carole	4G	943601	4G_200Go	49000	2025-06-14	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.167623+00	2026-06-19 11:05:24.167626+00
408	FID-2026-00409	409	2026-03-23	Antanimena	Tino	493755	RAJAONAH Carole	4G	941242	4G_200Go	49000	2025-05-24	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.167652+00	2026-06-19 11:05:24.167655+00
409	FID-2026-00410	410	2026-03-23	Antanimena	Anja	514518	RAZOELINIRINA Sarah Annick	4G	968058	4G_200Go	0	2026-03-11	Résiliation	Zone Non Couvert	réseau 4G saturé après intervention	Résiliation	Cloturé	2026-03-23		2026-03-23				0			[]	2026-06-19 11:05:24.167681+00	2026-06-19 11:05:24.167683+00
410	FID-2026-00411	411	2026-03-23	Masay	Fitiavana	24635	ANDRIANTSONINA Ihantavololona	Airfiber	941115	Airfiber_Unlimited 20	0	2025-05-23	Résiliation	Autres	Annulation	Basculement	En Attente	2026-05-23				941115	Airfiber_Unlimited 20	99000		2026-05-23	[]	2026-06-19 11:05:24.167709+00	2026-06-19 11:05:24.167712+00
411	FID-2026-00412	412	2026-03-24	Masay	Fitiavana	493938	RATOVONJANAHARY Harivelo Larousso/ RAHELIARISOA Fanjaniaina	4G	941470	4G_200Go	49000	2025-05-24	Résiliation	Mobilité géographique	Déménagement ZNC	Résiliation	En Attente			2026-05-31			4G_200Go	0			[]	2026-06-19 11:05:24.167738+00	2026-06-19 11:05:24.167741+00
438	FID-2026-00439	439	2026-03-31	Masay	Fitiavana	470773	RAOELINA Henintsoa / RAZAIARIMALALA Adeline	4G	949562	4G_200Go	49000	2025-08-19	Résiliation	Insatisfaction	Débit	Refusée	Cloturé	2026-03-31					4G_200Go	49000			[]	2026-06-19 11:05:24.168656+00	2026-06-19 11:05:24.168658+00
412	FID-2026-00413	413	2026-03-24	Masay	Fitiavana	493576	RATOVONJANAHARY Harivelo Larousso	4G	941008	4G_200Go	49000	2025-05-22	Résiliation	Mobilité géographique	Déménagement ZNC	Résiliation	En Attente			2026-05-31			4G_200Go	0			[]	2026-06-19 11:05:24.167766+00	2026-06-19 11:05:24.167769+00
413	FID-2026-00414	414	2026-03-24	Antanimena	Tino	492831	RANDRIAMANANJARA Heritiana Mickael	Airfiber	939998	Airfiber_Unlimited 50	149000	2025-05-12	Résiliation	Problème financier	problème financier	Upgrade	Cloturé	2026-04-27				971048	Airfiber_Unlimited 20	149000		2026-05-04	[]	2026-06-19 11:05:24.167795+00	2026-06-19 11:05:24.167798+00
414	FID-2026-00415	415	2026-03-24	Antanimena	Tino	10013	RAKOTONDRABE Joshua Miary	4G	912095	4G_Litebox 50Go	99000	2024-05-31	Résiliation	Mobilité géographique	Déménagement ZNC	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.167824+00	2026-06-19 11:05:24.167827+00
415	FID-2026-00416	416	2026-03-25	Masay	Fitiavana	494856	ANDRIAMALALA Mendrika Mitantsoa	4G	942745	4G_500Go	99000	2025-06-04	Résiliation	Insatisfaction	Emplacement	Résiliation	En Attente			2026-05-31			4G_500Go	0			[]	2026-06-19 11:05:24.167852+00	2026-06-19 11:05:24.167855+00
416	FID-2026-00417	417	2026-03-26	Masay	Fitiavana	467927	RAKOTONIALY Aroniaina Donovan	Airfiber	942854	Airfiber_Unlimited 30	0	2025-06-05	Résiliation	Autres	Annulation	Basculement	En Attente	2026-06-30					Airfiber_Unlimited 50	99000		2026-06-30	[]	2026-06-19 11:05:24.16788+00	2026-06-19 11:05:24.167883+00
417	FID-2026-00418	418	2026-03-26	Masay	Tino	462214	RABODOHASINA Heriniaina Tinasoa	4G	941716	4G_Litebox 200Go	49000	2025-05-28	Résiliation	Autres	Basculement prepaid	Basculement	En Attente			2026-05-31			4G_Litebox Prépayé	0		2026-05-31	[]	2026-06-19 11:05:24.167909+00	2026-06-19 11:05:24.167912+00
418	FID-2026-00419	419	2026-03-26	Antanimena	Tino	457867	BEARISOA Harimalala Minah	4G	954800	4G_500Go	99000	2025-10-14	Basculement	Zone Non Couvert	mauvaise réception	Basculement	Cloturé	2026-03-26				969045	Airfiber_Unlimited 20	99000		2026-03-26	[]	2026-06-19 11:05:24.167937+00	2026-06-19 11:05:24.16794+00
419	FID-2026-00420	420	2026-03-26	Antanimena	Anja	473847	ROCHEDEREUX Guillaume Paul	Airfiber	944370	Airfiber_Unlimited 50	0	2025-06-24	Résiliation	Autres	annulation+basculement	Annulation	En Attente	2026-06-30				944370	Airfiber_Unlimited 50	99000		2026-06-30	[]	2026-06-19 11:05:24.167966+00	2026-06-19 11:05:24.167969+00
420	FID-2026-00421	421	2026-03-26	Antanimena	Tino	456126	Société. SAFIDI SARLU	Airfiber	899645	Airfiber_Plus	189000	2023-04-06	Résiliation	Problème financier	problème financier	Basculement	Cloturé	2026-03-26				969140	Airfiber_Unlimited 30	189000		2026-03-26	[]	2026-06-19 11:05:24.167994+00	2026-06-19 11:05:24.167997+00
421	FID-2026-00422	422	2026-03-27	Antanimena	Tino	69852	M GEMS & MINERAUX SARL	4G	424434	4G_512 Ko	169000	2017-04-24	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-03-27				424434	4G_512 Ko	169000			[]	2026-06-19 11:05:24.168023+00	2026-06-19 11:05:24.168026+00
422	FID-2026-00423	423	2026-03-27	Antanimena	Tino	8701	MAMODHOUSSEN Hamza	4G	900919	4G_85Go	149000	2023-06-08	Résiliation	Insatisfaction	insatisfaction technique	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.168052+00	2026-06-19 11:05:24.168055+00
423	FID-2026-00424	424	2026-03-27	Antanimena	Anja	514737	RANDRIAMIARISOA Tsiorimampionina Fitahiana	4G	968352	4G_200Go	0	2026-03-16	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé	2026-03-27	Tino	2026-03-27				0			[]	2026-06-19 11:05:24.168081+00	2026-06-19 11:05:24.168084+00
424	FID-2026-00425	425	2026-03-27	Antanimena	Tino	488543	FIDIZARA Asmi / RAZAKAKELY Olivier	4G	934140	4G_500Go	0	2025-03-11	Basculement	Insatisfaction	Basculement en Unlimited	Basculement	Cloturé	2026-03-27				969115	Airfiber_Unlimited 50	99000		2026-03-27	[]	2026-06-19 11:05:24.168116+00	2026-06-19 11:05:24.168144+00
425	FID-2026-00426	426	2026-03-27	Antanimena	Tino	473959	RAFAMATANANTSOA Temitra Fiaro	4G	912718	4G_200Go	99000	2024-06-08	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.168178+00	2026-06-19 11:05:24.168182+00
426	FID-2026-00427	427	2026-03-27	Antanimena	Jessica	49858	RASOLOSOA Hanitriniaina Elise	Airfiber	888236	Airfiber_Plus	189000	2022-06-03	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente		Tino	2026-05-31				0			[]	2026-06-19 11:05:24.168209+00	2026-06-19 11:05:24.168212+00
427	FID-2026-00428	428	2026-03-27	Antanimena	Fitiavana	11659	RAVAOARISOA Marie Jocelyne	4G	854696	4G_Gold	189000	2020-06-08	Résiliation	Mobilité géographique	départ	Résiliation	En Attente		Tino	2026-06-30				0			[]	2026-06-19 11:05:24.168239+00	2026-06-19 11:05:24.168242+00
428	FID-2026-00429	429	2026-03-27	Masay	Fitiavana	501928	SALVY Christophe /MALALANIAINA Salvy Rianà	4G	951956	4G_500Go	99000	2025-09-20	Résiliation	Problème financier	Problème financier	Refusée	Cloturé	2026-03-27					4G_500Go	99000			[]	2026-06-19 11:05:24.168268+00	2026-06-19 11:05:24.168271+00
429	FID-2026-00430	430	2026-03-27	Masay	Fitiavana	484309	RAKOTOSEHENO Andry Nomenjanahary	4G	928522	4G_500Go	99000	2025-01-15	Basculement	Autres	Basculement	Basculement	Cloturé	2026-03-27				969142	Airfiber_Unlimited 20	99000		2026-03-27	[]	2026-06-19 11:05:24.168297+00	2026-06-19 11:05:24.1683+00
430	FID-2026-00431	431	2026-03-30	Antanimena	Anja	493397	Faniry Fanomezantsoa	4G	940761	4G_200Go	49000	2025-05-20	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-03-30						49000			[]	2026-06-19 11:05:24.168326+00	2026-06-19 11:05:24.168329+00
431	FID-2026-00432	432	2026-03-30	Antanimena	Tino	7326	Cabinet Afine NY HAVANA	4G	862588	4G_512 Ko	169000	2012-04-10	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-03-30						169000			[]	2026-06-19 11:05:24.168356+00	2026-06-19 11:05:24.168359+00
432	FID-2026-00433	433	2026-03-30	Antanimena	Jessica	443490	RATOVONONY Jean	4G	855563	4G_Gold	189000	2020-06-16	Résiliation	Insatisfaction	arrêt TV	Résiliation	Cloturé		Anja	2026-06-30				0			[]	2026-06-19 11:05:24.168384+00	2026-06-19 11:05:24.168387+00
433	FID-2026-00434	434	2026-03-30	Masay	Fitiavana	494568	ANDRIAMIRADO Onjatiana	Airfiber	942350	Airfiber_Unlimited 20	0	2025-05-31	Résiliation	Autres	annulation+basculement	Annulation	En Attente	2026-05-31					Airfiber_Unlimited 50	99000		2026-05-31	[]	2026-06-19 11:05:24.168413+00	2026-06-19 11:05:24.168415+00
434	FID-2026-00435	435	2026-03-30	Masay	Fitiavana	494933	RANDRIANAIVO Mamy	Airfiber	942860	Airfiber_Unlimited 20	99000	2025-06-05	Résiliation	Insatisfaction	changement d'opérateur starlink	Résiliation	En Attente			2026-06-30			Airfiber_Unlimited 20	0			[]	2026-06-19 11:05:24.168441+00	2026-06-19 11:05:24.168444+00
435	FID-2026-00436	436	2026-03-30	Masay	Fitiavana	475177	RAHAINGOARIMANANA Faramboahirana Clara	4G	914747	4G_200Go	99000	2024-07-05	Résiliation	Insatisfaction	problème technique	Résiliation	En Attente			2026-06-30			4G_200Go	0			[]	2026-06-19 11:05:24.16847+00	2026-06-19 11:05:24.168473+00
436	FID-2026-00437	437	2026-03-31	Masay	Fitiavana	223893	RAVELONANOSY Née Catein Annie Chantal	Airfiber	943299	Airfiber_Unlimited 20	149000	2025-06-30	Résiliation	Insatisfaction	Débit et coût	Résiliation	En Attente			2026-06-30			Airfiber_Unlimited 20	0			[]	2026-06-19 11:05:24.168498+00	2026-06-19 11:05:24.168501+00
437	FID-2026-00438	438	2026-03-31	Masay	Fitiavana	474400	ANDRIANAIVOARISOA Davida / RAZAFITSIORY Bodomalala Louise	4G	913356	4G_200Go	0	2024-06-17	Résiliation	Autres	Retenue recouvrement	Basculement	Cloturé	2026-03-31				913356	4G_200Go	49000		2026-03-31	[]	2026-06-19 11:05:24.16862+00	2026-06-19 11:05:24.168626+00
439	FID-2026-00440	440	2026-03-31	Antanimena	Tino	490522	RAZANADRAVAO Mirana Célestine	4G	936913	4G_500Go	99000	2025-04-12	Résiliation	Insatisfaction	Débit	Refusée	Cloturé	2026-03-31				936913	4G_500Go	99000			[]	2026-06-19 11:05:24.168685+00	2026-06-19 11:05:24.168688+00
440	FID-2026-00441	441	2026-03-31	Antanimena	Anja	23908	RAVELOJAONA Françoise Lydia	4G	881474	4G_512 Ko	0	2021-10-21	Résiliation	Autres	Décès titulaire contrat	Résiliation	Cloturé	2026-03-31		2026-03-31				0			[]	2026-06-19 11:05:24.168714+00	2026-06-19 11:05:24.168717+00
441	FID-2026-00442	442	2026-03-31	Antanimena	Anja	514344	RAIALIMAMENO Corridon Lasnet Eticiana	4G	967821	4G_200Go	49000	2026-03-07	Upgrade	Insatisfaction	data insuffisant	Upgrade	Cloturé	2026-03-31				969403	Airfiber_Unlimited 50	99000		2026-03-31	[]	2026-06-19 11:05:24.168743+00	2026-06-19 11:05:24.168746+00
442	FID-2026-00443	443	2026-03-31	Antanimena	Anja	511269	MANDIMBISOA REYMOND Stéphie Nirvana	4G	963471	4G_500Go	0	2026-01-03	Résiliation	Autres	Retenue recouvrement	Basculement	Cloturé	2026-03-31				969431	4G_200Go	49000		2026-03-31	[]	2026-06-19 11:05:24.168772+00	2026-06-19 11:05:24.168775+00
443	FID-2026-00444	444	2026-04-01	Masay	Fitiavana	22256	TRILOGY DISTRIBUTION	Airfiber	898801	Airfiber_Plus	189000	2023-07-11	Résiliation	Double emploi	double emploi	Résiliation	En Attente			2026-07-31			Airfiber_Plus	0			[]	2026-06-19 11:05:24.168801+00	2026-06-19 11:05:24.168804+00
444	FID-2026-00445	445	2026-04-01	Antanimena	Fitiavana	21621	RATSIMBA Manitra Harisoa	4G	856954	4G_512 Ko	169000	2020-07-01	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente		Tino	2026-06-30			4G_512 Ko	0			[]	2026-06-19 11:05:24.16883+00	2026-06-19 11:05:24.168833+00
445	FID-2026-00446	446	2026-04-01	Antanimena	Tino	6058	RAHAJASON Liva Annick	4G	877845	4G_Gold	189000	2021-06-29	Résiliation	Mobilité géographique	déménagement province	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.168858+00	2026-06-19 11:05:24.168861+00
446	FID-2026-00447	447	2026-04-01	Antanimena	Tino	490909	RAKOTOARISOA Mamiarimbola Eric	4G	937411	4G_200Go	49000	2025-04-18	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-04-01						49000			[]	2026-06-19 11:05:24.168886+00	2026-06-19 11:05:24.168889+00
447	FID-2026-00448	448	2026-04-01	Masay	Anja	7051	RANDIMBIVOLOLONA Johary	4G	738564	4G_Gold	189000	2013-05-04	Résiliation	Mobilité géographique	Déménagement à l'étranger	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.168915+00	2026-06-19 11:05:24.168918+00
448	FID-2026-00449	449	2026-04-01	Masay	Jessica	452912	RANDRIARISOA Volatiana	4G	913792	4G_200Go	99000	2024-06-20	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Anja	2026-06-30				0			[]	2026-06-19 11:05:24.168943+00	2026-06-19 11:05:24.168946+00
449	FID-2026-00450	450	2026-04-01	Antanimena	Jessica	471895	BRUGNONI Giorgio Luca	Airfiber	909407	Airfiber_First	149000	2024-04-29	Résiliation	Mobilité géographique	déménagement Diégo Suarez	Résiliation	Cloturé		Tino	2026-04-30				0			[]	2026-06-19 11:05:24.168972+00	2026-06-19 11:05:24.168974+00
450	FID-2026-00451	451	2026-04-02	Antanimena	Anja	8952	ONG MANDA	Airfiber	921332	Airfiber_Plus	189000	2017-06-19	Résiliation	Double emploi	double emploi	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.169+00	2026-06-19 11:05:24.169003+00
451	FID-2026-00452	452	2026-04-02	Antanimena	Anja	50961	RANDRIANARISOA Paul	4G	277563	4G_Gold	189000	2016-06-04	Résiliation	Mobilité géographique	déplacement fréquent	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.169028+00	2026-06-19 11:05:24.169031+00
452	FID-2026-00453	453	2026-04-02	Antanimena	Anja	496959	FRANTCHESCA Maminirina Orlandine	4G	945438	4G_200Go	49000	2025-07-04	Résiliation	Insatisfaction	insatisfaction	Résiliation	Cloturé			2026-04-30				0			[]	2026-06-19 11:05:24.169057+00	2026-06-19 11:05:24.16906+00
453	FID-2026-00454	454	2026-04-02	Antanimena	Anja	471430	RAKOTOMANALINA Jerry Antonio	Airfiber	908735	Airfiber_First	0	2024-04-23	Résiliation	Autres	annulation + basculement	Annulation	Cloturé	2026-04-02				969590	Airfiber_Unlimited 50	99000			[]	2026-06-19 11:05:24.169085+00	2026-06-19 11:05:24.169088+00
454	FID-2026-00455	455	2026-04-02	Antanimena	Fitiavana	16716	RAVAOARIZAIMANANA Emilia Harivaovao	Airfiber	944976	Airfiber_Unlimited 20	0	2016-05-31	Résiliation	Autres	annulation + basculement	Annulation	Cloturé	2026-04-02				944976	Airfiber_Unlimited 20	99000		2026-06-30	[]	2026-06-19 11:05:24.169148+00	2026-06-19 11:05:24.169154+00
455	FID-2026-00456	456	2026-04-02	Antanimena	Fitiavana	515444	RANDRIAMALALA Adrienne Mireille	4G	969307	4G_200Go	0	2026-03-30	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé	2026-04-02						0			[]	2026-06-19 11:05:24.169185+00	2026-06-19 11:05:24.169189+00
456	FID-2026-00457	457	2026-04-02	Antanimena	Fitiavana	470959	RANDRIANARISON Sarobidiniaina	4G	939119	4G_500Go	0	2025-05-03	Résiliation	Autres	annulation + basculement	Downgrade	En Attente	2026-04-30					4G_200Go	49000		2026-04-30	[]	2026-06-19 11:05:24.169215+00	2026-06-19 11:05:24.169218+00
457	FID-2026-00458	458	2026-04-02	Antanimena	Anja	480530	RAZANADRASOA Suzette	4G	962699	4G_200Go	49000	2025-12-24	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-02					4G_200Go	49000	FARALAHINANDRASANA Pierre William		[]	2026-06-19 11:05:24.169245+00	2026-06-19 11:05:24.169248+00
458	FID-2026-00459	459	2026-04-02	Antanimena	Anja	515657	FARALAHINANDRASANA Pierre William	4G	969640	4G_200Go	49000	2024-11-30	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-02					4G_200Go	49000	RAZANADRASOA Suzette		[]	2026-06-19 11:05:24.169276+00	2026-06-19 11:05:24.169279+00
459	FID-2026-00460	460	2026-04-03	Masay	Tino	495654	ASSOCIATION ACCES / RABEARIMANANA Noelintsoa Veroniaina	4G	943739	4G_500Go	99000	2025-06-16	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente		Jessica	2026-06-30			4G_500Go	0			[]	2026-06-19 11:05:24.169304+00	2026-06-19 11:05:24.169307+00
460	FID-2026-00461	461	2026-04-03	Masay	Jessica	495225	NIONY FIONONANA	Airfiber	943204	Airfiber_Unlimited 20	99000	2025-06-10	Résiliation	Raison personnelle	Raison personnelle	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169334+00	2026-06-19 11:05:24.169337+00
461	FID-2026-00462	462	2026-04-03	Masay	Jessica	495640	RAZAFINDRAJARY Jean Louis	4G	943718	4G_200Go	49000	2025-06-16	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169363+00	2026-06-19 11:05:24.169366+00
462	FID-2026-00463	463	2026-04-03	Antanimena	Tino	515470	RAMILISON Andrianandraina Fetra	4G	969347	4G_200Go	0	2026-03-30	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé	2026-04-03					4G_200Go	0			[]	2026-06-19 11:05:24.169392+00	2026-06-19 11:05:24.169395+00
463	FID-2026-00464	464	2026-04-03	Antanimena	Tino	11858	RAONISOAMALALA Jeanette	Airfiber	908414	Airfiber_Plus	0	2024-04-16	Résiliation	Autres	annulation + basculement	Basculement	Cloturé	2026-04-03				969666	Airfiber_Unlimited 50	99000		2026-04-03	[]	2026-06-19 11:05:24.16942+00	2026-06-19 11:05:24.169423+00
464	FID-2026-00465	465	2026-04-03	Antanimena	Anja	11858	RAONISOAMALALA Jeanette	4G	908911	4G_20Go	0	2024-04-18	Résiliation	Autres	annulation + basculement	Upgrade	En Attente	2026-04-30					4G_200Go	49000		2026-04-30	[]	2026-06-19 11:05:24.169449+00	2026-06-19 11:05:24.169452+00
465	FID-2026-00466	466	2026-04-03	Antanimena	Tino	41993	RAVONJIARIMALALA Hélène	Airfiber	888723	Airfiber_Plus	189000	2022-06-27	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Anja	2026-06-30			Airfiber_Plus	0			[]	2026-06-19 11:05:24.169479+00	2026-06-19 11:05:24.169482+00
466	FID-2026-00467	467	2026-04-04	Antanimena	Anja	511168	BARTHELEMY	4G	966777	4G_500Go	79000	2026-02-23	Upgrade	Autres	upgrade + basculement	Upgrade	Cloturé	2026-04-04				969694	Airfiber_Unlimited 50	99000		2026-04-04	[]	2026-06-19 11:05:24.169508+00	2026-06-19 11:05:24.169511+00
467	FID-2026-00468	468	2026-04-04	Antanimena	Fitiavana	31252	RAKOTOHERY Rado	4G	906894	4G_10Go	30000	2024-03-09	Upgrade	Autres	upgrade	Upgrade	Cloturé	2026-04-04				969693	4G_200Go	49000		2026-04-04	[]	2026-06-19 11:05:24.169537+00	2026-06-19 11:05:24.16954+00
468	FID-2026-00469	469	2026-04-07	Masay	Jessica	11297	RAFAMANTANANTSOA Lucie	4G	822549	4G_512 Ko	169000	2011-06-18	Résiliation	Autres	Départ	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169565+00	2026-06-19 11:05:24.169568+00
469	FID-2026-00470	470	2026-04-07	Antanimena	Anja	455930	RAHARINJAKA Aina Tiana Stephan	Airfiber	942830	Airfiber_Unlimited 50	149000	2025-06-05	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Tino	2026-06-30				0			[]	2026-06-19 11:05:24.169594+00	2026-06-19 11:05:24.169597+00
470	FID-2026-00471	471	2026-04-07	Antanimena	Tino	14811	RAMAROLAHY Heriniaina Bruno	4G	907665	4G_65Go	119000	2021-06-17	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169622+00	2026-06-19 11:05:24.169625+00
471	FID-2026-00472	472	2026-04-08	Antanimena	Tino	495332	RAKOTONDRAMANANA Andrianirina Alain Bruno	4G	943335	4G_200Go	49000	2025-06-12	Résiliation	Mobilité géographique	déménagement étranger	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169651+00	2026-06-19 11:05:24.169654+00
472	FID-2026-00473	473	2026-04-08	Antanimena	Fitiavana	471301	RALAMBO Reine Liantsoa	4G	948105	4G_200Go	49000	2025-07-30	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-08					4G_200Go	49000	RAMAHATAFANDRY Colette Liliane		[]	2026-06-19 11:05:24.169679+00	2026-06-19 11:05:24.169682+00
473	FID-2026-00474	474	2026-04-09	Masay	Jessica	496078	ANDRIAMASIMIADANA FANANTENANA Fabrice	Airfiber	944293	Airfiber_VIP	99000	2025-06-24	Résiliation	Insatisfaction	Débit	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169708+00	2026-06-19 11:05:24.169711+00
474	FID-2026-00475	475	2026-04-09	Antanimena	Anja	495684	RANAIVOSON Tsifaratiana Harinjara	4G	943772	4G_200Go	49000	2025-06-17	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Fitiavana	2026-06-30				0			[]	2026-06-19 11:05:24.169736+00	2026-06-19 11:05:24.169739+00
475	FID-2026-00476	476	2026-04-09	Antanimena	Tino	17082	CHAPELAIN Jean Charles	Airfiber	913498	Airfiber_Plus	189000	2024-06-18	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169764+00	2026-06-19 11:05:24.169767+00
476	FID-2026-00477	477	2026-04-10	Masay	Jessica	488718	TSIHOARANTSALAMA Tsanta Henintsoa Tinaeli	4G	934475	4G_200Go	49000	2025-03-15	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-04-10						49000			[]	2026-06-19 11:05:24.169792+00	2026-06-19 11:05:24.169795+00
477	FID-2026-00478	478	2026-04-10	Masay	Jessica	494865	RAZAFINDRAVELO Solofoniaina	4G	942758	4G_200Go	49000	2025-06-04	Résiliation	Raison personnelle	Raison personnelle	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169821+00	2026-06-19 11:05:24.169823+00
478	FID-2026-00479	479	2026-04-10	Masay	Jessica	505783	RANAIVOMAHEFA Solomampionona	Airfiber	956034	Airfiber_Unlimited 50	149000	2025-10-29	Résiliation	Autres	Déménagement	Résiliation	Cloturé	2026-04-10						149000			[]	2026-06-19 11:05:24.169849+00	2026-06-19 11:05:24.169852+00
479	FID-2026-00480	480	2026-04-10	Masay	Jessica	515109	RANDRIAMANANA Mampionona Donatien	4G	968850	4G_200Go	0	2026-03-23	Résiliation	Insatisfaction	annulation+basculement	Annulation	Cloturé	2026-04-28				971107	Airfiber_Unlimited 50	99000	99000	2026-04-28	[]	2026-06-19 11:05:24.169878+00	2026-06-19 11:05:24.169881+00
480	FID-2026-00481	481	2026-04-10	Antanimena	Tino	468529	ANDRIANJAFY KWAN SOON Yohann Govanni	Airfiber	913724	Airfiber_First	149000	2024-06-20	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169906+00	2026-06-19 11:05:24.169909+00
481	FID-2026-00482	482	2026-04-10	Antanimena	Fitiavana	515716	RAKOTO HARISOA Mialy Iarivony	4G	969730	4G_200Go	0	2026-04-04	Résiliation	Zone Non Couvert	Zone non couvert	Résiliation	Cloturé	2026-04-10						0			[]	2026-06-19 11:05:24.169934+00	2026-06-19 11:05:24.169937+00
482	FID-2026-00483	483	2026-04-10	Antanimena	Anja	513424	RANAVALONANDRASANA Mialisoa Odile/RASOAMBOLA Sissi Rosar Viottie	4G	966510	4G_200Go	49000	2026-02-19	Résiliation	Mobilité géographique	départ utilisateur	Refusée	Cloturé	2026-04-10						49000			[]	2026-06-19 11:05:24.169963+00	2026-06-19 11:05:24.169966+00
483	FID-2026-00484	484	2026-04-10	Antanimena	Anja	496653	RAZAZAROHAVANA Njaratsilavina Sitrakiniaina	Airfiber	945038	Airfiber_Unlimited 20	99000	2025-06-30	Résiliation	Mobilité géographique	déménagement Majunga	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.169991+00	2026-06-19 11:05:24.169994+00
484	FID-2026-00485	485	2026-04-13	Antanimena	Anja	407315	RANDRIANARIVELO Rija	4G	944957	4G_200Go	49000	2026-06-30	Résiliation	Autres	Changement d'opérateur	Résiliation	En Attente		Fitiavana	2026-06-30				0			[]	2026-06-19 11:05:24.17002+00	2026-06-19 11:05:24.170023+00
485	FID-2026-00486	486	2026-04-13	Antanimena	Fitiavana	497618	EUROCCASIONS - KAMORO HOTEL / RANDRIAMANAMIHANTASOA Nirilanto Haingoarivelo	4G	946310	4G_200Go	49000	2025-07-14	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.170048+00	2026-06-19 11:05:24.170051+00
486	FID-2026-00487	487	2026-04-13	Masay	Anja	462325	RAKOTONDRAFARA Solofoniaina Fenosoa	4G	943387	4G_200Go	49000	2025-06-12	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.170077+00	2026-06-19 11:05:24.17008+00
487	FID-2026-00488	488	2026-04-13	Masay	Jessica	496723	RAKOTONIAINA Alain André	4G	945120	4G_500Go	99000	2025-07-01	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente		Anja	2026-06-30				0			[]	2026-06-19 11:05:24.17011+00	2026-06-19 11:05:24.170113+00
488	FID-2026-00489	489	2026-04-14	Antanimena	Tino	478323	RAKOTOMAMONJY Jeanne Estella	Airfiber	919703	Airfiber_Plus	0	2024-10-02	Basculement	Autres	demande client	Basculement	Cloturé	2026-04-14					Airfiber_Unlimited 50	249000		2026-04-14	[]	2026-06-19 11:05:24.170166+00	2026-06-19 11:05:24.170171+00
489	FID-2026-00490	490	2026-04-14	Antanimena	Jessica	42874	RASOLOFOJAONA Nivo / RAJAOHARISOA William	4G	948436	4G_200Go	49000	2025-08-01	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente		Tino	2026-07-31				0			[]	2026-06-19 11:05:24.170198+00	2026-06-19 11:05:24.170201+00
490	FID-2026-00491	491	2026-04-14	Masay	Anja	491451	NOMENA ANJARA AINA Mandresy	4G	938116	4G_500Go	0	2025-04-25	Résiliation	Zone Non Couvert	ZNC après intervention	Résiliation	Cloturé	2026-04-24					4G_500Go	0			[]	2026-06-19 11:05:24.170227+00	2026-06-19 11:05:24.17023+00
491	FID-2026-00492	492	2026-04-14	Masay	Anja	155619	GOOLY Jaykrishan	Airfiber	939386	Airfiber_Unlimited 50	149000	2026-05-30	Basculement	Autres	basculement+prolongation	Basculement	En Attente	2026-05-30					Airfiber_Unlimited 50	149000		2026-05-30	[]	2026-06-19 11:05:24.170256+00	2026-06-19 11:05:24.170259+00
492	FID-2026-00493	493	2026-04-14	Antanimena	Fitiavana	493568	RAKOTOMALALA Rivo Nirin	4G	940996	4G_200Go	49000	2025-05-22	Résiliation	Mobilité géographique	déplacement fréquente	Refusée	Cloturé	2026-04-14						49000			[]	2026-06-19 11:05:24.170285+00	2026-06-19 11:05:24.170288+00
493	FID-2026-00494	494	2026-04-15	Masay	Anja	42297	ANDRIAMIHARISOA RAKOTONDRATSIMA	4G	251390	4G_512 Ko	169000	2015-04-29	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-15					4G_512 Ko	169000			[]	2026-06-19 11:05:24.170315+00	2026-06-19 11:05:24.170318+00
494	FID-2026-00495	495	2026-04-15	Masay	Anja	29483	RANDRIANARIVELO Maminirina	4G	901045	4G_5Go	15000	2023-06-15	Résiliation	Autres	Non utilisation	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.170344+00	2026-06-19 11:05:24.170347+00
495	FID-2026-00496	496	2026-04-15	Masay	Anja	472568	ANDRIAMAHEFA Hariliva Sandra	Airfiber	944052	Airfiber_Unlimited 20	0	2025-06-14	Résiliation	Autres	annulation + basculement	Basculement	En Attente	2026-04-30					Airfiber_Unlimited 50	99000		2026-06-30	[]	2026-06-19 11:05:24.170374+00	2026-06-19 11:05:24.170376+00
496	FID-2026-00497	497	2026-04-15	Antanimena	Anja	453819	PIERROT LOSLIE Mershab Kretcher	4G	942606	4G_200Go	0	2025-06-03	Résiliation	Mobilité géographique	annulation + basculement	Annulation	Cloturé	2026-05-13				972124	Airfiber_Unlimited 50	149000		2026-05-13	[]	2026-06-19 11:05:24.170402+00	2026-06-19 11:05:24.170405+00
497	FID-2026-00498	498	2026-04-15	Antanimena	Anja	173790	BEMANAJA Etienne	4G	564660	4G_Gold	189000	2018-06-27	Résiliation	Problème financier	Problème financier	Résiliation	En Attente		Fitiavana	2026-06-30				0			[]	2026-06-19 11:05:24.170431+00	2026-06-19 11:05:24.170434+00
498	FID-2026-00499	499	2026-04-15	Antanimena	Fitiavana	17283	RALALARIVONY Ralitera Aline	4G	876691	4G_Gold	189000	2021-05-31	Downgrade	Problème financier	Problème financier	Downgrade	En Attente	2026-05-30					4G_500Go	79000		2026-05-30	[]	2026-06-19 11:05:24.17046+00	2026-06-19 11:05:24.170463+00
499	FID-2026-00500	500	2026-04-15	Masay	Anja	23485	RABAKO RALAMBONIRINA Jean Jacques	4G	886478	4G_512 Ko	169000	2013-03-25	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-15						169000			[]	2026-06-19 11:05:24.170488+00	2026-06-19 11:05:24.170491+00
500	FID-2026-00501	501	2026-04-16	Antanimena	Tino	481305	RASENDRAMAHAVALISOA RATSIMBA Toavina Tsihoarana	4G	924213	4G_200Go	49000	2024-11-30	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-16						49000			[]	2026-06-19 11:05:24.170516+00	2026-06-19 11:05:24.170519+00
501	FID-2026-00502	502	2026-04-16	Masay	Anja	141011	MADASTONE COMPAGNIE	Airfiber	915072	Airfiber_Plus	0	2018-01-17	Résiliation	Autres	annulation résiliation+changement de nom	Annulation	Cloturé	2026-04-20				915072	Airfiber_Plus	169000	MANET Philippe Paul André/MADASTONE	2018-01-17	[]	2026-06-19 11:05:24.361738+00	2026-06-19 11:05:24.361755+00
502	FID-2026-00503	503	2026-04-16	Masay	Anja	496579	RAOELINA Stéphane	4G	944936	4G_200Go	49000	2025-06-29	Résiliation	Insatisfaction	lenteur débit	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.361785+00	2026-06-19 11:05:24.361789+00
503	FID-2026-00504	504	2026-04-16	Antanimena	Tino	34276	MIARIMBELO Andriamanjato	4G	227691	4G_512 Ko	169000	2014-06-30	Résiliation	Autres	retraité	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.361816+00	2026-06-19 11:05:24.361819+00
504	FID-2026-00505	505	2026-04-16	Antanimena	Tino	17287	SIPED	4G	854789	4G_512 Ko	169000	2020-06-09	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.361848+00	2026-06-19 11:05:24.36185+00
505	FID-2026-00506	506	2026-04-16	Antanimena	Tino	487953	LOVANAVALONA Malina	Airfiber	933385	Airfiber_First	149000	2025-03-05	Basculement	Autres	Basculement	Basculement	Cloturé	2026-04-16				970362	Airfiber_Unlimited 20	149000		2026-04-16	[]	2026-06-19 11:05:24.361882+00	2026-06-19 11:05:24.361886+00
506	FID-2026-00507	507	2026-04-16	Antanimena	Tino	495577	RAKOTONONERANA Vonimahaliana Tsiriniaina	Airfiber	943650	Airfiber_VIP	99000	2025-06-15	Résiliation	Mobilité géographique	déménagement Ankadivory	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.361918+00	2026-06-19 11:05:24.361922+00
507	FID-2026-00508	508	2026-04-16	Antanimena	Tino	496631	RAKOTOARISON Mamitiana Christian	Airfiber	945011	Airfiber_Unlimited 50	149000	2025-06-30	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.361949+00	2026-06-19 11:05:24.361952+00
508	FID-2026-00509	509	2026-04-16	Antanimena	Tino	496045	ANDRIAMIARISOA Mbolahajaniaina Tahiry	4G	944250	4G_200Go	49000	2025-06-23	Résiliation	Mobilité géographique	déménagement	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.36198+00	2026-06-19 11:05:24.361983+00
509	FID-2026-00510	510	2026-04-17	Antanimena	Fitiavana	450559	RABEARISOA Annick Hantanirina	4G	877082	4G_Gold	189000	2021-06-07	Résiliation	Problème financier	problème financier	Résiliation	En Attente		Tino	2026-06-30				0			[]	2026-06-19 11:05:24.362009+00	2026-06-19 11:05:24.362012+00
510	FID-2026-00511	511	2026-04-17	Masay	Jessica	41721	Société. ENTREPRISE INDIVIDUELLE AUREUS/MADSQUARE	Airfiber	945151	Airfiber_Unlimited 50	149000	2025-07-01	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Anja	2026-06-30				0			[]	2026-06-19 11:05:24.362039+00	2026-06-19 11:05:24.362042+00
511	FID-2026-00512	512	2026-04-17	Masay	Anja	496055	ARIRAVAKINIAINA Anja Mbolatiavina	4G	944245	4G_200Go	49000	2025-06-23	Résiliation	Autres	veut offre sans engagement	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362069+00	2026-06-19 11:05:24.362079+00
512	FID-2026-00513	513	2026-04-18	Antanimena	Fitiavana	486023	RAKOTOARISON Fitahiana Mahery/ ANDRIAMANANTSOA Vaosariaka Arisolo Elina	4G	930777	4G_200Go	49000	2025-02-12	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-04-18						49000			[]	2026-06-19 11:05:24.362143+00	2026-06-19 11:05:24.362148+00
513	FID-2026-00514	514	2026-04-18	Antanimena	Fitiavana	492335	RANDRIAMIHARIMANANTSOA Kantoniaina Rija Mayeul	4G	939326	4G_200Go	49000	2025-05-05	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-04-18						49000			[]	2026-06-19 11:05:24.362178+00	2026-06-19 11:05:24.362181+00
514	FID-2026-00515	515	2026-04-20	Masay	Anja	482411	RANDRIAMARINTSAINA Rodolphe	4G	925859	4G_200Go	49000	2024-12-12	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-20						49000			[]	2026-06-19 11:05:24.362207+00	2026-06-19 11:05:24.36221+00
515	FID-2026-00516	516	2026-04-20	Masay	Anja	500489	ANDRIANTSILAVINA Randimbison Riantsoa	4G	952914	4G_200Go	49000	2025-09-29	Résiliation	Insatisfaction	insatisfaction service	Refusée	Cloturé	2026-04-20						49000			[]	2026-06-19 11:05:24.362236+00	2026-06-19 11:05:24.362239+00
516	FID-2026-00517	517	2026-04-20	Antanimena	Tino	452070	NJARANIRINA Fleurette	Airfiber	899687	Airfiber_Ultra	249000	2023-04-07	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362265+00	2026-06-19 11:05:24.362268+00
517	FID-2026-00518	518	2026-04-21	Antanimena	Nathalie	467561	ANDRIANANTOANINA Mamy Nirina	4G	900735	4G_50Go	0	2023-05-31	Résiliation	Autres	basculement	Basculement	En Attente	2026-05-31	Fitiavana				4G_200Go	49000		2026-05-31	[]	2026-06-19 11:05:24.362295+00	2026-06-19 11:05:24.362297+00
518	FID-2026-00519	519	2026-04-21	Antanimena	Fitiavana	493853	RAZAKARIASA Nicolas Hery Lala	4G	944448	4G_200Go	49000	2025-06-25	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362323+00	2026-06-19 11:05:24.362326+00
519	FID-2026-00520	520	2026-04-21	Antanimena	Anja	12912	RAJAONSON Andriamahenina Nirina Tsarazaka	Airfiber	914252	Airfiber_First	99000	2023-06-30	Résiliation	Mobilité géographique	déménagement fréquente	Résiliation	En Attente		Fitiavana	2026-06-30				0			[]	2026-06-19 11:05:24.362352+00	2026-06-19 11:05:24.362355+00
520	FID-2026-00521	521	2026-04-21	Antanimena	Tino	467737	VENI CREATOR MADA	Airfiber	913503	Airfiber_First	149000	2024-06-18	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-21						149000			[]	2026-06-19 11:05:24.362384+00	2026-06-19 11:05:24.362387+00
521	FID-2026-00522	522	2026-04-22	Antanimena	Tino	506385	ZAFINANDRASANA Infrid Nancy	Airfiber	956903	Airfiber_Unlimited 20	99000	2025-11-07	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-22						99000	RANDRIAMANJAKA Tsimaniry Daniel		[]	2026-06-19 11:05:24.362413+00	2026-06-19 11:05:24.362416+00
522	FID-2026-00523	523	2026-04-23	Antanimena	Tino	274050	AL RIDA	4G	674425	4G_Gold	189000	2019-04-25	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-04-23						189000			[]	2026-06-19 11:05:24.362442+00	2026-06-19 11:05:24.362444+00
523	FID-2026-00524	524	2026-04-23	Antanimena	Fitiavana	474921	RABENANTOANDRO Tantely Harinirin	4G	914308	4G_200Go	99000	2024-06-29	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.36247+00	2026-06-19 11:05:24.362473+00
524	FID-2026-00525	525	2026-04-23	Antanimena	Tino	506117	RAKOTOARIVONY Fifaliana Rosa	4G	956551	4G_200Go	49000	2025-11-05	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-04-23						49000			[]	2026-06-19 11:05:24.362498+00	2026-06-19 11:05:24.362501+00
525	FID-2026-00526	526	2026-04-21	Masay	Anja	24967	SOLOFOHARIVELO Mamy Lea	4G	882282	4G_512 Ko	169000	2013-06-19	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362526+00	2026-06-19 11:05:24.362529+00
526	FID-2026-00527	527	2026-04-21	Masay	Anja	17400	Société. SPRING MADAGASCAR	4G	856209	4G_Gold	189000	2020-06-23	Résiliation	Autres	Non utilisation	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362555+00	2026-06-19 11:05:24.362558+00
527	FID-2026-00528	528	2026-04-21	Masay	Anja	492875	RASENDRAMALALAHASINA Sarah/ RASOLONJATOVO Tiavina Alain Tommy	4G	940072	4G_500Go	99000	2025-05-13	Résiliation	Mobilité géographique	départ	Résiliation	En Attente			2026-05-31				0			[]	2026-06-19 11:05:24.362584+00	2026-06-19 11:05:24.362586+00
528	FID-2026-00529	529	2026-04-24	Masay	Jessica	49297	RANJALAHY Angelo	4G	878051	4G_Gold	189000	2021-07-02	Résiliation	Autres	Cessation d'activité	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362618+00	2026-06-19 11:05:24.362626+00
529	FID-2026-00530	530	2026-04-24	Antanimena	Anja	120	CMA CONSEIL	4G	883474	4G_Gold	0	2015-08-31	Résiliation	Autres	annulation + basculement	Basculement	Cloturé	2026-04-24				970747	Airfiber_Unlimited 30	189000		2026-04-24	[]	2026-06-19 11:05:24.362653+00	2026-06-19 11:05:24.362656+00
530	FID-2026-00531	531	2026-04-24	Antanimena	Anja	120	CMA CONSEIL	4G	878237	4G_Gold	0	2020-07-27	Résiliation	Autres	annulation + basculement	Basculement	Cloturé	2026-04-24				970748	Airfiber_Unlimited 30	189000		2026-04-24	[]	2026-06-19 11:05:24.362681+00	2026-06-19 11:05:24.362684+00
531	FID-2026-00532	532	2026-04-25	Antanimena	Tino	492201	RANOELISON ANDRIAMIHAJA Fanilo Ny Aina	Airfiber	939311	Airfiber_Unlimited 50	0	2025-05-03	Résiliation	Autres	annulation + basculement	Basculement	En Attente	2026-04-30					Airfiber_Unlimited 20	149000		2026-04-30	[]	2026-06-19 11:05:24.36271+00	2026-06-19 11:05:24.362713+00
532	FID-2026-00533	533	2026-04-25	Antanimena	Tino	495113	ANRIAMBOLA Vonisoa Nantenaina	4G	943045	4G_200Go	49000	2025-06-07	Résiliation	Mobilité géographique	déménagement province	Refusée	Cloturé	2026-04-25						49000			[]	2026-06-19 11:05:24.362738+00	2026-06-19 11:05:24.362741+00
533	FID-2026-00534	534	2026-04-25	Antanimena	Tino	493039	RABOANARY Onja Nantenaina Hanitriniala	4G	940301	4G_200Go	49000	2025-05-12	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-25						49000			[]	2026-06-19 11:05:24.362767+00	2026-06-19 11:05:24.36277+00
534	FID-2026-00535	535	2026-04-27	Antanimena	Fitiavana	446452	RANDRIAMIHAJA Zoé Mamy	Airfiber	908053	Airfiber_Plus	189000	2024-04-09	Résiliation	Insatisfaction	insatisfaction lenteur	Refusée	Cloturé	2026-04-27						189000			[]	2026-06-19 11:05:24.362796+00	2026-06-19 11:05:24.3628+00
535	FID-2026-00536	536	2026-04-28	Antanimena	Tino	173809	RANDRIAMALALA Jean Jacques	4G	945044	4G_500Go	99000	2025-06-30	Résiliation	Insatisfaction	insatisfaction lenteur	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362825+00	2026-06-19 11:05:24.362828+00
536	FID-2026-00537	537	2026-04-28	Antanimena	Fitiavana	11247	ECOCERT Succursale Madagascar	4G	872249	4G_512 Ko	169000	2011-06-17	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362853+00	2026-06-19 11:05:24.362856+00
537	FID-2026-00538	538	2026-04-28	Antanimena	Anja	71638	RAKOTOARIMANANA Eléo Patricia	Airfiber	938625	Airfiber_Unlimited 20	0	2025-04-30	Résiliation	Autres	annulation + basculement	Basculement	En Attente	2026-04-30					Airfiber_Unlimited 50	99000		2026-04-30	[]	2026-06-19 11:05:24.362881+00	2026-06-19 11:05:24.362884+00
538	FID-2026-00539	539	2026-04-27	Masay	Jessica	489598	SOLOFONIRINA Anjamalala Noelinah	4G	942804	4G_200Go	49000	2025-06-05	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-27						49000			[]	2026-06-19 11:05:24.362909+00	2026-06-19 11:05:24.362912+00
539	FID-2026-00540	540	2026-04-27	Masay	Jessica	497209	RAKOTOMALALA Rindra Razah	4G	945767	4G_200Go	49000	2025-07-08	Résiliation	Insatisfaction	débits	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.362937+00	2026-06-19 11:05:24.36294+00
540	FID-2026-00541	541	2026-04-27	Masay	Jessica	496524	NOMENJANAHARY Mirantsoa Mialiniaina Prisca	4G	944870	4G_200Go	49000	2025-06-28	Résiliation	Autres	départ	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362965+00	2026-06-19 11:05:24.362968+00
541	FID-2026-00542	542	2026-04-27	Masay	Jessica	474937	IOLONTSOA Larotia	Airfiber	914346	Airfiber_First	149000	2024-06-29	Résiliation	Raison personnelle	Raison personnelle	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.362993+00	2026-06-19 11:05:24.362996+00
542	FID-2026-00543	543	2026-04-27	Masay	Jessica	469586	RATSIMANDRESY Tolotra Fanambinantsoa	Airfiber	904517	Airfiber_VIP	99000	2023-11-27	Résiliation	Insatisfaction	débits	Refusée	Cloturé	2026-04-27						99000			[]	2026-06-19 11:05:24.363022+00	2026-06-19 11:05:24.363024+00
543	FID-2026-00544	544	2026-04-27	Masay	Jessica	499019	ANDRIATSIMIALONA Salohy Ny Aina	4G	948161	4G_200Go	49000	30/07/2025	Résiliation	Autres	Déménagement à l'étranger	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.36305+00	2026-06-19 11:05:24.363052+00
544	FID-2026-00545	545	2026-04-28	Masay	Jessica	474608	RAKOTOVAO Marie Jocye	Airfiber	945257	Airfiber_Unlimited 20	99000	2025-07-02	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363083+00	2026-06-19 11:05:24.363086+00
545	FID-2026-00546	546	2026-04-28	Masay	Jessica	498544	RANDRIANITOVINA Nambinina Arsène	4G	947542	4G_500Go	99000	2025-07-25	Résiliation	Autres	problème technique	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363142+00	2026-06-19 11:05:24.363147+00
546	FID-2026-00547	547	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953284	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363236+00	2026-06-19 11:05:24.363242+00
547	FID-2026-00548	548	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953283	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363274+00	2026-06-19 11:05:24.363277+00
548	FID-2026-00549	549	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953281	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363304+00	2026-06-19 11:05:24.363307+00
549	FID-2026-00550	550	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953279	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363334+00	2026-06-19 11:05:24.363337+00
550	FID-2026-00551	551	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953278	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363367+00	2026-06-19 11:05:24.36337+00
551	FID-2026-00552	552	2026-04-29	Masay	Jessica	4751	EXPOLANKA Madagascar	4G	953277	4G_200Go	149000	2025-10-01	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-04-29					4G_200Go	149000	EFL GLOBAL MADAGASCAR	2026-04-29	[]	2026-06-19 11:05:24.363396+00	2026-06-19 11:05:24.363399+00
552	FID-2026-00553	553	2026-04-28	Antanimena	Tino	474929	RAZAFIMIHAJA Sandy Andrianina	4G	914317	4G_200Go	49000	2025-06-30	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.363425+00	2026-06-19 11:05:24.363428+00
553	FID-2026-00554	554	2026-04-28	Antanimena	Anja	498143	ASSANALY Arnaud	Airfiber	947031	Airfiber_Unlimited 50	0	2025-07-18	Résiliation	Autres	annulation résiliation+basculement	Basculement	Cloturé	2026-04-28				947437	Airfiber_Unlimited 50	99000		2026-07-24	[]	2026-06-19 11:05:24.363455+00	2026-06-19 11:05:24.363457+00
554	FID-2026-00555	555	2026-04-28	Antanimena	Fitiavana	495813	VOARINJATOVO Mihary Valisoa / RATEFIARISON Christian Fitia	4G	943944	4G_200Go	49000	2025-06-19	Résiliation	Insatisfaction	insatisfaction	Refusée	Cloturé	2026-04-28						49000			[]	2026-06-19 11:05:24.363484+00	2026-06-19 11:05:24.363487+00
555	FID-2026-00556	556	2026-04-29	Antanimena	Fitiavana	496102	RAZAFIMANDIMBY Harilantosoa Lalanirina	Airfiber	944315	Airfiber_VIP	99000	2025-06-24	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.363513+00	2026-06-19 11:05:24.363516+00
556	FID-2026-00557	557	2026-04-29	Antanimena	Anja	12059	SOCIETE LILA ROUGH GEM STONES	4G	882082	4G_512 Ko	169000	2011-07-29	Résiliation	Mobilité géographique	déplacement fréquente	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363541+00	2026-06-19 11:05:24.363544+00
557	FID-2026-00558	558	2026-04-29	Antanimena	Fitiavana	456220	Andriamandy Colette Bakoly	4G	877903	4G_Gold	189000	2011-06-30	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.36357+00	2026-06-19 11:05:24.363573+00
558	FID-2026-00559	559	2026-04-29	Masay	Jessica	498735	RAKOTOMANANTSOA Andrianjaka	4G	947784	4G_200Go	49000	2025-07-28	Résiliation	Insatisfaction	débits	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.3636+00	2026-06-19 11:05:24.363602+00
559	FID-2026-00560	560	2026-04-29	Masay	Jessica	485139	MIRADJI Velo Ali	Airfiber	929590	Airfiber_Plus	189000	2025-01-30	Résiliation	Autres	déménagement	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.363629+00	2026-06-19 11:05:24.363632+00
560	FID-2026-00561	561	2026-04-30	Antanimena	Tino	498389	RATSIMISETA Andriamisaharimanana Siméon	4G	947352	4G_200Go	0	2025-07-23	Résiliation	Autres	annulation + basculement	Basculement	Cloturé	2026-04-30				971208	Airfiber_Unlimited 50	99000		2026-04-30	[]	2026-06-19 11:05:24.363657+00	2026-06-19 11:05:24.36366+00
561	FID-2026-00563	563	2026-05-04	Antanimena	Anja	489295	FANAMPERANTSOA Solotiana Rivesty	4G	947018	4G_500Go	99000	2025-07-18	Résiliation	Mobilité géographique	déménagement à Tuléar	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363687+00	2026-06-19 11:05:24.36369+00
562	FID-2026-00564	564	2026-05-04	Antanimena	Tino	498768	ANDRIAMANDIMBIARISOA Harilala Nadia	Airfiber	947915	Airfiber_Unlimited 50	149000	2025-07-29	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363716+00	2026-06-19 11:05:24.363719+00
563	FID-2026-00565	565	2026-05-04	Antanimena	Tino	497145	FACULTE EGS ANKATSO	4G	945677	4G_500Go	99000	2025-07-07	Résiliation	Autres	double emploi	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363744+00	2026-06-19 11:05:24.363747+00
564	FID-2026-00566	566	2026-05-04	Antanimena	Tino	497145	FACULTE EGS ANKATSO	4G	945676	4G_500Go	99000	2025-07-07	Résiliation	Autres	double emploi	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363772+00	2026-06-19 11:05:24.363775+00
565	FID-2026-00567	567	2026-05-04	Antanimena	Tino	497145	FACULTE EGS ANKATSO	4G	945678	4G_500Go	99000	2025-07-07	Résiliation	Autres	double emploi	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363801+00	2026-06-19 11:05:24.363804+00
566	FID-2026-00568	568	2026-05-04	Antanimena	Tino	495212	RAZANADAHY Fenoherizo Manalinandrianina	4G	945253	4G_200Go	49000	2025-07-02	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363831+00	2026-06-19 11:05:24.363834+00
567	FID-2026-00569	569	2026-05-04	Antanimena	Tino	68345	RATSIHOSENA RAMINAHY Nantenaina Joelle	Airfiber	901448	Airfiber_Plus	189000	2023-07-06	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363859+00	2026-06-19 11:05:24.363861+00
568	FID-2026-00570	570	2026-05-04	Antanimena	Fitiavana	497827	RAVALOARISOA Volana Nokasaina	4G	946599	4G_200Go	49000	2025-07-16	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.363887+00	2026-06-19 11:05:24.36389+00
569	FID-2026-00571	571	2026-05-02	Antanimena	Anja	8031	LALARIVELO Mbinina Olivier Rija	Airfiber	915005	Airfiber_Plus	0	2015-06-13	Résiliation	Problème financier	annulation + basculement	Basculement	Cloturé	2026-05-02				971489	Airfiber_Unlimited 50	99000		2026-05-02	[]	2026-06-19 11:05:24.363915+00	2026-06-19 11:05:24.363918+00
570	FID-2026-00572	572	2026-05-04	Antanimena	Anja	495192	MAHATOHITRARIVO Elihirizy Mizanjara	Airfiber	943146	Airfiber_Unlimited 20	0	2026-06-10	Résiliation	Problème financier	annulation + prolongation prix promo U20	Annulation	Cloturé	2026-05-04				943146	Airfiber_Unlimited 20	99000		2026-06-10	[]	2026-06-19 11:05:24.363944+00	2026-06-19 11:05:24.363947+00
571	FID-2026-00573	573	2026-05-04	Antanimena	Anja	177708	RAHELIARILALAO Bienvenue	Airfiber	900754	Airfiber_Plus	0	2026-05-30	Résiliation	Problème financier	annulation + basculement	Basculement	Cloturé	2026-05-04				971487	Airfiber_Unlimited 20	99000		2026-05-30	[]	2026-06-19 11:05:24.363973+00	2026-06-19 11:05:24.363976+00
572	FID-2026-00574	574	2026-05-04	Antanimena	Anja	417139	ANDRIANARIJAONA Diavolana	Airfiber	898133	Airfiber_Plus	189000	2023-09-04	Résiliation	Autres	problème jirama	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.364001+00	2026-06-19 11:05:24.364004+00
573	FID-2026-00575	575	2026-05-04	Antanimena	Anja	496795	TAMONY Bruno	4G	945217	4G_200Go	0	2025-07-02	Résiliation	Autres	annulation + prolongation prix promo 4G 200Go	Annulation	Cloturé	2026-05-04				945217	4G_200Go	49000		2025-07-02	[]	2026-06-19 11:05:24.36403+00	2026-06-19 11:05:24.364033+00
574	FID-2026-00576	576	2026-05-05	Masay	Fitiavana	496725	RANDRIAMANANTENA Rivosoa Ihary	4G	945124	4G_500Go	99000	2025-07-01	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-31			4G_500Go	0			[]	2026-06-19 11:05:24.364058+00	2026-06-19 11:05:24.364061+00
575	FID-2026-00577	577	2026-05-05	Masay	Fitiavana	461149	RALAINIRINA Norohanitriniaina Miora Lydia	Airfiber	888854	Airfiber_Plus	189000	2022-07-01	Résiliation	Mobilité géographique	Déménagement à l'étranger	Résiliation	En Attente			2026-07-31			Airfiber_Plus	0			[]	2026-06-19 11:05:24.364092+00	2026-06-19 11:05:24.364094+00
576	FID-2026-00578	578	2026-05-06	Antanimena	Jessica	475405	RAOELISON Famantanantsoa Estela	4G	915096	4G_200Go	99000	2024-07-11	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.364147+00	2026-06-19 11:05:24.364152+00
577	FID-2026-00579	579	2026-05-06	Antanimena	Anja	497703	ZAFIMAHATRATRA Poulteau Albert	4G	946431	4G_500Go	99000	2025-07-15	Résiliation	Autres	Affecté	Résiliation	En Attente		Jessica	2026-07-31				0			[]	2026-06-19 11:05:24.364181+00	2026-06-19 11:05:24.364184+00
578	FID-2026-00580	580	2026-05-04	Masay	Anja	499656	Société. ATM Architectures et Travaux Madagascar	4G	948989	4G_200Go	49000	2025-08-08	Résiliation	Problème financier	Problème financier	Résiliation	En Attente			2026-08-31				0			[]	2026-06-19 11:05:24.364212+00	2026-06-19 11:05:24.364215+00
579	FID-2026-00581	581	2026-05-04	Masay	Anja	499781	RAZAFINJANAHARY Nirina Stefana	4G	949151	4G_200Go	49000	2025-08-12	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-08-31				0			[]	2026-06-19 11:05:24.364243+00	2026-06-19 11:05:24.364246+00
580	FID-2026-00582	582	2026-05-04	Masay	Tino	41644	M. MILLOT Gérard Pierre Jacques	4G	328906	4G_512 Ko	169000	2016-07-25	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente		Jessica	2026-07-30				0			[]	2026-06-19 11:05:24.364275+00	2026-06-19 11:05:24.364278+00
581	FID-2026-00583	583	2026-05-04	Masay	Jessica	496941	RANDRIANARIVO Nirina Mirella/ RANDRIANARIVO Franck Lalaina	4G	945417	4G_200Go	49000	2025-07-04	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-30				0			[]	2026-06-19 11:05:24.364305+00	2026-06-19 11:05:24.364308+00
582	FID-2026-00584	584	2026-05-04	Masay	Tino	173099	Société. Boutique K-BLIND	4G	889430	4G_Gold	189000	2022-07-30	Résiliation	Autres	Céssation d'activité	Résiliation	En Attente		Jessica	2026-07-30				0			[]	2026-06-19 11:05:24.364334+00	2026-06-19 11:05:24.364337+00
583	FID-2026-00585	585	2026-05-04	Masay	Jessica	495968	RAKOTOARISOA Fanomezantsoa Miradoniaina	4G	944167	4G_200Go	49000	2025-06-21	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-05-04					4G_200Go	49000			[]	2026-06-19 11:05:24.364363+00	2026-06-19 11:05:24.364366+00
584	FID-2026-00586	586	2026-05-07	Masay	Tino	9211	RAMBININTSAOTRA Vololotiana	4G	878665	4G_Gold	189000	2021-07-21	Résiliation	Mobilité géographique	déménagement étranger	Résiliation	En Attente			2026-07-30				0			[]	2026-06-19 11:05:24.364392+00	2026-06-19 11:05:24.364395+00
585	FID-2026-00587	587	2026-05-08	Masay	Tino	9169	RAKOTOZAFY Anjaratiana Arivola /RAKOTOZAFY Solo	4G	946967	4G_200Go	49000	2025-07-18	Résiliation	Autres	Problème banque	Résiliation	En Attente			2026-07-30				0			[]	2026-06-19 11:05:24.36442+00	2026-06-19 11:05:24.364423+00
586	FID-2026-00588	588	2026-05-08	Masay	Tino	455857	RANDRINDRAHONANDO Mahefasoa Nicolas	4G	877189	4G_Gold	189000	2021-06-10	Résiliation	Autres	changement d'opérateur	Refusée	Cloturé	2026-05-08						189000			[]	2026-06-19 11:05:24.364449+00	2026-06-19 11:05:24.364451+00
587	FID-2026-00589	589	2026-05-08	Masay	Tino	495417	ANILAH Mioratiana Fiononana	4G	943445	4G_200Go	49000	2025-06-13	Résiliation	Insatisfaction	insatisfaction technique	Refusée	Cloturé	2026-05-08						49000			[]	2026-06-19 11:05:24.364477+00	2026-06-19 11:05:24.36448+00
588	FID-2026-00590	590	2026-05-07	Antanimena	Anja	10993	RANAIVO Roland	4G	885487	4G_Gold	189000	2012-06-29	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.364507+00	2026-06-19 11:05:24.364509+00
589	FID-2026-00591	591	2026-05-07	Antanimena	Anja	10087	RASMICANTE RAJ MITHALAL	4G	327395	4G_512 Ko	169000	2016-07-21	Résiliation	Mobilité géographique	départ définitif	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.364536+00	2026-06-19 11:05:24.364539+00
590	FID-2026-00592	592	2026-05-07	Antanimena	Jessica	308580	RANANJASON Julienne	4G	948325	4G_500Go	99000	2025-07-31	Résiliation	Mobilité géographique	déménagement	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.364564+00	2026-06-19 11:05:24.364567+00
591	FID-2026-00593	593	2026-05-08	Antanimena	Anja	39189	RAMAMONJISOA Solo Harilala	Airfiber	918398	Airfiber_Plus	189000	2018-07-07	Résiliation	Problème financier	annulation résiliation + basculement	Basculement	Cloturé	2026-05-08					Airfiber_Unlimited 20	99000		2026-07-31	[]	2026-06-19 11:05:24.364593+00	2026-06-19 11:05:24.364596+00
592	FID-2026-00594	594	2026-05-08	Antanimena	Tino	497549	RASOANIRINA Lalao Françoise	4G	946222	4G_500Go	99000	2025-07-14	Résiliation	Insatisfaction	insatisfaction débit	Résiliation	En Attente		Fitiavana	2026-07-31				0			[]	2026-06-19 11:05:24.364623+00	2026-06-19 11:05:24.364626+00
593	FID-2026-00595	595	2026-05-08	Antanimena	Anja	467945	RAKOTOSON Hanitra Andrianandrasana	4G	900871	4G_10Go	30000	2023-06-06	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-05-08					4G_10Go	30000			[]	2026-06-19 11:05:24.364651+00	2026-06-19 11:05:24.364654+00
594	FID-2026-00596	596	2026-05-11	Masay	Tino	46095	RAZAFINDRALAMBO Zo Andriniaina	4G	261367	4G_512 Ko	169000	2015-10-02	Résiliation	Insatisfaction	insatisfaction réseaux	Résiliation	En Attente			2026-09-30				0			[]	2026-06-19 11:05:24.36468+00	2026-06-19 11:05:24.364683+00
595	FID-2026-00597	597	2026-05-11	Masay	Tino	469805	RAZAKARIJAONA Andrianina Loic	4G	961109	4G_500Go	49000	2025-12-03	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-05-11						49000			[]	2026-06-19 11:05:24.364709+00	2026-06-19 11:05:24.364711+00
596	FID-2026-00598	598	2026-05-08	Antanimena	Fitiavana	459243	MAHAZAKA Clérmont Gervais	Airfiber	898187	Airfiber_Plus	0	2023-07-11	Résiliation	Insatisfaction	annulation + basculement	Annulation	En Attente	2026-05-26	Anja				Airfiber_Unlimited 20	99000		2026-07-31	[]	2026-06-19 11:05:24.364737+00	2026-06-19 11:05:24.364739+00
597	FID-2026-00599	599	2026-05-08	Antanimena	Fitiavana	363566	LANCELOT François Claude Joël	4G	769801	4G_Gold	94500	2019-11-22	Basculement	Autres	migration 4G vers Airfiber	Basculement	Cloturé	2026-05-08				971819	Airfiber_Unlimited 30	189000		2026-05-08	[]	2026-06-19 11:05:24.364765+00	2026-06-19 11:05:24.364768+00
598	FID-2026-00600	600	2026-05-08	Antanimena	Fitiavana	498300	RAKOTOMANGA Koloinando Mamiratra Malalatiana	4G	947227	4G_500Go	99000	2025-07-22	Résiliation	Insatisfaction	insatisfaction débit	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.364793+00	2026-06-19 11:05:24.364797+00
599	FID-2026-00601	601	2026-05-08	Antanimena	Anja	492677	RAVELOJAONA Veronirina Fanja Harilalao	4G	939793	4G_200Go	49000	2025-05-09	Upgrade	Autres	data insuffisant	Upgrade	En Attente	2026-05-31					4G_500Go	79000		2026-05-31	[]	2026-06-19 11:05:24.364822+00	2026-06-19 11:05:24.364825+00
600	FID-2026-00602	602	2026-05-09	Antanimena	Tino	254632	RANDRIAMBELO Hasina Ranjamalala Romaine	Airfiber	898554	Airfiber_Plus	189000	2023-07-13	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente		Anja	2026-07-31				0			[]	2026-06-19 11:05:24.36485+00	2026-06-19 11:05:24.364853+00
601	FID-2026-00603	603	2026-05-09	Antanimena	Anja	85106	RAFIDISON Soloniaina Narindra	Airfiber	925980	Airfiber_Plus	0	2017-08-30	Résiliation	Autres	annulation résiliation + basculement	Basculement	En Attente	2026-08-30				971997	Airfiber_VIP	99000		2026-08-30	[]	2026-06-19 11:05:24.364879+00	2026-06-19 11:05:24.364882+00
602	FID-2026-00604	604	2026-05-09	Antanimena	Anja	374336	MAHEFARISON Itokiana Ghislain	4G	939830	4G_500Go	99000	2025-05-10	Downgrade	Problème financier	problème financier + non utilisation	Downgrade	En Attente	2026-05-31					4G_200Go	49000		2026-05-31	[]	2026-06-19 11:05:24.364908+00	2026-06-19 11:05:24.364911+00
603	FID-2026-00605	605	2026-05-12	Antanimena	Jessica	497296	ANDRIATINANIRINA Ando Romeo	4G	945892	4G_200Go	49000	2025-07-10	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.364936+00	2026-06-19 11:05:24.364939+00
604	FID-2026-00606	606	2026-05-12	Masay	Tino	474053	VALISOA Harilalaina	4G	912852	4G_200Go	49000	2025-06-30	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-05-12						49000			[]	2026-06-19 11:05:24.364964+00	2026-06-19 11:05:24.364967+00
605	FID-2026-00607	607	2026-05-12	Masay	Tino	494665	ARIRAVAKINIAINA Anja Mbolatiavina/ TAHIRISOA Nandrandraina	4G	947277	4G_200Go	49000	2025-07-22	Résiliation	Autres	basculemnt en prépayée	Basculement	En Attente	2026-07-31					4G_Prépayé	0		2026-07-31	[]	2026-06-19 11:05:24.364993+00	2026-06-19 11:05:24.364996+00
606	FID-2026-00608	608	2026-05-13	Masay	Fitiavana	444766	ANDRIAMANALINAAndritiana Princia	Airfiber	948184	Airfiber_Unlimited 20	99000	2025-07-31	Résiliation	Autres	Augmentation tarifaire	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365022+00	2026-06-19 11:05:24.365024+00
607	FID-2026-00609	609	2026-05-13	Antanimena	Anja	471091	ANDRIAMAMPIRODO Onitiana Valerie	Airfiber	938161	Airfiber_Unlimited 20	99000	2025-04-25	Basculement	Autres	Prolongation prix promo U20	Basculement	Cloturé	2026-05-13				972136	Airfiber_Unlimited 20	99000		2026-05-31	[]	2026-06-19 11:05:24.36505+00	2026-06-19 11:05:24.365053+00
608	FID-2026-00610	610	2026-05-13	Antanimena	Tino	468058	ANDRIAMASY Hery Harison	Airfiber	901156	Airfiber_Plus	0	2023-06-21	Résiliation	Autres	annulation résiliation + basculement	Basculement	En Attente	2026-05-13	Jessica			972131	Airfiber_Unlimited 30	99000		2026-06-01	[]	2026-06-19 11:05:24.365083+00	2026-06-19 11:05:24.365086+00
609	FID-2026-00611	611	2026-05-13	Antanimena	Anja	99991	RALAHINOMENJANAHARY Liantsoa Mankasitraka	4G	904699	4G_200Go	99000	2023-12-01	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-05-13						99000			[]	2026-06-19 11:05:24.36514+00	2026-06-19 11:05:24.365145+00
610	FID-2026-00612	612	2026-05-13	Antanimena	Anja	99991	RALAHINOMENJANAHARY Liantsoa Mankasitraka	4G	479647	4G_Gold	189000	2017-10-14	Résiliation	Insatisfaction	lenteur débit	Refusée	Cloturé	2026-05-13						189000			[]	2026-06-19 11:05:24.365174+00	2026-06-19 11:05:24.365177+00
611	FID-2026-00613	613	2026-05-15	Antanimena	Anja	451850	RAMANITRASAHOLY Landiniaina	Airfiber	898464	Airfiber_Plus	0	2023-07-13	Résiliation	Autres	annulation résiliation + basculement	Basculement	En Attente	2026-05-15					Airfiber_Unlimited 20	99000		2026-07-13	[]	2026-06-19 11:05:24.365203+00	2026-06-19 11:05:24.365206+00
612	FID-2026-00614	614	2026-05-15	Antanimena	Anja	451850	RAMANITRASAHOLY Landiniaina	4G	972200	4G_200Go	0	2023-05-15	Basculement	Autres	rajout 4G + basculement en Unlimited 20	Basculement	Cloturé	2026-05-15				972200	4G_200Go	49000		2026-07-13	[]	2026-06-19 11:05:24.365232+00	2026-06-19 11:05:24.365235+00
613	FID-2026-00615	615	2026-05-15	Antanimena	Jessica	497356	ANDRIANALINTSOA Mendrika Jaela	4G	945979	4G_200Go	49000	2025-07-11	Résiliation	Mobilité géographique	départ	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365261+00	2026-06-19 11:05:24.365264+00
614	FID-2026-00616	616	2026-05-15	Antanimena	Jessica	44344	RAVOSON Olisoa	4G	903317	4G_Litebox 50Go	99000	2023-09-29	Basculement	Autres	data insuffisant	Basculement	Cloturé	2026-05-15				972207	4G_1T	99000		2026-05-15	[]	2026-06-19 11:05:24.36529+00	2026-06-19 11:05:24.365293+00
615	FID-2026-00617	617	2026-05-15	Masay	Tino	461287	RAKOTOARIMANANA Mahandry Ny Aina Fihorenantsoa	Airfiber	889189	Airfiber_Plus	189000	2022-07-20	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365318+00	2026-06-19 11:05:24.365321+00
616	FID-2026-00618	618	2026-05-15	Masay	Tino	483195	RAFIDISON Lovaniaina Patricia	4G	963550	4G_500Go	49000	2026-01-05	Résiliation	Autres	Problème banque	Refusée	Cloturé	2026-05-15						49000			[]	2026-06-19 11:05:24.365346+00	2026-06-19 11:05:24.365349+00
617	FID-2026-00619	619	2026-05-15	Antanimena	Jessica	9838	AMADEA	4G	569547	4G_Gold	189000	2018-07-26	Résiliation	Insatisfaction	Insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365375+00	2026-06-19 11:05:24.365377+00
618	FID-2026-00620	620	2026-05-15	Antanimena	Jessica	42627	RANDRIAMANANAZY Soloniaina Guy	Airfiber	950700	Airfiber_Unlimited 50	149000	2025-08-31	Résiliation	Problème financier	problème financier	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.365403+00	2026-06-19 11:05:24.365406+00
619	FID-2026-00621	621	2026-05-16	Antanimena	Fitiavana	468186	ANDRIANARIMANANA Tsiory Fanomezana	Airfiber	915962	Airfiber_Plus	189000	2024-07-31	Résiliation	Problème financier	problème financier	Résiliation	En Attente		Jessica	2026-07-31				0			[]	2026-06-19 11:05:24.365432+00	2026-06-19 11:05:24.365435+00
620	FID-2026-00622	622	2026-05-16	Antanimena	Jessica	470938	RASOLOFONIAINA Koloina Christel/ ANDRIANTAHINJANAHARY TSIMANARSON Narindrandraibe Princy	4G	947082	4G_200Go	49000	2025-07-19	Résiliation	Autres	data insuffisant	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365461+00	2026-06-19 11:05:24.365464+00
621	FID-2026-00623	623	2026-05-18	Masay	Tino	495288	RAZAFIMAMONJY Rary/RAZAFIMAMONJY Manony	4G	943270	4G_200Go	49000	2025-06-11	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-05-18						49000			[]	2026-06-19 11:05:24.365489+00	2026-06-19 11:05:24.365492+00
622	FID-2026-00624	624	2026-05-18	Masay	Tino	455258	RASOLOHARINILAINA Hasina Nokoloina Espérance	Airfiber	875712	Airfiber_Ultra	249000	2021-05-05	Basculement	Autres	basculement	Basculement	Cloturé	2026-05-18					Airfiber_Unlimited 50	249000		2026-05-18	[]	2026-06-19 11:05:24.365518+00	2026-06-19 11:05:24.36552+00
623	FID-2026-00625	625	2026-05-18	Antanimena	Jessica	59055	WEI Xian	4G	497733	4G_512 Ko	169000	2016-09-02	Résiliation	Mobilité géographique	déménagement	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.365547+00	2026-06-19 11:05:24.365549+00
624	FID-2026-00626	626	2026-05-18	Antanimena	Jessica	498602	RAMANAMPAMONJY Andry Mampionona Fifaliana/ ANDRIANAKANGA Minoharimenja Diana	4G	947618	4G_200Go	49000	2025-07-26	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365575+00	2026-06-19 11:05:24.365578+00
625	FID-2026-00627	627	2026-05-19	Antanimena	Jessica	489274	RANARISON Mialinirina Dolly	Airfiber	935079	Airfiber_First	149000	2025-03-25	Résiliation	Autres	Non utilisation	Refusée	Cloturé	2026-05-19					Airfiber_First	149000			[]	2026-06-19 11:05:24.365603+00	2026-06-19 11:05:24.365606+00
626	FID-2026-00628	628	2026-05-19	Masay	Tino	481466	RAMAMIARIMANANA Haja Tahina Clement	4G	924471	4G_200Go	49000	2024-12-01	Résiliation	Mobilité géographique	Affecté	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.365631+00	2026-06-19 11:05:24.365634+00
627	FID-2026-00629	629	2026-05-19	Masay	Tino	96616	LABO MEN SARL /RAZAFIMBOLA Ho wing Mine Lucette	4G	475705	4G_Gold	0	2017-09-29	Basculement	Autres	basculement	Basculement	Cloturé	2026-05-19				972341	Airfiber_Unlimited 30	189000		2026-05-19	[]	2026-06-19 11:05:24.365659+00	2026-06-19 11:05:24.365662+00
628	FID-2026-00630	630	2026-05-19	Masay	Tino	515238	OPHONE TELECOM SARLU	4G	969041	4G_500Go	79000	2026-03-26	Résiliation	Problème financier	problème travail	Refusée	Cloturé	2026-05-19						79000			[]	2026-06-19 11:05:24.365687+00	2026-06-19 11:05:24.36569+00
629	FID-2026-00631	631	2026-05-19	Antanimena	Jessica	456729	RABENAIVOARIVELO Andrianirina Juliot	Airfiber	909524	Airfiber_Plus	189000	2024-04-30	Résiliation	Insatisfaction	insatisfaction débit	Refusée	Cloturé	2026-05-19						0			[]	2026-06-19 11:05:24.365715+00	2026-06-19 11:05:24.365718+00
630	FID-2026-00632	632	2026-05-19	Antanimena	Jessica	46511	RALANTOMAHEFA	4G	671393	4G_512 Ko	84500	2015-10-22	Basculement	Autres	migration 4G vers Airfiber	Basculement	Cloturé	2026-05-19				972375	Airfiber_Unlimited 30	189000		2026-05-19	[]	2026-06-19 11:05:24.365744+00	2026-06-19 11:05:24.365747+00
631	FID-2026-00633	633	2026-05-19	Antanimena	Anja	470836	ANDRIANANTENAINA Ando	4G	917471	4G_200Go	49000	2025-08-31	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.365772+00	2026-06-19 11:05:24.365775+00
632	FID-2026-00634	634	2026-05-20	Antanimena	Jessica	501589	RANDRIANOELINA Andrianavony Jules	4G	951506	4G_200Go	49000	2025-09-13	Changement de Nom	Autres	changement de nom	Changement de Nom	En Attente	2026-06-01				951506	4G_200Go	49000	Raoelimamy Angolatiana Tsiorimalala	2025-09-13	[]	2026-06-19 11:05:24.365801+00	2026-06-19 11:05:24.365804+00
633	FID-2026-00635	635	2026-05-20	Antanimena	Jessica	499810	RATODIARISOA Haingo Lalao	4G	949188	4G_200Go	49000	2025-08-12	Résiliation	Insatisfaction	insatisfaction débits	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.36583+00	2026-06-19 11:05:24.365833+00
634	FID-2026-00636	636	2026-05-20	Antanimena	Jessica	497984	RAVOLOLOMAMPIANINA Hanitrarivelo	4G	946813	4G_500Go	99000	2025-07-16	Résiliation	Autres	Cessation d'activité	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.36586+00	2026-06-19 11:05:24.365863+00
635	FID-2026-00637	637	2026-05-22	Antanimena	Anja	6056	IFPA- Institut de Formation Professionne	4G	869977	4G_Gold	189000	2012-07-27	Résiliation	Insatisfaction	lenteur débit	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365889+00	2026-06-19 11:05:24.365892+00
636	FID-2026-00638	638	2026-05-22	Antanimena	Fitiavana	498449	RALISON Nandrianina Gracia	4G	947426	4G_200Go	49000	2025-07-24	Résiliation	Insatisfaction	lenteur débit	Résiliation	En Attente		Jessica	2026-07-31				0			[]	2026-06-19 11:05:24.365918+00	2026-06-19 11:05:24.365921+00
637	FID-2026-00639	639	2026-05-22	Antanimena	Jessica	498573	RANDRIAMAMPIONONA Uluc	4G	947578	4G_200Go	49000	2025-07-26	Résiliation	Insatisfaction	insatisfaction technique	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.365947+00	2026-06-19 11:05:24.36595+00
638	FID-2026-00640	640	2026-05-22	Antanimena	Anja	39900	RANDRIANARISOLOFO Tsirinaina Henintsoa	Airfiber	949985	Airfiber_Unlimited 20	99000	2025-08-27	Résiliation	Double emploi	double emploi NS AF VIP	Résiliation	En Attente			2026-08-30				0			[]	2026-06-19 11:05:24.365976+00	2026-06-19 11:05:24.365979+00
639	FID-2026-00641	641	2026-05-22	Antanimena	Jessica	7532	RAHELIMANANTSOA Rondro Lucette	4G	756712	4G_200Go	84500	2011-09-06	Basculement	Autres	migration 4G vers Airfiber	Basculement	Cloturé	2026-05-22				972542	Airfiber_Unlimited 50	169000		2026-05-22	[]	2026-06-19 11:05:24.366004+00	2026-06-19 11:05:24.366007+00
640	FID-2026-00642	642	2026-05-22	Antanimena	Jessica	274011	RAZANAMAHERY Clémentine	4G	912829	4G_200Go	189000	2024-06-10	Basculement	Autres	NS plus intéressante et moins chère	Basculement	Cloturé	2026-05-22				972549	Airfiber_Unlimited 50	149000		2026-05-22	[]	2026-06-19 11:05:24.366034+00	2026-06-19 11:05:24.366037+00
641	FID-2026-00643	643	2026-05-22	Antanimena	Jessica	516691	BRUNEL Ryan Weshley	4G	972348	4G_200Go	49000	2026-05-19	Résiliation	Insatisfaction	offre non adaptée à son usage pro	Refusée	Cloturé	2026-05-22				972348	4G_200Go	49000			[]	2026-06-19 11:05:24.366063+00	2026-06-19 11:05:24.366066+00
642	FID-2026-00644	644	2026-05-20	Masay	Fitiavana	499119	N° 499119 - M. ROJOTIANA Santatra	Airfiber	948281	Airfiber_Unlimited 20	99000	2026-07-31	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente		Tino	2026-07-31				0			[]	2026-06-19 11:05:24.366096+00	2026-06-19 11:05:24.366098+00
643	FID-2026-00645	645	2026-05-20	Masay	Tino	23653	KOLINA Yvonne Heritiana	Airfiber	921686	Airfiber_Unlimited 20	169000	2013-04-02	Résiliation	Changement de projet	changement de projet	Refusée	Cloturé	2026-05-20						169000			[]	2026-06-19 11:05:24.36615+00	2026-06-19 11:05:24.366154+00
644	FID-2026-00646	646	2026-05-21	Masay	Anja	486875	TOVARA Angelo Emilien	4G	931905	4G_200Go	49000	2025-02-18	Résiliation	Mobilité géographique	afféctation	Résiliation	En Attente		Tino	2026-06-30				0			[]	2026-06-19 11:05:24.366182+00	2026-06-19 11:05:24.366185+00
645	FID-2026-00647	647	2026-05-21	Masay	Tino	514354	RAMONJAMANANA Rivo Andrianaivo Nirina	YzyTv	967837	YzyTv_	31000	2026-03-07	Changement de Nom	Autres	changement de nom	Changement de Nom	Cloturé	2026-05-21						31000	HAJANIAINA Rinah Willy		[]	2026-06-19 11:05:24.366212+00	2026-06-19 11:05:24.366215+00
646	FID-2026-00648	648	2026-05-21	Masay	Tino	8099	RANDRIAMANALINA Nirinah Gérard	Airfiber	554762	Airfiber_Ultra	249000	2018-04-16	Basculement	Autres	basculement	Basculement	Cloturé	2026-05-21				972463	Airfiber_Unlimited 50	249000		2026-05-21	[]	2026-06-19 11:05:24.366241+00	2026-06-19 11:05:24.366244+00
647	FID-2026-00649	649	2026-05-22	Masay	Tino	472919	RASONARIVO Rihatiana Harson	Airfiber	910946	Airfiber_First	0	2024-05-14	Résiliation	Autres	annulation + basculement	Annulation	Cloturé	2026-05-22				972501	Airfiber_Unlimited 50	149000		2026-05-22	[]	2026-06-19 11:05:24.36627+00	2026-06-19 11:05:24.366273+00
648	FID-2026-00650	650	2026-05-26	Masay	Tino	467817	RAZANAJATOVO Rina Sedera/ RAMILISON Eddy Aina	4G	945846	4G_200Go	49000	2025-07-09	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-05-26						49000			[]	2026-06-19 11:05:24.3663+00	2026-06-19 11:05:24.366303+00
649	FID-2026-00651	651	2026-05-26	Antanimena	Anja	7685	ANDRIANAIVO Alain Paul	4G	549528	4G_512 Ko	0	2011-06-18	Résiliation	Problème financier	annulation + basculement	Annulation	En Attente	2026-06-30					4G_200Go	49000		2026-06-30	[]	2026-06-19 11:05:24.366329+00	2026-06-19 11:05:24.366332+00
650	FID-2026-00652	652	2026-05-26	Antanimena	Anja	448463	RANDRIAMANANA Mino Ranto	Airfiber	947790	Airfiber_Unlimited 50	149000	2025-07-31	Résiliation	Mobilité géographique	affectation province	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.366359+00	2026-06-19 11:05:24.366362+00
651	FID-2026-00653	653	2026-05-26	Antanimena	Anja	469001	RAHANDONANDRASANA Romis Afabitana	4G	930508	4G_Litebox 200Go	49000	2025-02-09	Upgrade	Insatisfaction	lenteur débit	Upgrade	Cloturé	2026-05-26				972658	Airfiber_Unlimited 20	99000		2026-05-26	[]	2026-06-19 11:05:24.366388+00	2026-06-19 11:05:24.366391+00
652	FID-2026-00654	654	2026-05-26	Antanimena	Fitiavana	467457	RAKOTOMANANA Jean Claude	Airfiber	899559	Airfiber_Plus	189000	2023-04-03	Résiliation	Problème financier	problème financier/ personnel	Refusée	Cloturé	2026-05-26						0			[]	2026-06-19 11:05:24.366417+00	2026-06-19 11:05:24.36642+00
653	FID-2026-00655	655	2026-05-26	Antanimena	Fitiavana	470863	ANDRIAMITONDRA Maeva Tiana Jessica	4G	933230	4G_200Go	49000	2025-03-04	Upgrade	Insatisfaction	upgrade + basculement	Upgrade	Cloturé	2026-05-26				972675	4G_500Go	99000		2026-05-26	[]	2026-06-19 11:05:24.366446+00	2026-06-19 11:05:24.366449+00
654	FID-2026-00656	656	2026-05-26	Antanimena	Fitiavana	480598	RAMBOA Harinirina Ravelo	4G	944044	4G_200Go	49000	2025-06-20	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-06-30				0			[]	2026-06-19 11:05:24.366475+00	2026-06-19 11:05:24.366477+00
655	FID-2026-00657	657	2026-05-26	Antanimena	Anja	360939	ANDRIANTSIMBA Jaona Mbinintsoa	Airfiber	946681	Airfiber_Unlimited 20	0	2025-07-16	Résiliation	Autres	annulation + basculement	Annulation	Cloturé					972717	Airfiber_Unlimited 50	149000		2026-07-31	[]	2026-06-19 11:05:24.366503+00	2026-06-19 11:05:24.366506+00
656	FID-2026-00658	658	2026-05-26	Antanimena	Fitiavana	471147	ODILE Germaine	4G	946039	4G_200Go	49000	2025-07-11	Résiliation	Problème financier	problème financier	Refusée	Cloturé	2026-05-26					4G_200Go	49000			[]	2026-06-19 11:05:24.366532+00	2026-06-19 11:05:24.366535+00
657	FID-2026-00659	659	2026-05-26	Antanimena	Fitiavana	468289	RANARIVOLOLONA Felantsoa	4G	901812	4G_10Go	0	2023-07-26	Résiliation	Insatisfaction	data insuffisant	Annulation	Cloturé	2026-05-26					4G_200Go	49000		2026-05-26	[]	2026-06-19 11:05:24.366561+00	2026-06-19 11:05:24.366564+00
658	FID-2026-00660	660	2026-05-28	Antanimena	Anja	13315	RAVOLANORO Rosa	Airfiber	918968	Airfiber_Plus	0	2020-07-30	Résiliation	Autres	annulation + basculement	Annulation	En Attente	2026-07-30					Airfiber_Unlimited 20	99000		2026-07-30	[]	2026-06-19 11:05:24.36659+00	2026-06-19 11:05:24.366593+00
659	FID-2026-00661		2026-05-26	Masay	Tino	443270	RABEARINOSY Kanty Razafitseheno	Airfiber	898946	Airfiber_Plus	189000	2023-07-11	Résiliation	Insatisfaction	insatisfaction réseaux	Refusée	Cloturé	2026-05-26						189000			[]	2026-06-19 11:05:24.366619+00	2026-06-19 11:05:24.366622+00
660	FID-2026-00662		2026-05-28	Masay	Tino	488462	RANDRIAMIHAJA Fanomezantsoa Alain	4G	950856	4G_200Go	49000	2025-09-03	Résiliation	Double emploi	double emploi	Résiliation	En Attente			2026-09-30				0			[]	2026-06-19 11:05:24.366647+00	2026-06-19 11:05:24.36665+00
661	FID-2026-00663		2026-05-28	Masay	Tino	499079	RATIAHAVANA Dimbisoa Landry	4G	948233	4G_200Go	49000	2025-07-31	Résiliation	Changement de projet	changement de projet	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.366677+00	2026-06-19 11:05:24.36668+00
662	FID-2026-00664		2026-05-28	Masay	Tino	456639	RATOVONIRINA Inna Toky	4G	948181	4G_200Go	49000	2025-07-31	Résiliation	Insatisfaction	insatisfaction réseaux	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.366706+00	2026-06-19 11:05:24.366708+00
663	FID-2026-00665		2026-05-28	Masay	Tino	497388	BRUSCAGNIN Tiana Miranda	4G	946019	4G_200Go	49000	2025-07-11	Résiliation	Insatisfaction	insatisfaction réseaux	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.366734+00	2026-06-19 11:05:24.366737+00
664	FID-2026-00666		2026-05-28	Antanimena	Jessica	475664	RASOANIAINA Riana Lydie / RANDRIANJATOVO Lova Henintsoa	4G	947965	4G_200Go	49000	2025-07-29	Résiliation	Insatisfaction	insatisfaction	Résiliation	En Attente			2026-07-31				0			[]	2026-06-19 11:05:24.366762+00	2026-06-19 11:05:24.366765+00
\.


--
-- Data for Name: core_refitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_refitem (id, category, value, "order") FROM stdin;
1	Sites	Antanimena	0
2	Sites	Masay	1
3	Agents	Anja	0
4	Agents	Fitiavana	1
5	Agents	Jessica	2
6	Agents	Nathalie	3
7	Agents	Sabine	4
8	Agents	Tino	5
9	Agents	sabine	6
10	Technologies	3G	0
11	Technologies	4G	1
12	Technologies	Airfiber	2
13	Technologies	YzyTv	3
14	Produits	3G_500	0
15	Produits	4G_10Go	1
16	Produits	4G_200Go	2
17	Produits	4G_30Go	3
18	Produits	4G_400Go	4
19	Produits	4G_500Go	5
20	Produits	4G_50Go	6
21	Produits	4G_BOX postpayé 65Go	7
22	Produits	4G_85Go	8
23	Produits	4G_Gold	9
24	Produits	4G_Litebox 10Go	10
25	Produits	4G_Litebox 200Go	11
26	Produits	4G_Litebox 30Go	12
27	Produits	Airfiber_First	13
28	Produits	Airfiber_Plus	14
29	Produits	Airfiber_Pro+	15
30	Produits	Airfiber_Ultra	16
31	Produits	Airfiber_VIP	17
32	Produits	Airfiber_Unlimited 20	18
33	Produits	Airfiber_Unlimited 30	19
34	Produits	Airfiber_Unlimited 50	20
35	Produits	4G_512 Ko	21
36	Produits	4G_Litebox 500Go	22
37	Produits	4G_Litebox Prépayé	23
38	Produits	4G_Litebox 50Go	24
39	Produits	4G_Prépayé	25
40	Produits	4G_20Go	26
41	Produits	4G_65Go	27
42	Produits	4G_5Go	28
43	Produits	4G_1T	29
44	Produits	YzyTv_	30
45	Requetes	Résiliation	0
46	Requetes	Basculement	1
47	Requetes	Upgrade	2
48	Requetes	Downgrade	3
49	Requetes	Changement de Nom	4
50	Requetes	Réactivation	5
51	Motifs	Mobilité géographique	0
52	Motifs	Problème financier	1
53	Motifs	Changement de projet	2
54	Motifs	Raison personnelle	3
55	Motifs	Insatisfaction	4
56	Motifs	Double emploi	5
57	Motifs	Zone Non Couvert	6
58	Motifs	Autres	7
59	Actions	Résiliation	0
60	Actions	Basculement	1
61	Actions	Upgrade	2
62	Actions	Downgrade	3
63	Actions	Refusée	4
64	Actions	Changement de Nom	5
65	Actions	Annulation	6
66	Actions	Réactivation	7
67	Actions	Aucun changement	8
68	Priorites	Faible	0
69	Priorites	Normale	1
70	Priorites	Haute	2
71	Priorites	Critique	3
72	Niveaux	En Attente	0
73	Niveaux	Cloturé	0
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	accounts	auditlogentry
7	accounts	role
8	accounts	user
9	accounts	notificationread
10	core	clientrecord
11	core	demande
12	core	refitem
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-06-19 11:05:22.04912+00
2	contenttypes	0002_remove_content_type_name	2026-06-19 11:05:22.058036+00
3	auth	0001_initial	2026-06-19 11:05:22.115988+00
4	auth	0002_alter_permission_name_max_length	2026-06-19 11:05:22.123973+00
5	auth	0003_alter_user_email_max_length	2026-06-19 11:05:22.130386+00
6	auth	0004_alter_user_username_opts	2026-06-19 11:05:22.137639+00
7	auth	0005_alter_user_last_login_null	2026-06-19 11:05:22.143126+00
8	auth	0006_require_contenttypes_0002	2026-06-19 11:05:22.145578+00
9	auth	0007_alter_validators_add_error_messages	2026-06-19 11:05:22.152255+00
10	auth	0008_alter_user_username_max_length	2026-06-19 11:05:22.158756+00
11	auth	0009_alter_user_last_name_max_length	2026-06-19 11:05:22.164845+00
12	auth	0010_alter_group_name_max_length	2026-06-19 11:05:22.171635+00
13	auth	0011_update_proxy_permissions	2026-06-19 11:05:22.177556+00
14	auth	0012_alter_user_first_name_max_length	2026-06-19 11:05:22.184902+00
15	accounts	0001_initial	2026-06-19 11:05:22.283822+00
16	admin	0001_initial	2026-06-19 11:05:22.312818+00
17	admin	0002_logentry_remove_auto_add	2026-06-19 11:05:22.32183+00
18	admin	0003_logentry_add_action_flag_choices	2026-06-19 11:05:22.328594+00
19	core	0001_initial	2026-06-19 11:05:22.381265+00
20	sessions	0001_initial	2026-06-19 11:05:22.395131+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Name: accounts_auditlogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_auditlogentry_id_seq', 1, false);


--
-- Name: accounts_notificationread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_notificationread_id_seq', 1, false);


--
-- Name: accounts_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_role_id_seq', 5, true);


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: core_clientrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_clientrecord_id_seq', 640, true);


--
-- Name: core_demande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_demande_id_seq', 664, true);


--
-- Name: core_refitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_refitem_id_seq', 73, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 20, true);


--
-- Name: accounts_auditlogentry accounts_auditlogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_auditlogentry
    ADD CONSTRAINT accounts_auditlogentry_pkey PRIMARY KEY (id);


--
-- Name: accounts_notificationread accounts_notificationread_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_notificationread
    ADD CONSTRAINT accounts_notificationread_pkey PRIMARY KEY (id);


--
-- Name: accounts_notificationread accounts_notificationread_user_id_notif_id_2dbc7015_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_notificationread
    ADD CONSTRAINT accounts_notificationread_user_id_notif_id_2dbc7015_uniq UNIQUE (user_id, notif_id);


--
-- Name: accounts_role accounts_role_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_role
    ADD CONSTRAINT accounts_role_key_key UNIQUE (key);


--
-- Name: accounts_role accounts_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_role
    ADD CONSTRAINT accounts_role_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_login_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_login_key UNIQUE (login);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: core_clientrecord core_clientrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_clientrecord
    ADD CONSTRAINT core_clientrecord_pkey PRIMARY KEY (id);


--
-- Name: core_clientrecord core_clientrecord_refnum_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_clientrecord
    ADD CONSTRAINT core_clientrecord_refnum_key UNIQUE (refnum);


--
-- Name: core_demande core_demande_fid_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_demande
    ADD CONSTRAINT core_demande_fid_id_key UNIQUE (fid_id);


--
-- Name: core_demande core_demande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_demande
    ADD CONSTRAINT core_demande_pkey PRIMARY KEY (id);


--
-- Name: core_refitem core_refitem_category_value_46efedba_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_refitem
    ADD CONSTRAINT core_refitem_category_value_46efedba_uniq UNIQUE (category, value);


--
-- Name: core_refitem core_refitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_refitem
    ADD CONSTRAINT core_refitem_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: accounts_notificationread_user_id_2d149268; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_notificationread_user_id_2d149268 ON public.accounts_notificationread USING btree (user_id);


--
-- Name: accounts_role_key_82a0f15e_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_role_key_82a0f15e_like ON public.accounts_role USING btree (key varchar_pattern_ops);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_login_c2ed0b12_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_login_c2ed0b12_like ON public.accounts_user USING btree (login varchar_pattern_ops);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: core_clientrecord_refnum_b7cdf157_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_clientrecord_refnum_b7cdf157_like ON public.core_clientrecord USING btree (refnum varchar_pattern_ops);


--
-- Name: core_demande_fid_id_8945d7ef_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_demande_fid_id_8945d7ef_like ON public.core_demande USING btree (fid_id varchar_pattern_ops);


--
-- Name: core_demande_refnum_34b30bd4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_demande_refnum_34b30bd4 ON public.core_demande USING btree (refnum);


--
-- Name: core_demande_refnum_34b30bd4_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_demande_refnum_34b30bd4_like ON public.core_demande USING btree (refnum varchar_pattern_ops);


--
-- Name: core_refitem_category_242bb6f5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_refitem_category_242bb6f5 ON public.core_refitem USING btree (category);


--
-- Name: core_refitem_category_242bb6f5_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_refitem_category_242bb6f5_like ON public.core_refitem USING btree (category varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: accounts_notificationread accounts_notificationread_user_id_2d149268_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_notificationread
    ADD CONSTRAINT accounts_notificationread_user_id_2d149268_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict x370ScUhS49KwThcKAKnUBG0UHyvJMYOsYYDMRxfjShqNPn0UGjo9ZuclBmfHU6

