-- Create test topics table
CREATE TABLE public.test_topics (
    topic_id uuid NOT NULL,
    topic_name character varying(30) NOT NULL,
    topic_abbr character varying(20) NOT NULL,
    channel_id uuid NOT NULL,
    channel_name character varying NOT NULL,
    sort_order integer NOT NULL
);


-- Populate the topics
INSERT INTO public.test_topics VALUES ('bff2f961-337f-42cb-a3bb-146e67ab584b', 'Whole Numbers', 'L1S1_WHLN', 'f3f6bf4b-9c42-4b6f-bd90-bece1418a415', 'Level 1 - Section 1', 1);
INSERT INTO public.test_topics VALUES ('ceaebceb-cc42-4416-b719-57607dd5086b', 'Geometry of 2-D shapes', 'L1S1_GO2S', 'f3f6bf4b-9c42-4b6f-bd90-bece1418a415', 'Level 1 - Section 1', 2);
INSERT INTO public.test_topics VALUES ('3cdc3a2f-6c42-47d0-b62e-630520ac6daa', 'Whole numbers', 'L1S2_WHLN', '3a126f04-1a9e-4127-978b-b6544a099d0d', 'Level 1 - Section 2', 1);
INSERT INTO public.test_topics VALUES ('6731e1c6-8bed-4470-b679-c8ea1ae1f8ca', 'Common fractions', 'L1S2_CMMF', '3a126f04-1a9e-4127-978b-b6544a099d0d', 'Level 1 - Section 2', 2);
INSERT INTO public.test_topics VALUES ('00b627cb-87df-4ca3-848e-1e47d0b97322', 'Whole numbers', 'L1S3_WHLN', '03761fe9-a242-4e9e-bd36-7fbae14dc134', 'Level 1 - Section 3', 1);
INSERT INTO public.test_topics VALUES ('fff244f3-1c96-421a-915d-2aeed240040b', 'Common fractions', 'L1S3_CMMF', '03761fe9-a242-4e9e-bd36-7fbae14dc134', 'Level 1 - Section 3', 2);
INSERT INTO public.test_topics VALUES ('7c255f62-e5b4-4f7b-80d8-131bbc1e14ef', 'Data Handling', 'L1S3_DTHN', '03761fe9-a242-4e9e-bd36-7fbae14dc134', 'Level 1 - Section 3', 3);
INSERT INTO public.test_topics VALUES ('dffa0aca-e1a8-4e0f-b3a1-27bdc9e49b68', 'Length', 'L1S3_LNGT', '03761fe9-a242-4e9e-bd36-7fbae14dc134', 'Level 1 - Section 3', 4);
INSERT INTO public.test_topics VALUES ('79a90672-5395-49e1-9f35-e3bad1bbe791', 'Whole numbers', 'L1S4_WHLN', 'f12e2f67-d589-4b34-bb94-2484d880c4a6', 'Level 1 - Section 4', 1);
INSERT INTO public.test_topics VALUES ('e21f1e0e-3ded-4bd4-bda3-b5be7d0ba615', 'Whole numbers', 'L2S1_WHLN', 'f6e8f1f5-69c5-4bc5-8ecb-54d826cd3783', 'Level 2 - Section 1', 1);
INSERT INTO public.test_topics VALUES ('cf624b4e-bf21-4d65-bea5-b8b3ed34a81e', 'Common fractions', 'L2S2_CMMF', '5126a907-e528-4345-847c-8ca749c8cd9b', 'Level 2 - Section 2', 1);
INSERT INTO public.test_topics VALUES ('5a8898ed-e35c-447e-91ac-da16502051fd', 'Common fractions', 'L2S3_CMMF', 'c32737bf-2647-4dc8-a81d-e3d093075830', 'Level 2 - Section 3', 1);
INSERT INTO public.test_topics VALUES ('461b7890-af68-4285-b97f-a10ffc13ac81', 'Numeric patterns', 'L2S3_NMRP', 'c32737bf-2647-4dc8-a81d-e3d093075830', 'Level 2 - Section 3', 2);
INSERT INTO public.test_topics VALUES ('e38e0e86-fcb9-4bee-a947-9e7fa9cf52d0', 'Geometry of 2-D shapes', 'L2S4_GO2S', '0985900c-047a-4173-8e79-6f19d9b57ed5', 'Level 2 - Section 4', 1);
INSERT INTO public.test_topics VALUES ('0c796733-7df7-4115-af42-a0acdf13193f', 'Length', 'L2S4_LNGT', '0985900c-047a-4173-8e79-6f19d9b57ed5', 'Level 2 - Section 4', 2);
INSERT INTO public.test_topics VALUES ('eb1569c9-0f4d-4f53-995b-50f347f0ec09', 'Perimeter of 2-D shapes', 'L2S4_PO2S', '0985900c-047a-4173-8e79-6f19d9b57ed5', 'Level 2 - Section 4', 3);
INSERT INTO public.test_topics VALUES ('903bb1dc-a2ab-454e-a839-2b6e41665231', 'Symmetry', 'L2S4_SYMM', '0985900c-047a-4173-8e79-6f19d9b57ed5', 'Level 2 - Section 4', 4);
INSERT INTO public.test_topics VALUES ('9a800485-57da-44dd-9282-ca3acd8b0bb8', 'Data Handling (or Statistics)', 'L2S4_DHS', '0985900c-047a-4173-8e79-6f19d9b57ed5', 'Level 2 - Section 4', 5);
INSERT INTO public.test_topics VALUES ('30a2ec18-b23d-4ac7-a16e-85cc0e3e2d1d', 'Whole numbers', 'L3S1_WHLN', 'c0302f6c-d062-4778-bc8d-d7a2b91d09b4', 'Level 3 - Section 1', 1);
INSERT INTO public.test_topics VALUES ('4677ce86-328f-4202-b6f9-125fa3c8c5c1', 'Common fractions', 'L3S2_CMMF', 'ddf25e8f-cde8-4e89-9811-8daffb2d8655', 'Level 3 - Section 2', 1);
INSERT INTO public.test_topics VALUES ('96c06b09-78cd-4311-8976-bae00a378df1', 'Decimal fractions', 'L3S3_DCMF', 'e2217b87-2f78-4190-a0a5-5c46e9ee8bc1', 'Level 3 - Section 3', 1);
INSERT INTO public.test_topics VALUES ('ad1eb534-720b-4640-a33f-17efcb71a449', 'Ratio and rate', 'L3S3_RTAR', 'e2217b87-2f78-4190-a0a5-5c46e9ee8bc1', 'Level 3 - Section 3', 2);
INSERT INTO public.test_topics VALUES ('25c55e12-6e84-4945-91fb-c75c1fb3ee95', 'Geometry of 3-D objects', 'L3S3_GO3O', 'e2217b87-2f78-4190-a0a5-5c46e9ee8bc1', 'Level 3 - Section 3', 3);
INSERT INTO public.test_topics VALUES ('4a135459-9a67-4b66-985f-2a250cbd19e5', 'Geometry of straight lines', 'L3S3_GOSL', 'e2217b87-2f78-4190-a0a5-5c46e9ee8bc1', 'Level 3 - Section 3', 4);
INSERT INTO public.test_topics VALUES ('66e438ba-6d50-4f6f-8cdc-583a6e7c0a88', 'Length', 'L3S4_LNGT', 'f908fac9-fe56-44b9-96ab-e25dfbd530bc', 'Level 3 - Section 4', 1);
INSERT INTO public.test_topics VALUES ('6ffa3009-0f7c-4443-956a-4b0893f55131', 'Area of 2-D shapes', 'L3S4_AO2S', 'f908fac9-fe56-44b9-96ab-e25dfbd530bc', 'Level 3 - Section 4', 2);
INSERT INTO public.test_topics VALUES ('35e1d755-74bd-4180-8c91-05a0d3111119', 'Data Handling (or Statistics)', 'L3S4_DHS', 'f908fac9-fe56-44b9-96ab-e25dfbd530bc', 'Level 3 - Section 4', 3);
INSERT INTO public.test_topics VALUES ('1a1adda4-e249-4d41-ac3a-2d64d42847b3', 'Whole numbers', 'L4S1_WHLN', 'd4b44e6d-d4de-450e-bbc7-99085ba656e5', 'Level 4 - Section 1', 1);
INSERT INTO public.test_topics VALUES ('c61f2c8d-175d-4782-a9e7-ed5d837dcfd1', 'Common fractions', 'L4S1_CMMF', 'd4b44e6d-d4de-450e-bbc7-99085ba656e5', 'Level 4 - Section 1', 2);
INSERT INTO public.test_topics VALUES ('0b471720-958f-46cb-b091-a9a8ffd9fa6e', 'Decimal fractions', 'L4S2_DCMF', '763eafc2-4e68-4dbe-8f54-c9a22dd63599', 'Level 4 - Section 2', 1);
INSERT INTO public.test_topics VALUES ('205e5ea7-ef7c-4942-83c3-d66654d55569', 'Percentages', 'L4S3_PRCN', '7de1d8ec-a487-4856-b508-c1a4f51a839e', 'Level 4 - Section 3', 1);
INSERT INTO public.test_topics VALUES ('c057229d-2c6d-47f1-885b-92900fe646cf', 'Ratio and rate', 'L4S3_RTAR', '7de1d8ec-a487-4856-b508-c1a4f51a839e', 'Level 4 - Section 3', 2);
INSERT INTO public.test_topics VALUES ('307c8e31-7009-4c8a-bfc6-0af6126347e7', 'Geometry of 3-D objects', 'L4S4_GO3O', '904d419f-53e2-4b6f-b60d-2aca7e729683', 'Level 4 - Section 4', 1);
INSERT INTO public.test_topics VALUES ('c7aec453-7643-475b-a094-8351e16e58b8', 'Geometry of straight lines', 'L4S4_GOSL', '904d419f-53e2-4b6f-b60d-2aca7e729683', 'Level 4 - Section 4', 2);
INSERT INTO public.test_topics VALUES ('eea79ea3-e84b-4bba-bb94-32e237ac16b7', 'Area of 2-D shapes', 'L4S4_AO2S', '904d419f-53e2-4b6f-b60d-2aca7e729683', 'Level 4 - Section 4', 3);
INSERT INTO public.test_topics VALUES ('54bcecdc-c79e-4254-aa9b-a768eec09221', 'Volume of 3-D objects', 'L4S4_VO3O', '904d419f-53e2-4b6f-b60d-2aca7e729683', 'Level 4 - Section 4', 4);
INSERT INTO public.test_topics VALUES ('7898918b-87b8-4bea-8ce4-7015d9ef49e4', 'Data Handling (or Statistics)', 'L4S4_DHS', '904d419f-53e2-4b6f-b60d-2aca7e729683', 'Level 4 - Section 4', 5);
INSERT INTO public.test_topics VALUES ('663a0623-3222-4e31-80f3-2ad835730f53', 'Common fractions', 'L5S1_CMMF', '5b679315-a02c-4035-9505-fc84701c482d', 'Level 5 - Section 1', 1);
INSERT INTO public.test_topics VALUES ('b49021eb-d8de-43f5-a38b-0d92dac616b1', 'Decimal fractions', 'L5S1_DCMF', '5b679315-a02c-4035-9505-fc84701c482d', 'Level 5 - Section 1', 2);
INSERT INTO public.test_topics VALUES ('bee32dff-712c-4404-a1c6-bea7dc77d135', 'Percentages', 'L5S2_PRCN', 'a5cd9f9f-000e-4145-9a95-875d7dfd3e68', 'Level 5 - Section 2', 1);
INSERT INTO public.test_topics VALUES ('d3a3d366-ae76-4ff5-a614-a6a2a8c9b250', 'Exponents', 'L5S2_EXPN', 'a5cd9f9f-000e-4145-9a95-875d7dfd3e68', 'Level 5 - Section 2', 2);
INSERT INTO public.test_topics VALUES ('41bb354e-2606-4e9d-ac02-b488a736c4be', 'Finance', 'L5S2_FNNC', 'a5cd9f9f-000e-4145-9a95-875d7dfd3e68', 'Level 5 - Section 2', 3);
INSERT INTO public.test_topics VALUES ('d1a5a4dd-f327-4d7a-820a-2bb0645e9798', 'Algebraic graphs', 'L5S3_ALGG', '6c408923-2a72-447e-abbd-f83b7c5612a4', 'Level 5 - Section 3', 1);
INSERT INTO public.test_topics VALUES ('84b7c7ac-fe52-489c-b74e-12e80131cb08', 'Negative numbers', 'L5S3_NGTN', '6c408923-2a72-447e-abbd-f83b7c5612a4', 'Level 5 - Section 3', 2);
INSERT INTO public.test_topics VALUES ('4365a2d8-3418-4cfc-9f0f-b69915b44d2a', 'Geometry of 2-D shapes', 'L5S4_GO2S', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 1);
INSERT INTO public.test_topics VALUES ('9fdfe485-c640-4124-be8e-89d4ad900c41', 'Ratio and rate', 'L5S4_RTAR', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 2);
INSERT INTO public.test_topics VALUES ('12016d47-c0a5-4ec8-b0ed-67a0f0ed11eb', 'Geometry of straight lines', 'L5S4_GOSL', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 3);
INSERT INTO public.test_topics VALUES ('473e31bb-5138-4afd-a11e-797640af8cdb', 'Area of 2-D shapes', 'L5S4_AO2S', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 4);
INSERT INTO public.test_topics VALUES ('52b7f620-f70b-4804-8d2f-882724bcf038', 'Transformations', 'L5S4_TRNS', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 5);
INSERT INTO public.test_topics VALUES ('a84a07c5-9de8-427c-b8d2-abdd037160e4', 'Volume of 3-D objects', 'L5S4_VO3O', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 6);
INSERT INTO public.test_topics VALUES ('ccdc3a6c-8d68-4f41-aeac-ff2b9b284d7b', 'Surface area of 3-D objects', 'L5S4_SAO3O', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 7);
INSERT INTO public.test_topics VALUES ('7506e584-60cb-42e7-9fbc-2d762a16bdb1', 'Probability', 'L5S4_PRBB', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 8);
INSERT INTO public.test_topics VALUES ('7aca4414-5aa4-477c-b789-46328a387fd8', 'Data Handling (or Statistics)', 'L5S4_DHS', '28f4920a-7b44-4e29-af4f-1e8d00ca332b', 'Level 5 - Section 4', 9);


-- Add constraints
ALTER TABLE ONLY public.test_topics
    ADD CONSTRAINT test_topics_pkey PRIMARY KEY (topic_id);