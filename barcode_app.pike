//
//
//  barcode_minder.pike: A GTK+ based barcode scanner tool
//
//  Copyright 2002 by Bill Welliver <hww3@riverweb.com>
//
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
//  USA.
//
//

constant cvs_version="$Id: barcode_app.pike,v 1.1.1.1 2002-06-28 20:41:03 hww3 Exp $";

#include "config.h"

inherit "util.pike";

object win,status;
int cont;

mapping preferences=([]);

int main(int argc, string* argv) {

 if(file_stat( getenv("HOME")+"/.pgtkrc" ))
    GTK.parse_rc( cpp(Stdio.read_bytes(getenv("HOME")+"/.pgtkrc")) );

write("Starting " + APP_NAME+ " " + APP_VERSION + "...\n");

// let's load the preferences.

preferences=loadPreferences();

// start up the ui...

Gnome.init(APP_WINNAME, APP_VERSION , argv);
win=Gnome.App(APP_NAME, APP_NAME);
win->set_usize(600,400);

setupStatus();
win->signal_connect(GTK.delete_event, appQuit, 0);
win->show();

return -1;
}

void appQuit()

{
  _exit(0);
}

void openAbout()
{
  object aboutWindow;
  aboutWindow = Gnome.About(APP_NAME,
				APP_VERSION, "(c) " + APP_AUTHOR + " " + APP_YEAR,
				({APP_AUTHOR}),
				APP_DESCRIPTION,
				"icons/spiral.png");
  aboutWindow->show();
  return;
 }

void openPreferences()
{
  object aboutWindow;
  aboutWindow = Gnome.About(APP_NAME,
				APP_VERSION, "(c) Bill Welliver 2002",
				({"Bill Welliver", ""}),
				"Manage your LDAP directory with style.",
				"icons/spiral.png");
  aboutWindow->show();
  return;
 }

void setupStatus()
{
  status=GTK.Statusbar();
  status->set_usize(0,19);
  cont=status->get_context_id("Main Application");
  status->push(cont, APP_NAME + " Ready.");
  win->set_statusbar(status);

}

void pushStatus(string stat)
{  
//  status->pop(cont);
  status->push(cont, stat);
  call_out(popStatus, 5);
}

void popStatus()
{  
  status->pop(cont);
//  status->push(cont, stat);

}

