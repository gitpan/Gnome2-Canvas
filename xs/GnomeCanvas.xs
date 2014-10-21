/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the 
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
 * Boston, MA  02111-1307  USA.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/GnomeCanvas/xs/GnomeCanvas.xs,v 1.3 2003/07/08 03:15:34 muppetman Exp $
 */
#include "gnomecanvasperl.h"

SV *
newSVArtAffine (double affine[6])
{
	AV * a;
	
	if (!affine)
		return &PL_sv_undef;
		
	a = newAV();
	
	av_push (a, newSVnv (affine[0]));
	av_push (a, newSVnv (affine[1]));
	av_push (a, newSVnv (affine[2]));
	av_push (a, newSVnv (affine[3]));
	av_push (a, newSVnv (affine[4]));
	av_push (a, newSVnv (affine[5]));

	return newRV_noinc ((SV*)a);
}

double*
SvArtAffine (SV * sv)
{
	AV * av;
	double * affine;
	if ((!sv) || (!SvOK (sv)) || (!SvRV (sv)) ||
	    (SvTYPE (SvRV(sv)) != SVt_PVAV) ||
	    5 != av_len ((AV*) SvRV (sv)))
		croak ("affine transforms must be expressed as a reference to an array containing the six transform values");
	av = (AV*) SvRV (sv);
	affine = gperl_alloc_temp (6 * sizeof (double));
	affine[0] = SvNV (*av_fetch (av, 0, 0));
	affine[1] = SvNV (*av_fetch (av, 1, 0));
	affine[2] = SvNV (*av_fetch (av, 2, 0));
	affine[3] = SvNV (*av_fetch (av, 3, 0));
	affine[4] = SvNV (*av_fetch (av, 4, 0));
	affine[5] = SvNV (*av_fetch (av, 5, 0));
	return affine;
}

MODULE = Gnome2::Canvas	PACKAGE = Gnome2::Canvas	PREFIX = gnome_canvas_

BOOT:
#include "register.xsh"
#include "boot.xsh"


SV *
members (canvas)
	GnomeCanvas * canvas
    ALIAS:
	aa = 1
    CODE:
	switch (ix) {
		case 1: RETVAL = newSViv (canvas->aa); break;
	}
    OUTPUT:
	RETVAL

##  GtkWidget *gnome_canvas_new (void) 
GtkWidget *
gnome_canvas_new (class)
	SV * class
    C_ARGS:
	

##  GtkWidget *gnome_canvas_new_aa (void) 
GtkWidget *
gnome_canvas_new_aa (class)
	SV * class
    C_ARGS:
	

##  GnomeCanvasGroup *gnome_canvas_root (GnomeCanvas *canvas) 
GnomeCanvasGroup *
gnome_canvas_root (canvas)
	GnomeCanvas *canvas

##  void gnome_canvas_set_scroll_region (GnomeCanvas *canvas, double x1, double y1, double x2, double y2) 
void
gnome_canvas_set_scroll_region (canvas, x1, y1, x2, y2)
	GnomeCanvas *canvas
	double x1
	double y1
	double x2
	double y2

##  void gnome_canvas_get_scroll_region (GnomeCanvas *canvas, double *x1, double *y1, double *x2, double *y2) 

void gnome_canvas_get_scroll_region (GnomeCanvas *canvas, OUTLIST double x1, OUTLIST double y1, OUTLIST double x2, OUTLIST double y2) 

##  void gnome_canvas_set_center_scroll_region (GnomeCanvas *canvas, gboolean center_scroll_region) 
void
gnome_canvas_set_center_scroll_region (canvas, center_scroll_region)
	GnomeCanvas *canvas
	gboolean center_scroll_region

##  gboolean gnome_canvas_get_center_scroll_region (GnomeCanvas *canvas) 
gboolean
gnome_canvas_get_center_scroll_region (canvas)
	GnomeCanvas *canvas

##  void gnome_canvas_set_pixels_per_unit (GnomeCanvas *canvas, double n) 
void
gnome_canvas_set_pixels_per_unit (canvas, n)
	GnomeCanvas *canvas
	double n

##  void gnome_canvas_scroll_to (GnomeCanvas *canvas, int cx, int cy) 
void
gnome_canvas_scroll_to (canvas, cx, cy)
	GnomeCanvas *canvas
	int cx
	int cy

##  void gnome_canvas_get_scroll_offsets (GnomeCanvas *canvas, int *cx, int *cy) 
void gnome_canvas_get_scroll_offsets (GnomeCanvas *canvas, OUTLIST int cx, OUTLIST int cy)

##  void gnome_canvas_update_now (GnomeCanvas *canvas) 
void
gnome_canvas_update_now (canvas)
	GnomeCanvas *canvas

##  GnomeCanvasItem *gnome_canvas_get_item_at (GnomeCanvas *canvas, double x, double y) 
GnomeCanvasItem *
gnome_canvas_get_item_at (canvas, x, y)
	GnomeCanvas *canvas
	double x
	double y

###  void gnome_canvas_request_redraw_uta (GnomeCanvas *canvas, ArtUta *uta) 
#void
#gnome_canvas_request_redraw_uta (canvas, uta)
#	GnomeCanvas *canvas
#	ArtUta *uta

##  void gnome_canvas_request_redraw (GnomeCanvas *canvas, int x1, int y1, int x2, int y2) 
void
gnome_canvas_request_redraw (canvas, x1, y1, x2, y2)
	GnomeCanvas *canvas
	int x1
	int y1
	int x2
	int y2

##  void gnome_canvas_w2c_affine (GnomeCanvas *canvas, double affine[6]) 
void
gnome_canvas_w2c_affine (canvas, a)
	GnomeCanvas *canvas
	SV * a
    C_ARGS:
	canvas, SvArtAffine (a)

##  void gnome_canvas_w2c (GnomeCanvas *canvas, double wx, double wy, int *cx, int *cy) 
##  void gnome_canvas_w2c_d (GnomeCanvas *canvas, double wx, double wy, double *cx, double *cy) 
void gnome_canvas_w2c_d (GnomeCanvas *canvas, double wx, double wy, OUTLIST double cx, OUTLIST double cy) 
    ALIAS:
	Gnome2::Canvas::w2c = 1
	Gnome2::Canvas::w2c_d = 2


##  void gnome_canvas_c2w (GnomeCanvas *canvas, int cx, int cy, double *wx, double *wy) 
void gnome_canvas_c2w (GnomeCanvas *canvas, int cx, int cy, OUTLIST double wx, OUTLIST double wy) 

##  void gnome_canvas_window_to_world (GnomeCanvas *canvas, double winx, double winy, double *worldx, double *worldy) 
void gnome_canvas_window_to_world (GnomeCanvas *canvas, double winx, double winy, OUTLIST double worldx, OUTLIST double worldy) 

##  void gnome_canvas_world_to_window (GnomeCanvas *canvas, double worldx, double worldy, double *winx, double *winy) 
void gnome_canvas_world_to_window (GnomeCanvas *canvas, double worldx, double worldy, OUTLIST double winx, OUTLIST double winy) 

##  int gnome_canvas_get_color (GnomeCanvas *canvas, const char *spec, GdkColor *color) 
int
gnome_canvas_get_color (canvas, spec, color)
	GnomeCanvas *canvas
	const char *spec
	GdkColor *color

##  gulong gnome_canvas_get_color_pixel (GnomeCanvas *canvas, guint rgba) 
gulong
gnome_canvas_get_color_pixel (canvas, rgba)
	GnomeCanvas *canvas
	guint rgba

##  void gnome_canvas_set_stipple_origin (GnomeCanvas *canvas, GdkGC *gc) 
void
gnome_canvas_set_stipple_origin (canvas, gc)
	GnomeCanvas *canvas
	GdkGC *gc

##  void gnome_canvas_set_dither (GnomeCanvas *canvas, GdkRgbDither dither) 
void
gnome_canvas_set_dither (canvas, dither)
	GnomeCanvas *canvas
	GdkRgbDither dither

##  GdkRgbDither gnome_canvas_get_dither (GnomeCanvas *canvas) 
GdkRgbDither
gnome_canvas_get_dither (canvas)
	GnomeCanvas *canvas

