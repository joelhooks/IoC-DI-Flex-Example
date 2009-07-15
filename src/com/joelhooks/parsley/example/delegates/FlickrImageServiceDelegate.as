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
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.Photo;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.adobe.webapis.flickr.methodgroups.Photos;
	import com.joelhooks.parsley.example.events.GalleryEvent;
	import com.joelhooks.parsley.example.models.vo.Gallery;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.factory.IDispatcherBean;

	public class FlickrImageServiceDelegate extends EventDispatcher implements IGalleryImageServiceDelegate, IDispatcherBean
	{
		private var service:FlickrService;
		private var photos:Photos;
		
		public var apiKey:String;
		public var secret:String;
		public var NSID:String;
		
		private var _dispatcher:IEventDispatcher;

		public function set dispatcher(v:IEventDispatcher):void
		{
			_dispatcher = v;
		}

		public function FlickrImageServiceDelegate()
		{
		}
		

		public function loadGallery():void
		{
			if(!this.service)
			{
				this.service = new FlickrService(this.apiKey);
			}
			else
			{
				throw new Error("No Service");
			}
			service.addEventListener(FlickrResultEvent.INTERESTINGNESS_GET_LIST, handleSearchResult);
			service.interestingness.getList()
		}
		
		protected function handleSearchResult(event:FlickrResultEvent):void
		{
			this.processFlickrPhotoResults(event.data.photos.photos);
		}
		
		protected function processFlickrPhotoResults(results:Array):void
		{
			var gallery:Gallery = new Gallery();
			gallery.photos = new ArrayCollection();
			for each(var flickrPhoto:Photo in results)
			{
				var photo:GalleryImage = new GalleryImage()
				var baseURL:String = 'http://farm' + flickrPhoto.farmId + '.static.flickr.com/' + flickrPhoto.server + '/' + flickrPhoto.id + '_' + flickrPhoto.secret;
				photo.thumbURL = baseURL + '_s.jpg';
				photo.URL = baseURL + '.jpg';
				gallery.photos.addItem( photo );
			}
			
			this._dispatcher.dispatchEvent(new GalleryEvent(GalleryEvent.GALLERY_LOADED, gallery));
		}
	}
}