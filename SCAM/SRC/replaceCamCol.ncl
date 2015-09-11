
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin
  fn_CAM_o    = "/glade/scratch/ginochen/SCAM/cami_0000-01-01_64x128_L30_c090102_original.nc"
  fn_CAM_m    = "/glade/scratch/ginochen/SCAM/cami_0000-01-01_64x128_L30_c090102_modify.nc"
  fn_CAMiop   = "/glade/p/cesmdata/cseg/inputdata/atm/cam/scam/iop/TOGAII_4scam.nc" ; need only the lat lon 
  in_CAM_o    = addfile(fn_CAM_o,"r") ; "r" for read-only, "w" for read-write
  in_CAM_m    = addfile(fn_CAM_m,"w") ; 
  in_CAMiop   = addfile(fn_CAMiop,"r")

;----------------------
;  CAM dimension
;----------------------
  lev     = in_CAM_o->lev  
  lat     = in_CAM_o->lat
  lon     = in_CAM_o->lon
  latiop  = in_CAMiop->lat   ; the lat lon has to be fixed to the IOP case for SCAM
  loniop  = in_CAMiop->lon
  time = 0
  it = 0

;----------------------
; IOP lat/lon index
;----------------------
  ilatiop = minind(abs(latiop - lat)) ; get the nearest lat/lon index for iop in cami.nc
  iloniop = minind(abs(loniop - lon))
  print("IOP ilat ilon =")
  print((/ilatiop, iloniop/))

;-----------------------------------------
; Read in some fields from original ncdata
;-----------------------------------------
  ;CUSH = in_CAM_o->CUSH
  ;T    = in_CAM_o->T 

;--------------------------------------------------------------------
; Replace some fields with zeros to see if this changes QTEND in h0
;  ( check out var_scamNeeded.txt )
;--------------------------------------------------------------------
  
  CUSH(it,ilatiop,iloniop) = 0
  ;T(it,:,ilatiop,iloniop) = 0
;  pblh = 0

;-----------------------------------------
; Write out some fields to modified ncdata
;-----------------------------------------
  in_CAM_m->CUSH = (/CUSH/)
  ;in_CAM_m->T    = (/T/)
;  in_CAM_m->




end

