{{ config(materialized='table') }}

with udlCase as (

  Select top 1 * from DWH_SDL.SF."Case"

)

select *
from udlCase
