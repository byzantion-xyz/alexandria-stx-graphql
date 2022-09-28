SET check_function_bodies = false;
CREATE FUNCTION public.notify_block() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
	begin 
		perform pg_notify( cast('new_block' as text), new.height::TEXT);
	    return null;
	end
$$;
CREATE TABLE public.block (
    hash character varying NOT NULL,
    height bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    block jsonb NOT NULL
);
CREATE TABLE public.transaction (
    hash character varying NOT NULL,
    tx jsonb NOT NULL,
    processed boolean DEFAULT false NOT NULL,
    missing boolean DEFAULT false NOT NULL,
    contract_id text GENERATED ALWAYS AS (((tx -> 'contract_call'::text) ->> 'contract_id'::text)) STORED,
    block_height bigint GENERATED ALWAYS AS (((tx -> 'block_height'::text))::bigint) STORED
);
ALTER TABLE ONLY public.block
    ADD CONSTRAINT block_hash_pkey PRIMARY KEY (hash);
ALTER TABLE ONLY public.block
    ADD CONSTRAINT block_height_ukey UNIQUE (height);
ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (hash);
CREATE INDEX transaction_block_height ON public.transaction USING btree (block_height);
CREATE INDEX transaction_contract_id ON public.transaction USING btree (contract_id);
CREATE TRIGGER notify_blocks AFTER INSERT ON public.block FOR EACH ROW EXECUTE FUNCTION public.notify_block();
