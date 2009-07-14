/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.delegates
{
	import flash.events.Event;

	public interface IGalleryImageServiceDelegate
	{
		function init():void;
		function loadGallery():void;
	}
}