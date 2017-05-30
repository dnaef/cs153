
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 2f 10 80       	mov    $0x80102f10,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
	...

80100040 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	56                   	push   %esi
80100044:	53                   	push   %ebx
80100045:	83 ec 10             	sub    $0x10,%esp
80100048:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010004b:	8d 73 0c             	lea    0xc(%ebx),%esi
8010004e:	89 34 24             	mov    %esi,(%esp)
80100051:	e8 aa 42 00 00       	call   80104300 <holdingsleep>
80100056:	85 c0                	test   %eax,%eax
80100058:	74 62                	je     801000bc <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
8010005a:	89 34 24             	mov    %esi,(%esp)
8010005d:	e8 ce 42 00 00       	call   80104330 <releasesleep>

  acquire(&bcache.lock);
80100062:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100069:	e8 32 45 00 00       	call   801045a0 <acquire>
  b->refcnt--;
8010006e:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100071:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100074:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100076:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100079:	75 2f                	jne    801000aa <brelse+0x6a>
    // no one is waiting for it.
    b->next->prev = b->prev;
8010007b:	8b 43 54             	mov    0x54(%ebx),%eax
8010007e:	8b 53 50             	mov    0x50(%ebx),%edx
80100081:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100084:	8b 43 50             	mov    0x50(%ebx),%eax
80100087:	8b 53 54             	mov    0x54(%ebx),%edx
8010008a:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010008d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100092:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100099:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
8010009c:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
801000a1:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000a4:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
801000aa:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
801000b1:	83 c4 10             	add    $0x10,%esp
801000b4:	5b                   	pop    %ebx
801000b5:	5e                   	pop    %esi
801000b6:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
801000b7:	e9 94 44 00 00       	jmp    80104550 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
801000bc:	c7 04 24 c0 71 10 80 	movl   $0x801071c0,(%esp)
801000c3:	e8 08 03 00 00       	call   801003d0 <panic>
801000c8:	90                   	nop
801000c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	53                   	push   %ebx
801000d4:	83 ec 14             	sub    $0x14,%esp
801000d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801000da:	8d 43 0c             	lea    0xc(%ebx),%eax
801000dd:	89 04 24             	mov    %eax,(%esp)
801000e0:	e8 1b 42 00 00       	call   80104300 <holdingsleep>
801000e5:	85 c0                	test   %eax,%eax
801000e7:	74 10                	je     801000f9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801000e9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801000ec:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801000ef:	83 c4 14             	add    $0x14,%esp
801000f2:	5b                   	pop    %ebx
801000f3:	5d                   	pop    %ebp
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801000f4:	e9 67 1f 00 00       	jmp    80102060 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801000f9:	c7 04 24 c7 71 10 80 	movl   $0x801071c7,(%esp)
80100100:	e8 cb 02 00 00       	call   801003d0 <panic>
80100105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100110 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
80100110:	55                   	push   %ebp
80100111:	89 e5                	mov    %esp,%ebp
80100113:	57                   	push   %edi
80100114:	56                   	push   %esi
80100115:	53                   	push   %ebx
80100116:	83 ec 1c             	sub    $0x1c,%esp
80100119:	8b 75 08             	mov    0x8(%ebp),%esi
8010011c:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
8010011f:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100126:	e8 75 44 00 00       	call   801045a0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012b:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
80100131:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100137:	75 12                	jne    8010014b <bread+0x3b>
80100139:	eb 25                	jmp    80100160 <bread+0x50>
8010013b:	90                   	nop
8010013c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100140:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100143:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100149:	74 15                	je     80100160 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010014b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010014e:	75 f0                	jne    80100140 <bread+0x30>
80100150:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100153:	75 eb                	jne    80100140 <bread+0x30>
      b->refcnt++;
80100155:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100159:	eb 3f                	jmp    8010019a <bread+0x8a>
8010015b:	90                   	nop
8010015c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100160:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100166:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010016c:	75 0d                	jne    8010017b <bread+0x6b>
8010016e:	eb 58                	jmp    801001c8 <bread+0xb8>
80100170:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100173:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100179:	74 4d                	je     801001c8 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010017b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010017e:	85 c0                	test   %eax,%eax
80100180:	75 ee                	jne    80100170 <bread+0x60>
80100182:	f6 03 04             	testb  $0x4,(%ebx)
80100185:	75 e9                	jne    80100170 <bread+0x60>
      b->dev = dev;
80100187:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010018a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010018d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100193:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010019a:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801001a1:	e8 aa 43 00 00       	call   80104550 <release>
      acquiresleep(&b->lock);
801001a6:	8d 43 0c             	lea    0xc(%ebx),%eax
801001a9:	89 04 24             	mov    %eax,(%esp)
801001ac:	e8 bf 41 00 00       	call   80104370 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
801001b1:	f6 03 02             	testb  $0x2,(%ebx)
801001b4:	75 08                	jne    801001be <bread+0xae>
    iderw(b);
801001b6:	89 1c 24             	mov    %ebx,(%esp)
801001b9:	e8 a2 1e 00 00       	call   80102060 <iderw>
  }
  return b;
}
801001be:	83 c4 1c             	add    $0x1c,%esp
801001c1:	89 d8                	mov    %ebx,%eax
801001c3:	5b                   	pop    %ebx
801001c4:	5e                   	pop    %esi
801001c5:	5f                   	pop    %edi
801001c6:	5d                   	pop    %ebp
801001c7:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001c8:	c7 04 24 ce 71 10 80 	movl   $0x801071ce,(%esp)
801001cf:	e8 fc 01 00 00       	call   801003d0 <panic>
801001d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801001da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001e0 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	53                   	push   %ebx
  // head.next is most recently used.
  struct buf head;
} bcache;

void
binit(void)
801001e4:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
801001e9:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
801001ec:	c7 44 24 04 df 71 10 	movl   $0x801071df,0x4(%esp)
801001f3:	80 
801001f4:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801001fb:	e8 10 42 00 00       	call   80104410 <initlock>
  // head.next is most recently used.
  struct buf head;
} bcache;

void
binit(void)
80100200:	b8 dc fc 10 80       	mov    $0x8010fcdc,%eax

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100205:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
8010020c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010020f:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
80100216:	fc 10 80 
80100219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100220:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100223:	8d 43 0c             	lea    0xc(%ebx),%eax
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
80100226:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010022d:	89 04 24             	mov    %eax,(%esp)
80100230:	c7 44 24 04 e6 71 10 	movl   $0x801071e6,0x4(%esp)
80100237:	80 
80100238:	e8 93 41 00 00       	call   801043d0 <initsleeplock>
    bcache.head.next->prev = b;
8010023d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100242:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100245:	89 d8                	mov    %ebx,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
80100247:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010024d:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
80100253:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100259:	75 c5                	jne    80100220 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
8010025b:	83 c4 14             	add    $0x14,%esp
8010025e:	5b                   	pop    %ebx
8010025f:	5d                   	pop    %ebp
80100260:	c3                   	ret    
	...

80100270 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100276:	c7 44 24 04 ed 71 10 	movl   $0x801071ed,0x4(%esp)
8010027d:	80 
8010027e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100285:	e8 86 41 00 00       	call   80104410 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
8010028a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100291:	c7 05 8c 09 11 80 d0 	movl   $0x801005d0,0x8011098c
80100298:	05 10 80 
  devsw[CONSOLE].read = consoleread;
8010029b:	c7 05 88 09 11 80 d0 	movl   $0x801002d0,0x80110988
801002a2:	02 10 80 
  cons.locking = 1;
801002a5:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
801002ac:	00 00 00 

  picenable(IRQ_KBD);
801002af:	e8 1c 30 00 00       	call   801032d0 <picenable>
  ioapicenable(IRQ_KBD, 0);
801002b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801002bb:	00 
801002bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801002c3:	e8 98 1f 00 00       	call   80102260 <ioapicenable>
}
801002c8:	c9                   	leave  
801002c9:	c3                   	ret    
801002ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801002d0 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	57                   	push   %edi
801002d4:	56                   	push   %esi
801002d5:	53                   	push   %ebx
801002d6:	83 ec 3c             	sub    $0x3c,%esp
801002d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002dc:	8b 7d 08             	mov    0x8(%ebp),%edi
801002df:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002e2:	89 3c 24             	mov    %edi,(%esp)
801002e5:	e8 16 19 00 00       	call   80101c00 <iunlock>
  target = n;
801002ea:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002ed:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801002f4:	e8 a7 42 00 00       	call   801045a0 <acquire>
  while(n > 0){
801002f9:	85 db                	test   %ebx,%ebx
801002fb:	7f 2c                	jg     80100329 <consoleread+0x59>
801002fd:	e9 c0 00 00 00       	jmp    801003c2 <consoleread+0xf2>
80100302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(input.r == input.w){
      if(proc->killed){
80100308:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010030e:	8b 40 24             	mov    0x24(%eax),%eax
80100311:	85 c0                	test   %eax,%eax
80100313:	75 5b                	jne    80100370 <consoleread+0xa0>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100315:	c7 44 24 04 40 a5 10 	movl   $0x8010a540,0x4(%esp)
8010031c:	80 
8010031d:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100324:	e8 e7 36 00 00       	call   80103a10 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100329:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
8010032e:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100334:	74 d2                	je     80100308 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100336:	89 c2                	mov    %eax,%edx
80100338:	83 e2 7f             	and    $0x7f,%edx
8010033b:	0f b6 8a 40 ff 10 80 	movzbl -0x7fef00c0(%edx),%ecx
80100342:	0f be d1             	movsbl %cl,%edx
80100345:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80100348:	8d 50 01             	lea    0x1(%eax),%edx
    if(c == C('D')){  // EOF
8010034b:	83 7d d4 04          	cmpl   $0x4,-0x2c(%ebp)
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
8010034f:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
    if(c == C('D')){  // EOF
80100355:	74 3a                	je     80100391 <consoleread+0xc1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100357:	88 0e                	mov    %cl,(%esi)
    --n;
80100359:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010035c:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
80100360:	74 39                	je     8010039b <consoleread+0xcb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100362:	85 db                	test   %ebx,%ebx
80100364:	7e 35                	jle    8010039b <consoleread+0xcb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100366:	83 c6 01             	add    $0x1,%esi
80100369:	eb be                	jmp    80100329 <consoleread+0x59>
8010036b:	90                   	nop
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
80100370:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100377:	e8 d4 41 00 00       	call   80104550 <release>
        ilock(ip);
8010037c:	89 3c 24             	mov    %edi,(%esp)
8010037f:	e8 ec 18 00 00       	call   80101c70 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100384:	83 c4 3c             	add    $0x3c,%esp
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
80100387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010038c:	5b                   	pop    %ebx
8010038d:	5e                   	pop    %esi
8010038e:	5f                   	pop    %edi
8010038f:	5d                   	pop    %ebp
80100390:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100391:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100394:	76 05                	jbe    8010039b <consoleread+0xcb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100396:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
8010039b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010039e:	29 d8                	sub    %ebx,%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
801003a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801003a3:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801003aa:	e8 a1 41 00 00       	call   80104550 <release>
  ilock(ip);
801003af:	89 3c 24             	mov    %edi,(%esp)
801003b2:	e8 b9 18 00 00       	call   80101c70 <ilock>
801003b7:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
801003ba:	83 c4 3c             	add    $0x3c,%esp
801003bd:	5b                   	pop    %ebx
801003be:	5e                   	pop    %esi
801003bf:	5f                   	pop    %edi
801003c0:	5d                   	pop    %ebp
801003c1:	c3                   	ret    
  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
801003c2:	31 c0                	xor    %eax,%eax
801003c4:	eb da                	jmp    801003a0 <consoleread+0xd0>
801003c6:	8d 76 00             	lea    0x0(%esi),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003d0 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
801003d0:	55                   	push   %ebp
801003d1:	89 e5                	mov    %esp,%ebp
801003d3:	56                   	push   %esi
801003d4:	53                   	push   %ebx
801003d5:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003d8:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003d9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
801003df:	8d 75 d0             	lea    -0x30(%ebp),%esi
801003e2:	31 db                	xor    %ebx,%ebx
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
801003e4:	c7 05 74 a5 10 80 00 	movl   $0x0,0x8010a574
801003eb:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003ee:	0f b6 00             	movzbl (%eax),%eax
801003f1:	c7 04 24 f5 71 10 80 	movl   $0x801071f5,(%esp)
801003f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801003fc:	e8 6f 04 00 00       	call   80100870 <cprintf>
  cprintf(s);
80100401:	8b 45 08             	mov    0x8(%ebp),%eax
80100404:	89 04 24             	mov    %eax,(%esp)
80100407:	e8 64 04 00 00       	call   80100870 <cprintf>
  cprintf("\n");
8010040c:	c7 04 24 d6 76 10 80 	movl   $0x801076d6,(%esp)
80100413:	e8 58 04 00 00       	call   80100870 <cprintf>
  getcallerpcs(&s, pcs);
80100418:	8d 45 08             	lea    0x8(%ebp),%eax
8010041b:	89 74 24 04          	mov    %esi,0x4(%esp)
8010041f:	89 04 24             	mov    %eax,(%esp)
80100422:	e8 09 40 00 00       	call   80104430 <getcallerpcs>
80100427:	90                   	nop
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100428:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010042b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" %p", pcs[i]);
8010042e:	c7 04 24 11 72 10 80 	movl   $0x80107211,(%esp)
80100435:	89 44 24 04          	mov    %eax,0x4(%esp)
80100439:	e8 32 04 00 00       	call   80100870 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010043e:	83 fb 0a             	cmp    $0xa,%ebx
80100441:	75 e5                	jne    80100428 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
80100443:	c7 05 20 a5 10 80 01 	movl   $0x1,0x8010a520
8010044a:	00 00 00 
8010044d:	eb fe                	jmp    8010044d <panic+0x7d>
8010044f:	90                   	nop

80100450 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100450:	55                   	push   %ebp
80100451:	89 e5                	mov    %esp,%ebp
80100453:	57                   	push   %edi
80100454:	56                   	push   %esi
80100455:	89 c6                	mov    %eax,%esi
80100457:	53                   	push   %ebx
80100458:	83 ec 1c             	sub    $0x1c,%esp
  if(panicked){
8010045b:	83 3d 20 a5 10 80 00 	cmpl   $0x0,0x8010a520
80100462:	74 03                	je     80100467 <consputc+0x17>
80100464:	fa                   	cli    
80100465:	eb fe                	jmp    80100465 <consputc+0x15>
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
80100467:	3d 00 01 00 00       	cmp    $0x100,%eax
8010046c:	0f 84 ac 00 00 00    	je     8010051e <consputc+0xce>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100472:	89 04 24             	mov    %eax,(%esp)
80100475:	e8 96 58 00 00       	call   80105d10 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010047a:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
8010047f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100484:	89 ca                	mov    %ecx,%edx
80100486:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100487:	bf d5 03 00 00       	mov    $0x3d5,%edi
8010048c:	89 fa                	mov    %edi,%edx
8010048e:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
8010048f:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100492:	89 ca                	mov    %ecx,%edx
80100494:	c1 e3 08             	shl    $0x8,%ebx
80100497:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010049d:	89 fa                	mov    %edi,%edx
8010049f:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
801004a0:	0f b6 c0             	movzbl %al,%eax
801004a3:	09 c3                	or     %eax,%ebx

  if(c == '\n')
801004a5:	83 fe 0a             	cmp    $0xa,%esi
801004a8:	0f 84 fb 00 00 00    	je     801005a9 <consputc+0x159>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
801004ae:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801004b4:	0f 84 e1 00 00 00    	je     8010059b <consputc+0x14b>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004ba:	66 81 e6 ff 00       	and    $0xff,%si
801004bf:	66 81 ce 00 07       	or     $0x700,%si
801004c4:	66 89 b4 1b 00 80 0b 	mov    %si,-0x7ff48000(%ebx,%ebx,1)
801004cb:	80 
801004cc:	83 c3 01             	add    $0x1,%ebx

  if(pos < 0 || pos > 25*80)
801004cf:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004d5:	0f 87 b4 00 00 00    	ja     8010058f <consputc+0x13f>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
801004db:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004e1:	8d bc 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edi
801004e8:	7f 5d                	jg     80100547 <consputc+0xf7>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ea:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
801004ef:	b8 0e 00 00 00       	mov    $0xe,%eax
801004f4:	89 ca                	mov    %ecx,%edx
801004f6:	ee                   	out    %al,(%dx)
801004f7:	be d5 03 00 00       	mov    $0x3d5,%esi
801004fc:	89 d8                	mov    %ebx,%eax
801004fe:	c1 f8 08             	sar    $0x8,%eax
80100501:	89 f2                	mov    %esi,%edx
80100503:	ee                   	out    %al,(%dx)
80100504:	b8 0f 00 00 00       	mov    $0xf,%eax
80100509:	89 ca                	mov    %ecx,%edx
8010050b:	ee                   	out    %al,(%dx)
8010050c:	89 d8                	mov    %ebx,%eax
8010050e:	89 f2                	mov    %esi,%edx
80100510:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100511:	66 c7 07 20 07       	movw   $0x720,(%edi)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100516:	83 c4 1c             	add    $0x1c,%esp
80100519:	5b                   	pop    %ebx
8010051a:	5e                   	pop    %esi
8010051b:	5f                   	pop    %edi
8010051c:	5d                   	pop    %ebp
8010051d:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010051e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100525:	e8 e6 57 00 00       	call   80105d10 <uartputc>
8010052a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100531:	e8 da 57 00 00       	call   80105d10 <uartputc>
80100536:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010053d:	e8 ce 57 00 00       	call   80105d10 <uartputc>
80100542:	e9 33 ff ff ff       	jmp    8010047a <consputc+0x2a>
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
80100547:	83 eb 50             	sub    $0x50,%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054a:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100551:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100552:	8d bc 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100559:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
80100560:	80 
80100561:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100568:	e8 a3 41 00 00       	call   80104710 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056d:	b8 80 07 00 00       	mov    $0x780,%eax
80100572:	29 d8                	sub    %ebx,%eax
80100574:	01 c0                	add    %eax,%eax
80100576:	89 44 24 08          	mov    %eax,0x8(%esp)
8010057a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100581:	00 
80100582:	89 3c 24             	mov    %edi,(%esp)
80100585:	e8 b6 40 00 00       	call   80104640 <memset>
8010058a:	e9 5b ff ff ff       	jmp    801004ea <consputc+0x9a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010058f:	c7 04 24 15 72 10 80 	movl   $0x80107215,(%esp)
80100596:	e8 35 fe ff ff       	call   801003d0 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010059b:	31 c0                	xor    %eax,%eax
8010059d:	85 db                	test   %ebx,%ebx
8010059f:	0f 9f c0             	setg   %al
801005a2:	29 c3                	sub    %eax,%ebx
801005a4:	e9 26 ff ff ff       	jmp    801004cf <consputc+0x7f>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
801005a9:	89 da                	mov    %ebx,%edx
801005ab:	89 d8                	mov    %ebx,%eax
801005ad:	b9 50 00 00 00       	mov    $0x50,%ecx
801005b2:	83 c3 50             	add    $0x50,%ebx
801005b5:	c1 fa 1f             	sar    $0x1f,%edx
801005b8:	f7 f9                	idiv   %ecx
801005ba:	29 d3                	sub    %edx,%ebx
801005bc:	e9 0e ff ff ff       	jmp    801004cf <consputc+0x7f>
801005c1:	eb 0d                	jmp    801005d0 <consolewrite>
801005c3:	90                   	nop
801005c4:	90                   	nop
801005c5:	90                   	nop
801005c6:	90                   	nop
801005c7:	90                   	nop
801005c8:	90                   	nop
801005c9:	90                   	nop
801005ca:	90                   	nop
801005cb:	90                   	nop
801005cc:	90                   	nop
801005cd:	90                   	nop
801005ce:	90                   	nop
801005cf:	90                   	nop

801005d0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005d9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005dc:	8b 75 10             	mov    0x10(%ebp),%esi
801005df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
801005e2:	89 04 24             	mov    %eax,(%esp)
801005e5:	e8 16 16 00 00       	call   80101c00 <iunlock>
  acquire(&cons.lock);
801005ea:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801005f1:	e8 aa 3f 00 00       	call   801045a0 <acquire>
  for(i = 0; i < n; i++)
801005f6:	85 f6                	test   %esi,%esi
801005f8:	7e 16                	jle    80100610 <consolewrite+0x40>
801005fa:	31 db                	xor    %ebx,%ebx
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
80100600:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100604:	83 c3 01             	add    $0x1,%ebx
    consputc(buf[i] & 0xff);
80100607:	e8 44 fe ff ff       	call   80100450 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010060c:	39 de                	cmp    %ebx,%esi
8010060e:	7f f0                	jg     80100600 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100610:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100617:	e8 34 3f 00 00       	call   80104550 <release>
  ilock(ip);
8010061c:	8b 45 08             	mov    0x8(%ebp),%eax
8010061f:	89 04 24             	mov    %eax,(%esp)
80100622:	e8 49 16 00 00       	call   80101c70 <ilock>

  return n;
}
80100627:	83 c4 1c             	add    $0x1c,%esp
8010062a:	89 f0                	mov    %esi,%eax
8010062c:	5b                   	pop    %ebx
8010062d:	5e                   	pop    %esi
8010062e:	5f                   	pop    %edi
8010062f:	5d                   	pop    %ebp
80100630:	c3                   	ret    
80100631:	eb 0d                	jmp    80100640 <consoleintr>
80100633:	90                   	nop
80100634:	90                   	nop
80100635:	90                   	nop
80100636:	90                   	nop
80100637:	90                   	nop
80100638:	90                   	nop
80100639:	90                   	nop
8010063a:	90                   	nop
8010063b:	90                   	nop
8010063c:	90                   	nop
8010063d:	90                   	nop
8010063e:	90                   	nop
8010063f:	90                   	nop

80100640 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
  int c, doprocdump = 0;

  acquire(&cons.lock);
80100644:	31 ff                	xor    %edi,%edi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100646:	56                   	push   %esi
80100647:	53                   	push   %ebx
80100648:	83 ec 1c             	sub    $0x1c,%esp
8010064b:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010064e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100655:	e8 46 3f 00 00       	call   801045a0 <acquire>
8010065a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
80100660:	ff d6                	call   *%esi
80100662:	85 c0                	test   %eax,%eax
80100664:	89 c3                	mov    %eax,%ebx
80100666:	0f 88 98 00 00 00    	js     80100704 <consoleintr+0xc4>
    switch(c){
8010066c:	83 fb 10             	cmp    $0x10,%ebx
8010066f:	90                   	nop
80100670:	0f 84 32 01 00 00    	je     801007a8 <consoleintr+0x168>
80100676:	0f 8f a4 00 00 00    	jg     80100720 <consoleintr+0xe0>
8010067c:	83 fb 08             	cmp    $0x8,%ebx
8010067f:	90                   	nop
80100680:	0f 84 a8 00 00 00    	je     8010072e <consoleintr+0xee>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100686:	85 db                	test   %ebx,%ebx
80100688:	74 d6                	je     80100660 <consoleintr+0x20>
8010068a:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010068f:	89 c2                	mov    %eax,%edx
80100691:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100697:	83 fa 7f             	cmp    $0x7f,%edx
8010069a:	77 c4                	ja     80100660 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
8010069c:	83 fb 0d             	cmp    $0xd,%ebx
8010069f:	0f 84 0d 01 00 00    	je     801007b2 <consoleintr+0x172>
        input.buf[input.e++ % INPUT_BUF] = c;
801006a5:	89 c2                	mov    %eax,%edx
801006a7:	83 c0 01             	add    $0x1,%eax
801006aa:	83 e2 7f             	and    $0x7f,%edx
801006ad:	88 9a 40 ff 10 80    	mov    %bl,-0x7fef00c0(%edx)
801006b3:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(c);
801006b8:	89 d8                	mov    %ebx,%eax
801006ba:	e8 91 fd ff ff       	call   80100450 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801006bf:	83 fb 04             	cmp    $0x4,%ebx
801006c2:	0f 84 08 01 00 00    	je     801007d0 <consoleintr+0x190>
801006c8:	83 fb 0a             	cmp    $0xa,%ebx
801006cb:	0f 84 ff 00 00 00    	je     801007d0 <consoleintr+0x190>
801006d1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801006d7:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801006dc:	83 ea 80             	sub    $0xffffff80,%edx
801006df:	39 d0                	cmp    %edx,%eax
801006e1:	0f 85 79 ff ff ff    	jne    80100660 <consoleintr+0x20>
          input.w = input.e;
801006e7:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801006ec:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
801006f3:	e8 b8 31 00 00       	call   801038b0 <wakeup>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801006f8:	ff d6                	call   *%esi
801006fa:	85 c0                	test   %eax,%eax
801006fc:	89 c3                	mov    %eax,%ebx
801006fe:	0f 89 68 ff ff ff    	jns    8010066c <consoleintr+0x2c>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100704:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010070b:	e8 40 3e 00 00       	call   80104550 <release>
  if(doprocdump) {
80100710:	85 ff                	test   %edi,%edi
80100712:	0f 85 c2 00 00 00    	jne    801007da <consoleintr+0x19a>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100718:	83 c4 1c             	add    $0x1c,%esp
8010071b:	5b                   	pop    %ebx
8010071c:	5e                   	pop    %esi
8010071d:	5f                   	pop    %edi
8010071e:	5d                   	pop    %ebp
8010071f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100720:	83 fb 15             	cmp    $0x15,%ebx
80100723:	74 33                	je     80100758 <consoleintr+0x118>
80100725:	83 fb 7f             	cmp    $0x7f,%ebx
80100728:	0f 85 58 ff ff ff    	jne    80100686 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010072e:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100733:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100739:	0f 84 21 ff ff ff    	je     80100660 <consoleintr+0x20>
        input.e--;
8010073f:	83 e8 01             	sub    $0x1,%eax
80100742:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100747:	b8 00 01 00 00       	mov    $0x100,%eax
8010074c:	e8 ff fc ff ff       	call   80100450 <consputc>
80100751:	e9 0a ff ff ff       	jmp    80100660 <consoleintr+0x20>
80100756:	66 90                	xchg   %ax,%ax
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100758:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010075d:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100763:	75 2b                	jne    80100790 <consoleintr+0x150>
80100765:	e9 f6 fe ff ff       	jmp    80100660 <consoleintr+0x20>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100770:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100775:	b8 00 01 00 00       	mov    $0x100,%eax
8010077a:	e8 d1 fc ff ff       	call   80100450 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010077f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100784:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010078a:	0f 84 d0 fe ff ff    	je     80100660 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100790:	83 e8 01             	sub    $0x1,%eax
80100793:	89 c2                	mov    %eax,%edx
80100795:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100798:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010079f:	75 cf                	jne    80100770 <consoleintr+0x130>
801007a1:	e9 ba fe ff ff       	jmp    80100660 <consoleintr+0x20>
801007a6:	66 90                	xchg   %ax,%ax
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801007a8:	bf 01 00 00 00       	mov    $0x1,%edi
801007ad:	e9 ae fe ff ff       	jmp    80100660 <consoleintr+0x20>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007b2:	89 c2                	mov    %eax,%edx
801007b4:	83 c0 01             	add    $0x1,%eax
801007b7:	83 e2 7f             	and    $0x7f,%edx
801007ba:	c6 82 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%edx)
801007c1:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(c);
801007c6:	b8 0a 00 00 00       	mov    $0xa,%eax
801007cb:	e8 80 fc ff ff       	call   80100450 <consputc>
801007d0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801007d5:	e9 0d ff ff ff       	jmp    801006e7 <consoleintr+0xa7>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801007da:	83 c4 1c             	add    $0x1c,%esp
801007dd:	5b                   	pop    %ebx
801007de:	5e                   	pop    %esi
801007df:	5f                   	pop    %edi
801007e0:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801007e1:	e9 6a 2f 00 00       	jmp    80103750 <procdump>
801007e6:	8d 76 00             	lea    0x0(%esi),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	89 d6                	mov    %edx,%esi
801007f7:	53                   	push   %ebx
801007f8:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	74 04                	je     80100803 <printint+0x13>
801007ff:	85 c0                	test   %eax,%eax
80100801:	78 55                	js     80100858 <printint+0x68>
    x = -xx;
  else
    x = xx;
80100803:	31 ff                	xor    %edi,%edi
80100805:	31 c9                	xor    %ecx,%ecx
80100807:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100810:	31 d2                	xor    %edx,%edx
80100812:	f7 f6                	div    %esi
80100814:	0f b6 92 38 72 10 80 	movzbl -0x7fef8dc8(%edx),%edx
8010081b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
8010081e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
80100821:	85 c0                	test   %eax,%eax
80100823:	75 eb                	jne    80100810 <printint+0x20>

  if(sign)
80100825:	85 ff                	test   %edi,%edi
80100827:	74 08                	je     80100831 <printint+0x41>
    buf[i++] = '-';
80100829:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
8010082e:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
80100831:	8d 71 ff             	lea    -0x1(%ecx),%esi
80100834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100838:	0f be 04 33          	movsbl (%ebx,%esi,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010083c:	83 ee 01             	sub    $0x1,%esi
    consputc(buf[i]);
8010083f:	e8 0c fc ff ff       	call   80100450 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100844:	83 fe ff             	cmp    $0xffffffff,%esi
80100847:	75 ef                	jne    80100838 <printint+0x48>
    consputc(buf[i]);
}
80100849:	83 c4 1c             	add    $0x1c,%esp
8010084c:	5b                   	pop    %ebx
8010084d:	5e                   	pop    %esi
8010084e:	5f                   	pop    %edi
8010084f:	5d                   	pop    %ebp
80100850:	c3                   	ret    
80100851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
80100858:	f7 d8                	neg    %eax
8010085a:	bf 01 00 00 00       	mov    $0x1,%edi
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010085f:	eb a4                	jmp    80100805 <printint+0x15>
80100861:	eb 0d                	jmp    80100870 <cprintf>
80100863:	90                   	nop
80100864:	90                   	nop
80100865:	90                   	nop
80100866:	90                   	nop
80100867:	90                   	nop
80100868:	90                   	nop
80100869:	90                   	nop
8010086a:	90                   	nop
8010086b:	90                   	nop
8010086c:	90                   	nop
8010086d:	90                   	nop
8010086e:	90                   	nop
8010086f:	90                   	nop

80100870 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100870:	55                   	push   %ebp
80100871:	89 e5                	mov    %esp,%ebp
80100873:	57                   	push   %edi
80100874:	56                   	push   %esi
80100875:	53                   	push   %ebx
80100876:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100879:	8b 3d 74 a5 10 80    	mov    0x8010a574,%edi
  if(locking)
8010087f:	85 ff                	test   %edi,%edi
80100881:	0f 85 31 01 00 00    	jne    801009b8 <cprintf+0x148>
    acquire(&cons.lock);

  if (fmt == 0)
80100887:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010088a:	85 c9                	test   %ecx,%ecx
8010088c:	0f 84 37 01 00 00    	je     801009c9 <cprintf+0x159>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100892:	0f b6 01             	movzbl (%ecx),%eax
80100895:	85 c0                	test   %eax,%eax
80100897:	0f 84 8b 00 00 00    	je     80100928 <cprintf+0xb8>
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
8010089d:	8d 75 0c             	lea    0xc(%ebp),%esi
801008a0:	31 db                	xor    %ebx,%ebx
801008a2:	eb 3f                	jmp    801008e3 <cprintf+0x73>
801008a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801008a8:	83 fa 25             	cmp    $0x25,%edx
801008ab:	0f 84 af 00 00 00    	je     80100960 <cprintf+0xf0>
801008b1:	83 fa 64             	cmp    $0x64,%edx
801008b4:	0f 84 86 00 00 00    	je     80100940 <cprintf+0xd0>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801008ba:	b8 25 00 00 00       	mov    $0x25,%eax
801008bf:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008c2:	e8 89 fb ff ff       	call   80100450 <consputc>
      consputc(c);
801008c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008ca:	89 d0                	mov    %edx,%eax
801008cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008d0:	e8 7b fb ff ff       	call   80100450 <consputc>
801008d5:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008d8:	83 c3 01             	add    $0x1,%ebx
801008db:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
801008df:	85 c0                	test   %eax,%eax
801008e1:	74 45                	je     80100928 <cprintf+0xb8>
    if(c != '%'){
801008e3:	83 f8 25             	cmp    $0x25,%eax
801008e6:	75 e8                	jne    801008d0 <cprintf+0x60>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801008e8:	83 c3 01             	add    $0x1,%ebx
801008eb:	0f b6 14 19          	movzbl (%ecx,%ebx,1),%edx
    if(c == 0)
801008ef:	85 d2                	test   %edx,%edx
801008f1:	74 35                	je     80100928 <cprintf+0xb8>
      break;
    switch(c){
801008f3:	83 fa 70             	cmp    $0x70,%edx
801008f6:	74 0f                	je     80100907 <cprintf+0x97>
801008f8:	7e ae                	jle    801008a8 <cprintf+0x38>
801008fa:	83 fa 73             	cmp    $0x73,%edx
801008fd:	8d 76 00             	lea    0x0(%esi),%esi
80100900:	74 76                	je     80100978 <cprintf+0x108>
80100902:	83 fa 78             	cmp    $0x78,%edx
80100905:	75 b3                	jne    801008ba <cprintf+0x4a>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100907:	8b 06                	mov    (%esi),%eax
80100909:	31 c9                	xor    %ecx,%ecx
8010090b:	ba 10 00 00 00       	mov    $0x10,%edx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100910:	83 c3 01             	add    $0x1,%ebx
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100913:	83 c6 04             	add    $0x4,%esi
80100916:	e8 d5 fe ff ff       	call   801007f0 <printint>
8010091b:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010091e:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
80100922:	85 c0                	test   %eax,%eax
80100924:	75 bd                	jne    801008e3 <cprintf+0x73>
80100926:	66 90                	xchg   %ax,%ax
      consputc(c);
      break;
    }
  }

  if(locking)
80100928:	85 ff                	test   %edi,%edi
8010092a:	74 0c                	je     80100938 <cprintf+0xc8>
    release(&cons.lock);
8010092c:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100933:	e8 18 3c 00 00       	call   80104550 <release>
}
80100938:	83 c4 2c             	add    $0x2c,%esp
8010093b:	5b                   	pop    %ebx
8010093c:	5e                   	pop    %esi
8010093d:	5f                   	pop    %edi
8010093e:	5d                   	pop    %ebp
8010093f:	c3                   	ret    
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
80100940:	8b 06                	mov    (%esi),%eax
80100942:	b9 01 00 00 00       	mov    $0x1,%ecx
80100947:	ba 0a 00 00 00       	mov    $0xa,%edx
8010094c:	83 c6 04             	add    $0x4,%esi
8010094f:	e8 9c fe ff ff       	call   801007f0 <printint>
80100954:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
80100957:	e9 7c ff ff ff       	jmp    801008d8 <cprintf+0x68>
8010095c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100960:	b8 25 00 00 00       	mov    $0x25,%eax
80100965:	e8 e6 fa ff ff       	call   80100450 <consputc>
8010096a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
8010096d:	e9 66 ff ff ff       	jmp    801008d8 <cprintf+0x68>
80100972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100978:	8b 16                	mov    (%esi),%edx
8010097a:	b8 31 72 10 80       	mov    $0x80107231,%eax
8010097f:	83 c6 04             	add    $0x4,%esi
80100982:	85 d2                	test   %edx,%edx
80100984:	0f 44 d0             	cmove  %eax,%edx
        s = "(null)";
      for(; *s; s++)
80100987:	0f b6 02             	movzbl (%edx),%eax
8010098a:	84 c0                	test   %al,%al
8010098c:	0f 84 46 ff ff ff    	je     801008d8 <cprintf+0x68>
80100992:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100995:	89 d3                	mov    %edx,%ebx
80100997:	90                   	nop
        consputc(*s);
80100998:	0f be c0             	movsbl %al,%eax
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
8010099b:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
8010099e:	e8 ad fa ff ff       	call   80100450 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801009a3:	0f b6 03             	movzbl (%ebx),%eax
801009a6:	84 c0                	test   %al,%al
801009a8:	75 ee                	jne    80100998 <cprintf+0x128>
801009aa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801009ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
801009b0:	e9 23 ff ff ff       	jmp    801008d8 <cprintf+0x68>
801009b5:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801009b8:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801009bf:	e8 dc 3b 00 00       	call   801045a0 <acquire>
801009c4:	e9 be fe ff ff       	jmp    80100887 <cprintf+0x17>

  if (fmt == 0)
    panic("null fmt");
801009c9:	c7 04 24 28 72 10 80 	movl   $0x80107228,(%esp)
801009d0:	e8 fb f9 ff ff       	call   801003d0 <panic>
	...

801009e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009ec:	e8 cf 23 00 00       	call   80102dc0 <begin_op>

  if((ip = namei(path)) == 0){
801009f1:	8b 45 08             	mov    0x8(%ebp),%eax
801009f4:	89 04 24             	mov    %eax,(%esp)
801009f7:	e8 d4 14 00 00       	call   80101ed0 <namei>
801009fc:	85 c0                	test   %eax,%eax
801009fe:	89 c7                	mov    %eax,%edi
80100a00:	0f 84 32 02 00 00    	je     80100c38 <exec+0x258>
    end_op();
    return -1;
  }
  ilock(ip);
80100a06:	89 04 24             	mov    %eax,(%esp)
80100a09:	e8 62 12 00 00       	call   80101c70 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a0e:	8d 45 94             	lea    -0x6c(%ebp),%eax
80100a11:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100a18:	00 
80100a19:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100a20:	00 
80100a21:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a25:	89 3c 24             	mov    %edi,(%esp)
80100a28:	e8 53 0e 00 00       	call   80101880 <readi>
80100a2d:	83 f8 34             	cmp    $0x34,%eax
80100a30:	0f 85 fa 01 00 00    	jne    80100c30 <exec+0x250>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a36:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
80100a3d:	0f 85 ed 01 00 00    	jne    80100c30 <exec+0x250>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a43:	e8 38 60 00 00       	call   80106a80 <setupkvm>
80100a48:	85 c0                	test   %eax,%eax
80100a4a:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a50:	0f 84 da 01 00 00    	je     80100c30 <exec+0x250>
    goto bad;

  // Load program into memory.
  sz = PGSIZE - 1;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a56:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
80100a5b:	8b 5d b0             	mov    -0x50(%ebp),%ebx
80100a5e:	0f 84 d1 02 00 00    	je     80100d35 <exec+0x355>
80100a64:	c7 85 f0 fe ff ff ff 	movl   $0xfff,-0x110(%ebp)
80100a6b:	0f 00 00 
80100a6e:	31 f6                	xor    %esi,%esi
80100a70:	eb 18                	jmp    80100a8a <exec+0xaa>
80100a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a78:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80100a7c:	83 c6 01             	add    $0x1,%esi
80100a7f:	39 f0                	cmp    %esi,%eax
80100a81:	0f 8e c1 00 00 00    	jle    80100b48 <exec+0x168>
80100a87:	83 c3 20             	add    $0x20,%ebx
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a8a:	8d 55 c8             	lea    -0x38(%ebp),%edx
80100a8d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a94:	00 
80100a95:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a99:	89 54 24 04          	mov    %edx,0x4(%esp)
80100a9d:	89 3c 24             	mov    %edi,(%esp)
80100aa0:	e8 db 0d 00 00       	call   80101880 <readi>
80100aa5:	83 f8 20             	cmp    $0x20,%eax
80100aa8:	75 76                	jne    80100b20 <exec+0x140>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100aaa:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
80100aae:	75 c8                	jne    80100a78 <exec+0x98>
      continue;
    if(ph.memsz < ph.filesz)
80100ab0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ab3:	3b 45 d8             	cmp    -0x28(%ebp),%eax
80100ab6:	72 68                	jb     80100b20 <exec+0x140>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab8:	03 45 d0             	add    -0x30(%ebp),%eax
80100abb:	72 63                	jb     80100b20 <exec+0x140>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100abd:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ac1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100ac7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100acd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100ad1:	89 04 24             	mov    %eax,(%esp)
80100ad4:	e8 f7 62 00 00       	call   80106dd0 <allocuvm>
80100ad9:	85 c0                	test   %eax,%eax
80100adb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ae1:	74 3d                	je     80100b20 <exec+0x140>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100ae3:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ae6:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aeb:	75 33                	jne    80100b20 <exec+0x140>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aed:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100af0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af8:	89 54 24 10          	mov    %edx,0x10(%esp)
80100afc:	8b 55 cc             	mov    -0x34(%ebp),%edx
80100aff:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b03:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100b09:	89 14 24             	mov    %edx,(%esp)
80100b0c:	e8 df 63 00 00       	call   80106ef0 <loaduvm>
80100b11:	85 c0                	test   %eax,%eax
80100b13:	0f 89 5f ff ff ff    	jns    80100a78 <exec+0x98>
80100b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b20:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 52 61 00 00       	call   80106c80 <freevm>
  if(ip){
80100b2e:	85 ff                	test   %edi,%edi
80100b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b35:	0f 85 f5 00 00 00    	jne    80100c30 <exec+0x250>
    iunlockput(ip);
    end_op();
  }
  return -1;
}
80100b3b:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100b41:	5b                   	pop    %ebx
80100b42:	5e                   	pop    %esi
80100b43:	5f                   	pop    %edi
80100b44:	5d                   	pop    %ebp
80100b45:	c3                   	ret    
80100b46:	66 90                	xchg   %ax,%ax
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = PGSIZE - 1;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b48:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100b4e:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80100b54:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80100b5a:	8d b3 00 20 00 00    	lea    0x2000(%ebx),%esi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b60:	89 3c 24             	mov    %edi,(%esp)
80100b63:	e8 e8 10 00 00       	call   80101c50 <iunlockput>
  end_op();
80100b68:	e8 23 21 00 00       	call   80102c90 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b6d:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100b73:	89 74 24 08          	mov    %esi,0x8(%esp)
80100b77:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100b7b:	89 0c 24             	mov    %ecx,(%esp)
80100b7e:	e8 4d 62 00 00       	call   80106dd0 <allocuvm>
80100b83:	85 c0                	test   %eax,%eax
80100b85:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b8b:	0f 84 96 00 00 00    	je     80100c27 <exec+0x247>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b91:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b96:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b9a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ba0:	89 04 24             	mov    %eax,(%esp)
80100ba3:	e8 78 5f 00 00       	call   80106b20 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
80100bab:	8b 02                	mov    (%edx),%eax
80100bad:	85 c0                	test   %eax,%eax
80100baf:	0f 84 8f 01 00 00    	je     80100d44 <exec+0x364>
80100bb5:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100bb8:	31 f6                	xor    %esi,%esi
80100bba:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100bc0:	eb 28                	jmp    80100bea <exec+0x20a>
80100bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bc8:	89 9c b5 10 ff ff ff 	mov    %ebx,-0xf0(%ebp,%esi,4)
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd2:	83 c6 01             	add    $0x1,%esi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bd5:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100bdb:	8d 3c b0             	lea    (%eax,%esi,4),%edi
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bde:	8b 04 b0             	mov    (%eax,%esi,4),%eax
80100be1:	85 c0                	test   %eax,%eax
80100be3:	74 62                	je     80100c47 <exec+0x267>
    if(argc >= MAXARG)
80100be5:	83 fe 20             	cmp    $0x20,%esi
80100be8:	74 3d                	je     80100c27 <exec+0x247>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bea:	89 04 24             	mov    %eax,(%esp)
80100bed:	e8 7e 3c 00 00       	call   80104870 <strlen>
80100bf2:	f7 d0                	not    %eax
80100bf4:	8d 1c 18             	lea    (%eax,%ebx,1),%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bf7:	8b 07                	mov    (%edi),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf9:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bfc:	89 04 24             	mov    %eax,(%esp)
80100bff:	e8 6c 3c 00 00       	call   80104870 <strlen>
80100c04:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c0a:	83 c0 01             	add    $0x1,%eax
80100c0d:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c11:	8b 07                	mov    (%edi),%eax
80100c13:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c17:	89 0c 24             	mov    %ecx,(%esp)
80100c1a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c1e:	e8 3d 5d 00 00       	call   80106960 <copyout>
80100c23:	85 c0                	test   %eax,%eax
80100c25:	79 a1                	jns    80100bc8 <exec+0x1e8>
 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
80100c27:	31 ff                	xor    %edi,%edi
80100c29:	e9 f2 fe ff ff       	jmp    80100b20 <exec+0x140>
80100c2e:	66 90                	xchg   %ax,%ax

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c30:	89 3c 24             	mov    %edi,(%esp)
80100c33:	e8 18 10 00 00       	call   80101c50 <iunlockput>
    end_op();
80100c38:	e8 53 20 00 00       	call   80102c90 <end_op>
80100c3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c42:	e9 f4 fe ff ff       	jmp    80100b3b <exec+0x15b>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c47:	8d 4e 03             	lea    0x3(%esi),%ecx
80100c4a:	8d 3c b5 04 00 00 00 	lea    0x4(,%esi,4),%edi
80100c51:	8d 04 b5 10 00 00 00 	lea    0x10(,%esi,4),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c58:	c7 84 8d 04 ff ff ff 	movl   $0x0,-0xfc(%ebp,%ecx,4)
80100c5f:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c63:	89 d9                	mov    %ebx,%ecx

  sp -= (3+argc+1) * 4;
80100c65:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c67:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c6b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c71:	29 f9                	sub    %edi,%ecx
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100c73:	c7 85 04 ff ff ff ff 	movl   $0xffffffff,-0xfc(%ebp)
80100c7a:	ff ff ff 
  ustack[1] = argc;
80100c7d:	89 b5 08 ff ff ff    	mov    %esi,-0xf8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c83:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c89:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c91:	89 04 24             	mov    %eax,(%esp)
80100c94:	e8 c7 5c 00 00       	call   80106960 <copyout>
80100c99:	85 c0                	test   %eax,%eax
80100c9b:	78 8a                	js     80100c27 <exec+0x247>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100ca0:	0f b6 11             	movzbl (%ecx),%edx
80100ca3:	84 d2                	test   %dl,%dl
80100ca5:	74 19                	je     80100cc0 <exec+0x2e0>
80100ca7:	89 c8                	mov    %ecx,%eax
80100ca9:	83 c0 01             	add    $0x1,%eax
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == '/')
80100cb0:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cb3:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
80100cb6:	0f 44 c8             	cmove  %eax,%ecx
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cb9:	83 c0 01             	add    $0x1,%eax
80100cbc:	84 d2                	test   %dl,%dl
80100cbe:	75 f0                	jne    80100cb0 <exec+0x2d0>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cc0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cc6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100cca:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cd1:	00 
80100cd2:	83 c0 6c             	add    $0x6c,%eax
80100cd5:	89 04 24             	mov    %eax,(%esp)
80100cd8:	e8 53 3b 00 00       	call   80104830 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cdd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100ce3:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ce9:	8b 70 04             	mov    0x4(%eax),%esi
  proc->pgdir = pgdir;
80100cec:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100cef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cf5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100cfb:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100cfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d03:	8b 55 ac             	mov    -0x54(%ebp),%edx
80100d06:	8b 40 18             	mov    0x18(%eax),%eax
80100d09:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100d0c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d12:	8b 40 18             	mov    0x18(%eax),%eax
80100d15:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(proc);
80100d18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d1e:	89 04 24             	mov    %eax,(%esp)
80100d21:	e8 8a 62 00 00       	call   80106fb0 <switchuvm>
  freevm(oldpgdir);
80100d26:	89 34 24             	mov    %esi,(%esp)
80100d29:	e8 52 5f 00 00       	call   80106c80 <freevm>
80100d2e:	31 c0                	xor    %eax,%eax
  return 0;
80100d30:	e9 06 fe ff ff       	jmp    80100b3b <exec+0x15b>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = PGSIZE - 1;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d35:	be 00 30 00 00       	mov    $0x3000,%esi
80100d3a:	bb 00 10 00 00       	mov    $0x1000,%ebx
80100d3f:	e9 1c fe ff ff       	jmp    80100b60 <exec+0x180>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d44:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100d4a:	b0 10                	mov    $0x10,%al
80100d4c:	bf 04 00 00 00       	mov    $0x4,%edi
80100d51:	b9 03 00 00 00       	mov    $0x3,%ecx
80100d56:	31 f6                	xor    %esi,%esi
80100d58:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
80100d5e:	e9 f5 fe ff ff       	jmp    80100c58 <exec+0x278>
	...

80100d70 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	57                   	push   %edi
80100d74:	56                   	push   %esi
80100d75:	53                   	push   %ebx
80100d76:	83 ec 2c             	sub    $0x2c,%esp
80100d79:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d7c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100d7f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d82:	8b 45 10             	mov    0x10(%ebp),%eax
80100d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100d88:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100d8c:	0f 84 ae 00 00 00    	je     80100e40 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80100d92:	8b 03                	mov    (%ebx),%eax
80100d94:	83 f8 01             	cmp    $0x1,%eax
80100d97:	0f 84 c2 00 00 00    	je     80100e5f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100d9d:	83 f8 02             	cmp    $0x2,%eax
80100da0:	0f 85 d7 00 00 00    	jne    80100e7d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100da6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100da9:	31 f6                	xor    %esi,%esi
80100dab:	85 c0                	test   %eax,%eax
80100dad:	7f 31                	jg     80100de0 <filewrite+0x70>
80100daf:	e9 9c 00 00 00       	jmp    80100e50 <filewrite+0xe0>
80100db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100db8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80100dbb:	8b 53 10             	mov    0x10(%ebx),%edx
80100dbe:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100dc1:	89 14 24             	mov    %edx,(%esp)
80100dc4:	e8 37 0e 00 00       	call   80101c00 <iunlock>
      end_op();
80100dc9:	e8 c2 1e 00 00       	call   80102c90 <end_op>
80100dce:	8b 45 dc             	mov    -0x24(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80100dd1:	39 f8                	cmp    %edi,%eax
80100dd3:	0f 85 98 00 00 00    	jne    80100e71 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80100dd9:	01 c6                	add    %eax,%esi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ddb:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80100dde:	7e 70                	jle    80100e50 <filewrite+0xe0>
      int n1 = n - i;
80100de0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100de3:	b8 00 1a 00 00       	mov    $0x1a00,%eax
80100de8:	29 f7                	sub    %esi,%edi
80100dea:	81 ff 00 1a 00 00    	cmp    $0x1a00,%edi
80100df0:	0f 4f f8             	cmovg  %eax,%edi
      if(n1 > max)
        n1 = max;

      begin_op();
80100df3:	e8 c8 1f 00 00       	call   80102dc0 <begin_op>
      ilock(f->ip);
80100df8:	8b 43 10             	mov    0x10(%ebx),%eax
80100dfb:	89 04 24             	mov    %eax,(%esp)
80100dfe:	e8 6d 0e 00 00       	call   80101c70 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100e03:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100e07:	8b 43 14             	mov    0x14(%ebx),%eax
80100e0a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e11:	01 f0                	add    %esi,%eax
80100e13:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e17:	8b 43 10             	mov    0x10(%ebx),%eax
80100e1a:	89 04 24             	mov    %eax,(%esp)
80100e1d:	e8 3e 09 00 00       	call   80101760 <writei>
80100e22:	85 c0                	test   %eax,%eax
80100e24:	7f 92                	jg     80100db8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80100e26:	8b 53 10             	mov    0x10(%ebx),%edx
80100e29:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100e2c:	89 14 24             	mov    %edx,(%esp)
80100e2f:	e8 cc 0d 00 00       	call   80101c00 <iunlock>
      end_op();
80100e34:	e8 57 1e 00 00       	call   80102c90 <end_op>

      if(r < 0)
80100e39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	74 91                	je     80100dd1 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100e40:	83 c4 2c             	add    $0x2c,%esp
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100e43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e48:	5b                   	pop    %ebx
80100e49:	5e                   	pop    %esi
80100e4a:	5f                   	pop    %edi
80100e4b:	5d                   	pop    %ebp
80100e4c:	c3                   	ret    
80100e4d:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100e50:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
  }
  panic("filewrite");
80100e53:	89 f0                	mov    %esi,%eax
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100e55:	75 e9                	jne    80100e40 <filewrite+0xd0>
  }
  panic("filewrite");
}
80100e57:	83 c4 2c             	add    $0x2c,%esp
80100e5a:	5b                   	pop    %ebx
80100e5b:	5e                   	pop    %esi
80100e5c:	5f                   	pop    %edi
80100e5d:	5d                   	pop    %ebp
80100e5e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100e5f:	8b 43 0c             	mov    0xc(%ebx),%eax
80100e62:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100e65:	83 c4 2c             	add    $0x2c,%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100e6c:	e9 2f 26 00 00       	jmp    801034a0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80100e71:	c7 04 24 49 72 10 80 	movl   $0x80107249,(%esp)
80100e78:	e8 53 f5 ff ff       	call   801003d0 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100e7d:	c7 04 24 4f 72 10 80 	movl   $0x8010724f,(%esp)
80100e84:	e8 47 f5 ff ff       	call   801003d0 <panic>
80100e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e90 <fileread>:
}

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e90:	55                   	push   %ebp
80100e91:	89 e5                	mov    %esp,%ebp
80100e93:	83 ec 38             	sub    $0x38,%esp
80100e96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e99:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e9c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e9f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100ea2:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100ea5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100ea8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100eac:	74 5a                	je     80100f08 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100eae:	8b 03                	mov    (%ebx),%eax
80100eb0:	83 f8 01             	cmp    $0x1,%eax
80100eb3:	74 6b                	je     80100f20 <fileread+0x90>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100eb5:	83 f8 02             	cmp    $0x2,%eax
80100eb8:	75 7d                	jne    80100f37 <fileread+0xa7>
    ilock(f->ip);
80100eba:	8b 43 10             	mov    0x10(%ebx),%eax
80100ebd:	89 04 24             	mov    %eax,(%esp)
80100ec0:	e8 ab 0d 00 00       	call   80101c70 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100ec5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100ec9:	8b 43 14             	mov    0x14(%ebx),%eax
80100ecc:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ed0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ed4:	8b 43 10             	mov    0x10(%ebx),%eax
80100ed7:	89 04 24             	mov    %eax,(%esp)
80100eda:	e8 a1 09 00 00       	call   80101880 <readi>
80100edf:	85 c0                	test   %eax,%eax
80100ee1:	7e 03                	jle    80100ee6 <fileread+0x56>
      f->off += r;
80100ee3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100ee6:	8b 53 10             	mov    0x10(%ebx),%edx
80100ee9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100eec:	89 14 24             	mov    %edx,(%esp)
80100eef:	e8 0c 0d 00 00       	call   80101c00 <iunlock>
    return r;
80100ef4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100ef7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100efa:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100efd:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f00:	89 ec                	mov    %ebp,%esp
80100f02:	5d                   	pop    %ebp
80100f03:	c3                   	ret    
80100f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f08:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100f0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f10:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f13:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f16:	89 ec                	mov    %ebp,%esp
80100f18:	5d                   	pop    %ebp
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f20:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f23:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f26:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f29:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f2c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f2f:	89 ec                	mov    %ebp,%esp
80100f31:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f32:	e9 69 24 00 00       	jmp    801033a0 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100f37:	c7 04 24 59 72 10 80 	movl   $0x80107259,(%esp)
80100f3e:	e8 8d f4 ff ff       	call   801003d0 <panic>
80100f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f50 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f50:	55                   	push   %ebp
  if(f->type == FD_INODE){
80100f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f56:	89 e5                	mov    %esp,%ebp
80100f58:	53                   	push   %ebx
80100f59:	83 ec 14             	sub    $0x14,%esp
80100f5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f5f:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f62:	74 0c                	je     80100f70 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
80100f64:	83 c4 14             	add    $0x14,%esp
80100f67:	5b                   	pop    %ebx
80100f68:	5d                   	pop    %ebp
80100f69:	c3                   	ret    
80100f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
80100f70:	8b 43 10             	mov    0x10(%ebx),%eax
80100f73:	89 04 24             	mov    %eax,(%esp)
80100f76:	e8 f5 0c 00 00       	call   80101c70 <ilock>
    stati(f->ip, st);
80100f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f82:	8b 43 10             	mov    0x10(%ebx),%eax
80100f85:	89 04 24             	mov    %eax,(%esp)
80100f88:	e8 e3 01 00 00       	call   80101170 <stati>
    iunlock(f->ip);
80100f8d:	8b 43 10             	mov    0x10(%ebx),%eax
80100f90:	89 04 24             	mov    %eax,(%esp)
80100f93:	e8 68 0c 00 00       	call   80101c00 <iunlock>
    return 0;
  }
  return -1;
}
80100f98:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
80100f9b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
80100f9d:	5b                   	pop    %ebx
80100f9e:	5d                   	pop    %ebp
80100f9f:	c3                   	ret    

80100fa0 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	53                   	push   %ebx
80100fa4:	83 ec 14             	sub    $0x14,%esp
80100fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100faa:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100fb1:	e8 ea 35 00 00       	call   801045a0 <acquire>
  if(f->ref < 1)
80100fb6:	8b 43 04             	mov    0x4(%ebx),%eax
80100fb9:	85 c0                	test   %eax,%eax
80100fbb:	7e 1a                	jle    80100fd7 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100fbd:	83 c0 01             	add    $0x1,%eax
80100fc0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fc3:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100fca:	e8 81 35 00 00       	call   80104550 <release>
  return f;
}
80100fcf:	89 d8                	mov    %ebx,%eax
80100fd1:	83 c4 14             	add    $0x14,%esp
80100fd4:	5b                   	pop    %ebx
80100fd5:	5d                   	pop    %ebp
80100fd6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100fd7:	c7 04 24 62 72 10 80 	movl   $0x80107262,(%esp)
80100fde:	e8 ed f3 ff ff       	call   801003d0 <panic>
80100fe3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ff0 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	53                   	push   %ebx
  initlock(&ftable.lock, "ftable");
}

// Allocate a file structure.
struct file*
filealloc(void)
80100ff4:	bb 2c 00 11 80       	mov    $0x8011002c,%ebx
{
80100ff9:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100ffc:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101003:	e8 98 35 00 00       	call   801045a0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
80101008:	8b 0d 18 00 11 80    	mov    0x80110018,%ecx
8010100e:	85 c9                	test   %ecx,%ecx
80101010:	75 11                	jne    80101023 <filealloc+0x33>
80101012:	eb 4a                	jmp    8010105e <filealloc+0x6e>
80101014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101018:	83 c3 18             	add    $0x18,%ebx
8010101b:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80101021:	74 25                	je     80101048 <filealloc+0x58>
    if(f->ref == 0){
80101023:	8b 53 04             	mov    0x4(%ebx),%edx
80101026:	85 d2                	test   %edx,%edx
80101028:	75 ee                	jne    80101018 <filealloc+0x28>
      f->ref = 1;
8010102a:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101031:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101038:	e8 13 35 00 00       	call   80104550 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
8010103d:	89 d8                	mov    %ebx,%eax
8010103f:	83 c4 14             	add    $0x14,%esp
80101042:	5b                   	pop    %ebx
80101043:	5d                   	pop    %ebp
80101044:	c3                   	ret    
80101045:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101048:	31 db                	xor    %ebx,%ebx
8010104a:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101051:	e8 fa 34 00 00       	call   80104550 <release>
  return 0;
}
80101056:	89 d8                	mov    %ebx,%eax
80101058:	83 c4 14             	add    $0x14,%esp
8010105b:	5b                   	pop    %ebx
8010105c:	5d                   	pop    %ebp
8010105d:	c3                   	ret    
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
8010105e:	bb 14 00 11 80       	mov    $0x80110014,%ebx
80101063:	eb c5                	jmp    8010102a <filealloc+0x3a>
80101065:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101070 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	83 ec 38             	sub    $0x38,%esp
80101076:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101079:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010107c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010107f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80101082:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101089:	e8 12 35 00 00       	call   801045a0 <acquire>
  if(f->ref < 1)
8010108e:	8b 43 04             	mov    0x4(%ebx),%eax
80101091:	85 c0                	test   %eax,%eax
80101093:	0f 8e a4 00 00 00    	jle    8010113d <fileclose+0xcd>
    panic("fileclose");
  if(--f->ref > 0){
80101099:	83 e8 01             	sub    $0x1,%eax
8010109c:	85 c0                	test   %eax,%eax
8010109e:	89 43 04             	mov    %eax,0x4(%ebx)
801010a1:	74 1d                	je     801010c0 <fileclose+0x50>
    release(&ftable.lock);
801010a3:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801010aa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801010ad:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010b0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801010b3:	89 ec                	mov    %ebp,%esp
801010b5:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
801010b6:	e9 95 34 00 00       	jmp    80104550 <release>
801010bb:	90                   	nop
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
801010c0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010c3:	8b 7b 10             	mov    0x10(%ebx),%edi
801010c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010c9:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801010cd:	88 45 e7             	mov    %al,-0x19(%ebp)
801010d0:	8b 33                	mov    (%ebx),%esi
  f->ref = 0;
801010d2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
801010d9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
801010df:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
801010e6:	e8 65 34 00 00       	call   80104550 <release>

  if(ff.type == FD_PIPE)
801010eb:	83 fe 01             	cmp    $0x1,%esi
801010ee:	74 38                	je     80101128 <fileclose+0xb8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801010f0:	83 fe 02             	cmp    $0x2,%esi
801010f3:	74 13                	je     80101108 <fileclose+0x98>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801010f5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801010f8:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010fb:	8b 7d fc             	mov    -0x4(%ebp),%edi
801010fe:	89 ec                	mov    %ebp,%esp
80101100:	5d                   	pop    %ebp
80101101:	c3                   	ret    
80101102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
80101108:	e8 b3 1c 00 00       	call   80102dc0 <begin_op>
    iput(ff.ip);
8010110d:	89 3c 24             	mov    %edi,(%esp)
80101110:	e8 2b 03 00 00       	call   80101440 <iput>
    end_op();
  }
}
80101115:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101118:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010111b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010111e:	89 ec                	mov    %ebp,%esp
80101120:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80101121:	e9 6a 1b 00 00       	jmp    80102c90 <end_op>
80101126:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101128:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
8010112c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101130:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101133:	89 04 24             	mov    %eax,(%esp)
80101136:	e8 55 24 00 00       	call   80103590 <pipeclose>
8010113b:	eb b8                	jmp    801010f5 <fileclose+0x85>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
8010113d:	c7 04 24 6a 72 10 80 	movl   $0x8010726a,(%esp)
80101144:	e8 87 f2 ff ff       	call   801003d0 <panic>
80101149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101150 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80101156:	c7 44 24 04 74 72 10 	movl   $0x80107274,0x4(%esp)
8010115d:	80 
8010115e:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101165:	e8 a6 32 00 00       	call   80104410 <initlock>
}
8010116a:	c9                   	leave  
8010116b:	c3                   	ret    
8010116c:	00 00                	add    %al,(%eax)
	...

80101170 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	8b 55 08             	mov    0x8(%ebp),%edx
80101176:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101179:	8b 0a                	mov    (%edx),%ecx
8010117b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010117e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101181:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101184:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101188:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010118b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010118f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101193:	8b 52 58             	mov    0x58(%edx),%edx
80101196:	89 50 10             	mov    %edx,0x10(%eax)
}
80101199:	5d                   	pop    %ebp
8010119a:	c3                   	ret    
8010119b:	90                   	nop
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011a0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	53                   	push   %ebx
801011a4:	83 ec 14             	sub    $0x14,%esp
801011a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801011aa:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011b1:	e8 ea 33 00 00       	call   801045a0 <acquire>
  ip->ref++;
801011b6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801011ba:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011c1:	e8 8a 33 00 00       	call   80104550 <release>
  return ip;
}
801011c6:	89 d8                	mov    %ebx,%eax
801011c8:	83 c4 14             	add    $0x14,%esp
801011cb:	5b                   	pop    %ebx
801011cc:	5d                   	pop    %ebp
801011cd:	c3                   	ret    
801011ce:	66 90                	xchg   %ax,%ax

801011d0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	57                   	push   %edi
801011d4:	89 d7                	mov    %edx,%edi
801011d6:	56                   	push   %esi

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
801011d7:	31 f6                	xor    %esi,%esi
{
801011d9:	53                   	push   %ebx
801011da:	89 c3                	mov    %eax,%ebx
801011dc:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801011df:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011e6:	e8 b5 33 00 00       	call   801045a0 <acquire>

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
801011eb:	b8 34 0a 11 80       	mov    $0x80110a34,%eax
801011f0:	eb 16                	jmp    80101208 <iget+0x38>
801011f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801011f8:	85 f6                	test   %esi,%esi
801011fa:	74 3c                	je     80101238 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011fc:	05 90 00 00 00       	add    $0x90,%eax
80101201:	3d 54 26 11 80       	cmp    $0x80112654,%eax
80101206:	74 48                	je     80101250 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101208:	8b 48 08             	mov    0x8(%eax),%ecx
8010120b:	85 c9                	test   %ecx,%ecx
8010120d:	7e e9                	jle    801011f8 <iget+0x28>
8010120f:	39 18                	cmp    %ebx,(%eax)
80101211:	75 e5                	jne    801011f8 <iget+0x28>
80101213:	39 78 04             	cmp    %edi,0x4(%eax)
80101216:	75 e0                	jne    801011f8 <iget+0x28>
      ip->ref++;
80101218:	83 c1 01             	add    $0x1,%ecx
8010121b:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
8010121e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101221:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101228:	e8 23 33 00 00       	call   80104550 <release>
      return ip;
8010122d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
80101230:	83 c4 2c             	add    $0x2c,%esp
80101233:	5b                   	pop    %ebx
80101234:	5e                   	pop    %esi
80101235:	5f                   	pop    %edi
80101236:	5d                   	pop    %ebp
80101237:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101238:	85 c9                	test   %ecx,%ecx
8010123a:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010123d:	05 90 00 00 00       	add    $0x90,%eax
80101242:	3d 54 26 11 80       	cmp    $0x80112654,%eax
80101247:	75 bf                	jne    80101208 <iget+0x38>
80101249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101250:	85 f6                	test   %esi,%esi
80101252:	74 29                	je     8010127d <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101254:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
80101256:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
80101259:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101260:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101267:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010126e:	e8 dd 32 00 00       	call   80104550 <release>

  return ip;
}
80101273:	83 c4 2c             	add    $0x2c,%esp
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101276:	89 f0                	mov    %esi,%eax

  return ip;
}
80101278:	5b                   	pop    %ebx
80101279:	5e                   	pop    %esi
8010127a:	5f                   	pop    %edi
8010127b:	5d                   	pop    %ebp
8010127c:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
8010127d:	c7 04 24 7b 72 10 80 	movl   $0x8010727b,(%esp)
80101284:	e8 47 f1 ff ff       	call   801003d0 <panic>
80101289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101290 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101296:	8b 45 0c             	mov    0xc(%ebp),%eax
80101299:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801012a0:	00 
801012a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801012a5:	8b 45 08             	mov    0x8(%ebp),%eax
801012a8:	89 04 24             	mov    %eax,(%esp)
801012ab:	e8 d0 34 00 00       	call   80104780 <strncmp>
}
801012b0:	c9                   	leave  
801012b1:	c3                   	ret    
801012b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012c0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	56                   	push   %esi
801012c4:	53                   	push   %ebx
801012c5:	83 ec 10             	sub    $0x10,%esp
801012c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801012cb:	8b 43 04             	mov    0x4(%ebx),%eax
801012ce:	c1 e8 03             	shr    $0x3,%eax
801012d1:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801012d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801012db:	8b 03                	mov    (%ebx),%eax
801012dd:	89 04 24             	mov    %eax,(%esp)
801012e0:	e8 2b ee ff ff       	call   80100110 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
801012e5:	0f b7 53 50          	movzwl 0x50(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801012e9:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801012eb:	8b 43 04             	mov    0x4(%ebx),%eax
801012ee:	83 e0 07             	and    $0x7,%eax
801012f1:	c1 e0 06             	shl    $0x6,%eax
801012f4:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801012f8:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801012fb:	0f b7 53 52          	movzwl 0x52(%ebx),%edx
801012ff:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101303:	0f b7 53 54          	movzwl 0x54(%ebx),%edx
80101307:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010130b:	0f b7 53 56          	movzwl 0x56(%ebx),%edx
8010130f:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101313:	8b 53 58             	mov    0x58(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101316:	83 c3 5c             	add    $0x5c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
80101319:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010131c:	83 c0 0c             	add    $0xc,%eax
8010131f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101323:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010132a:	00 
8010132b:	89 04 24             	mov    %eax,(%esp)
8010132e:	e8 dd 33 00 00       	call   80104710 <memmove>
  log_write(bp);
80101333:	89 34 24             	mov    %esi,(%esp)
80101336:	e8 95 17 00 00       	call   80102ad0 <log_write>
  brelse(bp);
8010133b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010133e:	83 c4 10             	add    $0x10,%esp
80101341:	5b                   	pop    %ebx
80101342:	5e                   	pop    %esi
80101343:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101344:	e9 f7 ec ff ff       	jmp    80100040 <brelse>
80101349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101350 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101356:	8b 45 08             	mov    0x8(%ebp),%eax
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101359:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010135c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010135f:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101362:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101369:	00 
8010136a:	89 04 24             	mov    %eax,(%esp)
8010136d:	e8 9e ed ff ff       	call   80100110 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101372:	89 34 24             	mov    %esi,(%esp)
80101375:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
8010137c:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
8010137d:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010137f:	8d 40 5c             	lea    0x5c(%eax),%eax
80101382:	89 44 24 04          	mov    %eax,0x4(%esp)
80101386:	e8 85 33 00 00       	call   80104710 <memmove>
  brelse(bp);
}
8010138b:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
8010138e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101391:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101394:	89 ec                	mov    %ebp,%esp
80101396:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101397:	e9 a4 ec ff ff       	jmp    80100040 <brelse>
8010139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	83 ec 28             	sub    $0x28,%esp
801013a6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801013a9:	89 d6                	mov    %edx,%esi
801013ab:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801013ae:	89 c3                	mov    %eax,%ebx
801013b0:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013b3:	89 04 24             	mov    %eax,(%esp)
801013b6:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
801013bd:	80 
801013be:	e8 8d ff ff ff       	call   80101350 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013c3:	89 f0                	mov    %esi,%eax
801013c5:	c1 e8 0c             	shr    $0xc,%eax
801013c8:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801013ce:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
801013d1:	89 f3                	mov    %esi,%ebx
801013d3:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801013dd:	c1 fb 03             	sar    $0x3,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013e0:	e8 2b ed ff ff       	call   80100110 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801013e5:	89 f1                	mov    %esi,%ecx
801013e7:	be 01 00 00 00       	mov    $0x1,%esi
801013ec:	83 e1 07             	and    $0x7,%ecx
801013ef:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
801013f1:	0f b6 54 18 5c       	movzbl 0x5c(%eax,%ebx,1),%edx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013f6:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801013f8:	0f b6 c2             	movzbl %dl,%eax
801013fb:	85 f0                	test   %esi,%eax
801013fd:	74 27                	je     80101426 <bfree+0x86>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801013ff:	89 f0                	mov    %esi,%eax
80101401:	f7 d0                	not    %eax
80101403:	21 d0                	and    %edx,%eax
80101405:	88 44 1f 5c          	mov    %al,0x5c(%edi,%ebx,1)
  log_write(bp);
80101409:	89 3c 24             	mov    %edi,(%esp)
8010140c:	e8 bf 16 00 00       	call   80102ad0 <log_write>
  brelse(bp);
80101411:	89 3c 24             	mov    %edi,(%esp)
80101414:	e8 27 ec ff ff       	call   80100040 <brelse>
}
80101419:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010141c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010141f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101422:	89 ec                	mov    %ebp,%esp
80101424:	5d                   	pop    %ebp
80101425:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101426:	c7 04 24 8b 72 10 80 	movl   $0x8010728b,(%esp)
8010142d:	e8 9e ef ff ff       	call   801003d0 <panic>
80101432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101440 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	57                   	push   %edi
80101444:	56                   	push   %esi
80101445:	53                   	push   %ebx
80101446:	83 ec 2c             	sub    $0x2c,%esp
80101449:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010144c:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101453:	e8 48 31 00 00       	call   801045a0 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101458:	8b 46 08             	mov    0x8(%esi),%eax
8010145b:	83 f8 01             	cmp    $0x1,%eax
8010145e:	74 20                	je     80101480 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
80101460:	83 e8 01             	sub    $0x1,%eax
80101463:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
80101466:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
8010146d:	83 c4 2c             	add    $0x2c,%esp
80101470:	5b                   	pop    %ebx
80101471:	5e                   	pop    %esi
80101472:	5f                   	pop    %edi
80101473:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
80101474:	e9 d7 30 00 00       	jmp    80104550 <release>
80101479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101480:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
80101484:	74 da                	je     80101460 <iput+0x20>
80101486:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
8010148b:	75 d3                	jne    80101460 <iput+0x20>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
8010148d:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101494:	89 f3                	mov    %esi,%ebx
80101496:	e8 b5 30 00 00       	call   80104550 <release>
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
8010149b:	8d 7e 30             	lea    0x30(%esi),%edi
8010149e:	eb 07                	jmp    801014a7 <iput+0x67>
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
801014a0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801014a3:	39 fb                	cmp    %edi,%ebx
801014a5:	74 19                	je     801014c0 <iput+0x80>
    if(ip->addrs[i]){
801014a7:	8b 53 5c             	mov    0x5c(%ebx),%edx
801014aa:	85 d2                	test   %edx,%edx
801014ac:	74 f2                	je     801014a0 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
801014ae:	8b 06                	mov    (%esi),%eax
801014b0:	e8 eb fe ff ff       	call   801013a0 <bfree>
      ip->addrs[i] = 0;
801014b5:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
801014bc:	eb e2                	jmp    801014a0 <iput+0x60>
801014be:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801014c0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801014c6:	85 c0                	test   %eax,%eax
801014c8:	75 3e                	jne    80101508 <iput+0xc8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801014ca:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801014d1:	89 34 24             	mov    %esi,(%esp)
801014d4:	e8 e7 fd ff ff       	call   801012c0 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
801014d9:	66 c7 46 50 00 00    	movw   $0x0,0x50(%esi)
    iupdate(ip);
801014df:	89 34 24             	mov    %esi,(%esp)
801014e2:	e8 d9 fd ff ff       	call   801012c0 <iupdate>
    acquire(&icache.lock);
801014e7:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801014ee:	e8 ad 30 00 00       	call   801045a0 <acquire>
    ip->flags = 0;
801014f3:	8b 46 08             	mov    0x8(%esi),%eax
801014f6:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801014fd:	e9 5e ff ff ff       	jmp    80101460 <iput+0x20>
80101502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101508:	89 44 24 04          	mov    %eax,0x4(%esp)
8010150c:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
8010150e:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101510:	89 04 24             	mov    %eax,(%esp)
80101513:	e8 f8 eb ff ff       	call   80100110 <bread>
    a = (uint*)bp->data;
80101518:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010151a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010151d:	83 c7 5c             	add    $0x5c,%edi
80101520:	31 c0                	xor    %eax,%eax
80101522:	eb 11                	jmp    80101535 <iput+0xf5>
80101524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
80101528:	83 c3 01             	add    $0x1,%ebx
8010152b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101531:	89 d8                	mov    %ebx,%eax
80101533:	74 10                	je     80101545 <iput+0x105>
      if(a[j])
80101535:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101538:	85 d2                	test   %edx,%edx
8010153a:	74 ec                	je     80101528 <iput+0xe8>
        bfree(ip->dev, a[j]);
8010153c:	8b 06                	mov    (%esi),%eax
8010153e:	e8 5d fe ff ff       	call   801013a0 <bfree>
80101543:	eb e3                	jmp    80101528 <iput+0xe8>
    }
    brelse(bp);
80101545:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101548:	89 04 24             	mov    %eax,(%esp)
8010154b:	e8 f0 ea ff ff       	call   80100040 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101550:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101556:	8b 06                	mov    (%esi),%eax
80101558:	e8 43 fe ff ff       	call   801013a0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010155d:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101564:	00 00 00 
80101567:	e9 5e ff ff ff       	jmp    801014ca <iput+0x8a>
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101570 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	83 ec 3c             	sub    $0x3c,%esp
80101579:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010157c:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101581:	85 c0                	test   %eax,%eax
80101583:	0f 84 90 00 00 00    	je     80101619 <balloc+0xa9>
80101589:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101590:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101593:	c1 f8 0c             	sar    $0xc,%eax
80101596:	03 05 f8 09 11 80    	add    0x801109f8,%eax
8010159c:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a0:	8b 45 d8             	mov    -0x28(%ebp),%eax
801015a3:	89 04 24             	mov    %eax,(%esp)
801015a6:	e8 65 eb ff ff       	call   80100110 <bread>
801015ab:	8b 15 e0 09 11 80    	mov    0x801109e0,%edx
801015b1:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801015b4:	89 55 e0             	mov    %edx,-0x20(%ebp)
801015b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015ba:	31 c0                	xor    %eax,%eax
801015bc:	eb 35                	jmp    801015f3 <balloc+0x83>
801015be:	66 90                	xchg   %ax,%ax
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015c0:	89 c1                	mov    %eax,%ecx
801015c2:	bf 01 00 00 00       	mov    $0x1,%edi
801015c7:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015ca:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015cc:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015ce:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801015d1:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015d4:	89 7d d4             	mov    %edi,-0x2c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015d7:	0f b6 74 11 5c       	movzbl 0x5c(%ecx,%edx,1),%esi
801015dc:	89 f1                	mov    %esi,%ecx
801015de:	0f b6 f9             	movzbl %cl,%edi
801015e1:	85 7d d4             	test   %edi,-0x2c(%ebp)
801015e4:	74 42                	je     80101628 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801015e6:	83 c0 01             	add    $0x1,%eax
801015e9:	83 c3 01             	add    $0x1,%ebx
801015ec:	3d 00 10 00 00       	cmp    $0x1000,%eax
801015f1:	74 05                	je     801015f8 <balloc+0x88>
801015f3:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
801015f6:	72 c8                	jb     801015c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801015f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015fb:	89 14 24             	mov    %edx,(%esp)
801015fe:	e8 3d ea ff ff       	call   80100040 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101603:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010160a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010160d:	39 0d e0 09 11 80    	cmp    %ecx,0x801109e0
80101613:	0f 87 77 ff ff ff    	ja     80101590 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101619:	c7 04 24 9e 72 10 80 	movl   $0x8010729e,(%esp)
80101620:	e8 ab ed ff ff       	call   801003d0 <panic>
80101625:	8d 76 00             	lea    0x0(%esi),%esi
80101628:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
8010162b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010162e:	09 f1                	or     %esi,%ecx
80101630:	88 4c 17 5c          	mov    %cl,0x5c(%edi,%edx,1)
        log_write(bp);
80101634:	89 3c 24             	mov    %edi,(%esp)
80101637:	e8 94 14 00 00       	call   80102ad0 <log_write>
        brelse(bp);
8010163c:	89 3c 24             	mov    %edi,(%esp)
8010163f:	e8 fc e9 ff ff       	call   80100040 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101644:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101647:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010164b:	89 04 24             	mov    %eax,(%esp)
8010164e:	e8 bd ea ff ff       	call   80100110 <bread>
  memset(bp->data, 0, BSIZE);
80101653:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010165a:	00 
8010165b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101662:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101663:	89 c6                	mov    %eax,%esi
  memset(bp->data, 0, BSIZE);
80101665:	8d 40 5c             	lea    0x5c(%eax),%eax
80101668:	89 04 24             	mov    %eax,(%esp)
8010166b:	e8 d0 2f 00 00       	call   80104640 <memset>
  log_write(bp);
80101670:	89 34 24             	mov    %esi,(%esp)
80101673:	e8 58 14 00 00       	call   80102ad0 <log_write>
  brelse(bp);
80101678:	89 34 24             	mov    %esi,(%esp)
8010167b:	e8 c0 e9 ff ff       	call   80100040 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101680:	83 c4 3c             	add    $0x3c,%esp
80101683:	89 d8                	mov    %ebx,%eax
80101685:	5b                   	pop    %ebx
80101686:	5e                   	pop    %esi
80101687:	5f                   	pop    %edi
80101688:	5d                   	pop    %ebp
80101689:	c3                   	ret    
8010168a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101690 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101696:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101699:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010169c:	89 c3                	mov    %eax,%ebx
8010169e:	89 75 f8             	mov    %esi,-0x8(%ebp)
801016a1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801016a4:	77 1a                	ja     801016c0 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
801016a6:	8d 7a 14             	lea    0x14(%edx),%edi
801016a9:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 6f                	je     80101720 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801016b1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801016b4:	8b 75 f8             	mov    -0x8(%ebp),%esi
801016b7:	8b 7d fc             	mov    -0x4(%ebp),%edi
801016ba:	89 ec                	mov    %ebp,%esp
801016bc:	5d                   	pop    %ebp
801016bd:	c3                   	ret    
801016be:	66 90                	xchg   %ax,%ax
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801016c0:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
801016c3:	83 ff 7f             	cmp    $0x7f,%edi
801016c6:	77 7f                	ja     80101747 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801016c8:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801016ce:	85 c0                	test   %eax,%eax
801016d0:	74 66                	je     80101738 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801016d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801016d6:	8b 03                	mov    (%ebx),%eax
801016d8:	89 04 24             	mov    %eax,(%esp)
801016db:	e8 30 ea ff ff       	call   80100110 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801016e0:	8d 7c b8 5c          	lea    0x5c(%eax,%edi,4),%edi

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801016e4:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801016e6:	8b 07                	mov    (%edi),%eax
801016e8:	85 c0                	test   %eax,%eax
801016ea:	75 17                	jne    80101703 <bmap+0x73>
      a[bn] = addr = balloc(ip->dev);
801016ec:	8b 03                	mov    (%ebx),%eax
801016ee:	e8 7d fe ff ff       	call   80101570 <balloc>
801016f3:	89 07                	mov    %eax,(%edi)
      log_write(bp);
801016f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801016f8:	89 34 24             	mov    %esi,(%esp)
801016fb:	e8 d0 13 00 00       	call   80102ad0 <log_write>
80101700:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
80101703:	89 34 24             	mov    %esi,(%esp)
80101706:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101709:	e8 32 e9 ff ff       	call   80100040 <brelse>
    return addr;
8010170e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }

  panic("bmap: out of range");
}
80101711:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101714:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101717:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010171a:	89 ec                	mov    %ebp,%esp
8010171c:	5d                   	pop    %ebp
8010171d:	c3                   	ret    
8010171e:	66 90                	xchg   %ax,%ax
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101720:	8b 03                	mov    (%ebx),%eax
80101722:	e8 49 fe ff ff       	call   80101570 <balloc>
80101727:	89 44 bb 0c          	mov    %eax,0xc(%ebx,%edi,4)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010172b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010172e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101731:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101734:	89 ec                	mov    %ebp,%esp
80101736:	5d                   	pop    %ebp
80101737:	c3                   	ret    
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101738:	8b 03                	mov    (%ebx),%eax
8010173a:	e8 31 fe ff ff       	call   80101570 <balloc>
8010173f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101745:	eb 8b                	jmp    801016d2 <bmap+0x42>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101747:	c7 04 24 b4 72 10 80 	movl   $0x801072b4,(%esp)
8010174e:	e8 7d ec ff ff       	call   801003d0 <panic>
80101753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101760 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	83 ec 38             	sub    $0x38,%esp
80101766:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101769:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010176c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010176f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101772:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101775:	8b 75 10             	mov    0x10(%ebp),%esi
80101778:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010177b:	66 83 7b 50 03       	cmpw   $0x3,0x50(%ebx)
80101780:	74 1e                	je     801017a0 <writei+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101782:	39 73 58             	cmp    %esi,0x58(%ebx)
80101785:	73 41                	jae    801017c8 <writei+0x68>

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101787:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010178c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010178f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101792:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101795:	89 ec                	mov    %ebp,%esp
80101797:	5d                   	pop    %ebp
80101798:	c3                   	ret    
80101799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801017a0:	0f b7 43 52          	movzwl 0x52(%ebx),%eax
801017a4:	66 83 f8 09          	cmp    $0x9,%ax
801017a8:	77 dd                	ja     80101787 <writei+0x27>
801017aa:	98                   	cwtl   
801017ab:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
801017b2:	85 c0                	test   %eax,%eax
801017b4:	74 d1                	je     80101787 <writei+0x27>
      return -1;
    return devsw[ip->major].write(ip, src, n);
801017b6:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
801017b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801017bc:	8b 75 f8             	mov    -0x8(%ebp),%esi
801017bf:	8b 7d fc             	mov    -0x4(%ebp),%edi
801017c2:	89 ec                	mov    %ebp,%esp
801017c4:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
801017c5:	ff e0                	jmp    *%eax
801017c7:	90                   	nop
  }

  if(off > ip->size || off + n < off)
801017c8:	89 f8                	mov    %edi,%eax
801017ca:	01 f0                	add    %esi,%eax
801017cc:	72 b9                	jb     80101787 <writei+0x27>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801017ce:	3d 00 18 01 00       	cmp    $0x11800,%eax
801017d3:	77 b2                	ja     80101787 <writei+0x27>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801017d5:	85 ff                	test   %edi,%edi
801017d7:	0f 84 8a 00 00 00    	je     80101867 <writei+0x107>
801017dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801017e4:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017e7:	89 7d dc             	mov    %edi,-0x24(%ebp)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017ea:	89 f2                	mov    %esi,%edx
801017ec:	89 d8                	mov    %ebx,%eax
801017ee:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801017f1:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017f6:	e8 95 fe ff ff       	call   80101690 <bmap>
801017fb:	89 44 24 04          	mov    %eax,0x4(%esp)
801017ff:	8b 03                	mov    (%ebx),%eax
80101801:	89 04 24             	mov    %eax,(%esp)
80101804:	e8 07 e9 ff ff       	call   80100110 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101809:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010180c:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010180f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101811:	89 f0                	mov    %esi,%eax
80101813:	25 ff 01 00 00       	and    $0x1ff,%eax
80101818:	29 c7                	sub    %eax,%edi
8010181a:	39 cf                	cmp    %ecx,%edi
8010181c:	0f 47 f9             	cmova  %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
8010181f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101822:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101826:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101828:	89 55 d8             	mov    %edx,-0x28(%ebp)
8010182b:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010182f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101833:	89 04 24             	mov    %eax,(%esp)
80101836:	e8 d5 2e 00 00       	call   80104710 <memmove>
    log_write(bp);
8010183b:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010183e:	89 14 24             	mov    %edx,(%esp)
80101841:	e8 8a 12 00 00       	call   80102ad0 <log_write>
    brelse(bp);
80101846:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101849:	89 14 24             	mov    %edx,(%esp)
8010184c:	e8 ef e7 ff ff       	call   80100040 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101851:	01 7d e4             	add    %edi,-0x1c(%ebp)
80101854:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101857:	01 7d e0             	add    %edi,-0x20(%ebp)
8010185a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
8010185d:	77 8b                	ja     801017ea <writei+0x8a>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010185f:	3b 73 58             	cmp    0x58(%ebx),%esi
80101862:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101865:	77 07                	ja     8010186e <writei+0x10e>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101867:	89 f8                	mov    %edi,%eax
80101869:	e9 1e ff ff ff       	jmp    8010178c <writei+0x2c>
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
8010186e:	89 73 58             	mov    %esi,0x58(%ebx)
    iupdate(ip);
80101871:	89 1c 24             	mov    %ebx,(%esp)
80101874:	e8 47 fa ff ff       	call   801012c0 <iupdate>
  }
  return n;
80101879:	89 f8                	mov    %edi,%eax
8010187b:	e9 0c ff ff ff       	jmp    8010178c <writei+0x2c>

80101880 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	83 ec 38             	sub    $0x38,%esp
80101886:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101889:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010188c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010188f:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101892:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101895:	8b 75 10             	mov    0x10(%ebp),%esi
80101898:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010189b:	66 83 7b 50 03       	cmpw   $0x3,0x50(%ebx)
801018a0:	74 1e                	je     801018c0 <readi+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801018a2:	8b 43 58             	mov    0x58(%ebx),%eax
801018a5:	39 f0                	cmp    %esi,%eax
801018a7:	73 3f                	jae    801018e8 <readi+0x68>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801018a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801018ae:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801018b1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801018b4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801018b7:	89 ec                	mov    %ebp,%esp
801018b9:	5d                   	pop    %ebp
801018ba:	c3                   	ret    
801018bb:	90                   	nop
801018bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801018c0:	0f b7 43 52          	movzwl 0x52(%ebx),%eax
801018c4:	66 83 f8 09          	cmp    $0x9,%ax
801018c8:	77 df                	ja     801018a9 <readi+0x29>
801018ca:	98                   	cwtl   
801018cb:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
801018d2:	85 c0                	test   %eax,%eax
801018d4:	74 d3                	je     801018a9 <readi+0x29>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018d6:	89 4d 10             	mov    %ecx,0x10(%ebp)
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
801018d9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801018dc:	8b 75 f8             	mov    -0x8(%ebp),%esi
801018df:	8b 7d fc             	mov    -0x4(%ebp),%edi
801018e2:	89 ec                	mov    %ebp,%esp
801018e4:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018e5:	ff e0                	jmp    *%eax
801018e7:	90                   	nop
  }

  if(off > ip->size || off + n < off)
801018e8:	89 ca                	mov    %ecx,%edx
801018ea:	01 f2                	add    %esi,%edx
801018ec:	89 55 e0             	mov    %edx,-0x20(%ebp)
801018ef:	72 b8                	jb     801018a9 <readi+0x29>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801018f1:	89 c2                	mov    %eax,%edx
801018f3:	29 f2                	sub    %esi,%edx
801018f5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
801018f8:	0f 42 ca             	cmovb  %edx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801018fb:	85 c9                	test   %ecx,%ecx
801018fd:	74 7e                	je     8010197d <readi+0xfd>
801018ff:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101906:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101909:	89 4d dc             	mov    %ecx,-0x24(%ebp)
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101910:	89 f2                	mov    %esi,%edx
80101912:	89 d8                	mov    %ebx,%eax
80101914:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101917:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010191c:	e8 6f fd ff ff       	call   80101690 <bmap>
80101921:	89 44 24 04          	mov    %eax,0x4(%esp)
80101925:	8b 03                	mov    (%ebx),%eax
80101927:	89 04 24             	mov    %eax,(%esp)
8010192a:	e8 e1 e7 ff ff       	call   80100110 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010192f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101932:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101935:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101937:	89 f0                	mov    %esi,%eax
80101939:	25 ff 01 00 00       	and    $0x1ff,%eax
8010193e:	29 c7                	sub    %eax,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101940:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101944:	39 cf                	cmp    %ecx,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101946:	89 44 24 04          	mov    %eax,0x4(%esp)
8010194a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
8010194d:	0f 47 f9             	cmova  %ecx,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101950:	89 55 d8             	mov    %edx,-0x28(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101953:	01 fe                	add    %edi,%esi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101955:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101959:	89 04 24             	mov    %eax,(%esp)
8010195c:	e8 af 2d 00 00       	call   80104710 <memmove>
    brelse(bp);
80101961:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101964:	89 14 24             	mov    %edx,(%esp)
80101967:	e8 d4 e6 ff ff       	call   80100040 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010196c:	01 7d e4             	add    %edi,-0x1c(%ebp)
8010196f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101972:	01 7d e0             	add    %edi,-0x20(%ebp)
80101975:	39 55 dc             	cmp    %edx,-0x24(%ebp)
80101978:	77 96                	ja     80101910 <readi+0x90>
8010197a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010197d:	89 c8                	mov    %ecx,%eax
8010197f:	e9 2a ff ff ff       	jmp    801018ae <readi+0x2e>
80101984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010198a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101990 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 2c             	sub    $0x2c,%esp
80101999:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010199c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801019a1:	0f 85 8c 00 00 00    	jne    80101a33 <dirlookup+0xa3>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019a7:	8b 4b 58             	mov    0x58(%ebx),%ecx
801019aa:	85 c9                	test   %ecx,%ecx
801019ac:	74 4c                	je     801019fa <dirlookup+0x6a>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
801019ae:	8d 7d d8             	lea    -0x28(%ebp),%edi
801019b1:	31 f6                	xor    %esi,%esi
801019b3:	90                   	nop
801019b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801019b8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801019bf:	00 
801019c0:	89 74 24 08          	mov    %esi,0x8(%esp)
801019c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
801019c8:	89 1c 24             	mov    %ebx,(%esp)
801019cb:	e8 b0 fe ff ff       	call   80101880 <readi>
801019d0:	83 f8 10             	cmp    $0x10,%eax
801019d3:	75 52                	jne    80101a27 <dirlookup+0x97>
      panic("dirlink read");
    if(de.inum == 0)
801019d5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801019da:	74 16                	je     801019f2 <dirlookup+0x62>
      continue;
    if(namecmp(name, de.name) == 0){
801019dc:	8d 45 da             	lea    -0x26(%ebp),%eax
801019df:	89 44 24 04          	mov    %eax,0x4(%esp)
801019e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801019e6:	89 04 24             	mov    %eax,(%esp)
801019e9:	e8 a2 f8 ff ff       	call   80101290 <namecmp>
801019ee:	85 c0                	test   %eax,%eax
801019f0:	74 16                	je     80101a08 <dirlookup+0x78>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019f2:	83 c6 10             	add    $0x10,%esi
801019f5:	39 73 58             	cmp    %esi,0x58(%ebx)
801019f8:	77 be                	ja     801019b8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801019fa:	83 c4 2c             	add    $0x2c,%esp
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019fd:	31 c0                	xor    %eax,%eax
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801019ff:	5b                   	pop    %ebx
80101a00:	5e                   	pop    %esi
80101a01:	5f                   	pop    %edi
80101a02:	5d                   	pop    %ebp
80101a03:	c3                   	ret    
80101a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
      // entry matches path element
      if(poff)
80101a08:	8b 55 10             	mov    0x10(%ebp),%edx
80101a0b:	85 d2                	test   %edx,%edx
80101a0d:	74 05                	je     80101a14 <dirlookup+0x84>
        *poff = off;
80101a0f:	8b 45 10             	mov    0x10(%ebp),%eax
80101a12:	89 30                	mov    %esi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101a14:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101a18:	8b 03                	mov    (%ebx),%eax
80101a1a:	e8 b1 f7 ff ff       	call   801011d0 <iget>
    }
  }

  return 0;
}
80101a1f:	83 c4 2c             	add    $0x2c,%esp
80101a22:	5b                   	pop    %ebx
80101a23:	5e                   	pop    %esi
80101a24:	5f                   	pop    %edi
80101a25:	5d                   	pop    %ebp
80101a26:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101a27:	c7 04 24 d9 72 10 80 	movl   $0x801072d9,(%esp)
80101a2e:	e8 9d e9 ff ff       	call   801003d0 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101a33:	c7 04 24 c7 72 10 80 	movl   $0x801072c7,(%esp)
80101a3a:	e8 91 e9 ff ff       	call   801003d0 <panic>
80101a3f:	90                   	nop

80101a40 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 2c             	sub    $0x2c,%esp
80101a49:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a4f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101a56:	00 
80101a57:	89 34 24             	mov    %esi,(%esp)
80101a5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a5e:	e8 2d ff ff ff       	call   80101990 <dirlookup>
80101a63:	85 c0                	test   %eax,%eax
80101a65:	0f 85 89 00 00 00    	jne    80101af4 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101a6b:	8b 5e 58             	mov    0x58(%esi),%ebx
80101a6e:	85 db                	test   %ebx,%ebx
80101a70:	0f 84 8d 00 00 00    	je     80101b03 <dirlink+0xc3>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
80101a76:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101a79:	31 db                	xor    %ebx,%ebx
80101a7b:	eb 0b                	jmp    80101a88 <dirlink+0x48>
80101a7d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101a80:	83 c3 10             	add    $0x10,%ebx
80101a83:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101a86:	76 24                	jbe    80101aac <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101a88:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101a8f:	00 
80101a90:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a94:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101a98:	89 34 24             	mov    %esi,(%esp)
80101a9b:	e8 e0 fd ff ff       	call   80101880 <readi>
80101aa0:	83 f8 10             	cmp    $0x10,%eax
80101aa3:	75 65                	jne    80101b0a <dirlink+0xca>
      panic("dirlink read");
    if(de.inum == 0)
80101aa5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101aaa:	75 d4                	jne    80101a80 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101aac:	8b 45 0c             	mov    0xc(%ebp),%eax
80101aaf:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ab6:	00 
80101ab7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101abb:	8d 45 da             	lea    -0x26(%ebp),%eax
80101abe:	89 04 24             	mov    %eax,(%esp)
80101ac1:	e8 1a 2d 00 00       	call   801047e0 <strncpy>
  de.inum = inum;
80101ac6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ac9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ad0:	00 
80101ad1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ad5:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101ad9:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101add:	89 34 24             	mov    %esi,(%esp)
80101ae0:	e8 7b fc ff ff       	call   80101760 <writei>
80101ae5:	83 f8 10             	cmp    $0x10,%eax
80101ae8:	75 2c                	jne    80101b16 <dirlink+0xd6>
    panic("dirlink");
80101aea:	31 c0                	xor    %eax,%eax

  return 0;
}
80101aec:	83 c4 2c             	add    $0x2c,%esp
80101aef:	5b                   	pop    %ebx
80101af0:	5e                   	pop    %esi
80101af1:	5f                   	pop    %edi
80101af2:	5d                   	pop    %ebp
80101af3:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101af4:	89 04 24             	mov    %eax,(%esp)
80101af7:	e8 44 f9 ff ff       	call   80101440 <iput>
80101afc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
80101b01:	eb e9                	jmp    80101aec <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b03:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101b06:	31 db                	xor    %ebx,%ebx
80101b08:	eb a2                	jmp    80101aac <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101b0a:	c7 04 24 d9 72 10 80 	movl   $0x801072d9,(%esp)
80101b11:	e8 ba e8 ff ff       	call   801003d0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101b16:	c7 04 24 ea 78 10 80 	movl   $0x801078ea,(%esp)
80101b1d:	e8 ae e8 ff ff       	call   801003d0 <panic>
80101b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b30 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	57                   	push   %edi
80101b34:	56                   	push   %esi
80101b35:	53                   	push   %ebx
80101b36:	83 ec 2c             	sub    $0x2c,%esp
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b3c:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101b43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b46:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
80101b4a:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b4e:	0f 86 95 00 00 00    	jbe    80101be9 <ialloc+0xb9>
80101b54:	be 01 00 00 00       	mov    $0x1,%esi
80101b59:	bb 01 00 00 00       	mov    $0x1,%ebx
80101b5e:	eb 15                	jmp    80101b75 <ialloc+0x45>
80101b60:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101b63:	89 3c 24             	mov    %edi,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b66:	89 de                	mov    %ebx,%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101b68:	e8 d3 e4 ff ff       	call   80100040 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b6d:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101b73:	76 74                	jbe    80101be9 <ialloc+0xb9>
    bp = bread(dev, IBLOCK(inum, sb));
80101b75:	89 f0                	mov    %esi,%eax
80101b77:	c1 e8 03             	shr    $0x3,%eax
80101b7a:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101b80:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b84:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b87:	89 04 24             	mov    %eax,(%esp)
80101b8a:	e8 81 e5 ff ff       	call   80100110 <bread>
80101b8f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101b91:	89 f0                	mov    %esi,%eax
80101b93:	83 e0 07             	and    $0x7,%eax
80101b96:	c1 e0 06             	shl    $0x6,%eax
80101b99:	8d 54 07 5c          	lea    0x5c(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
80101b9d:	66 83 3a 00          	cmpw   $0x0,(%edx)
80101ba1:	75 bd                	jne    80101b60 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101ba3:	89 14 24             	mov    %edx,(%esp)
80101ba6:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ba9:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101bb0:	00 
80101bb1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101bb8:	00 
80101bb9:	e8 82 2a 00 00       	call   80104640 <memset>
      dip->type = type;
80101bbe:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101bc1:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
80101bc5:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
80101bc8:	89 3c 24             	mov    %edi,(%esp)
80101bcb:	e8 00 0f 00 00       	call   80102ad0 <log_write>
      brelse(bp);
80101bd0:	89 3c 24             	mov    %edi,(%esp)
80101bd3:	e8 68 e4 ff ff       	call   80100040 <brelse>
      return iget(dev, inum);
80101bd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bdb:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101bdd:	83 c4 2c             	add    $0x2c,%esp
80101be0:	5b                   	pop    %ebx
80101be1:	5e                   	pop    %esi
80101be2:	5f                   	pop    %edi
80101be3:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101be4:	e9 e7 f5 ff ff       	jmp    801011d0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101be9:	c7 04 24 e6 72 10 80 	movl   $0x801072e6,(%esp)
80101bf0:	e8 db e7 ff ff       	call   801003d0 <panic>
80101bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c00 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	83 ec 18             	sub    $0x18,%esp
80101c06:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c0c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c0f:	85 db                	test   %ebx,%ebx
80101c11:	74 27                	je     80101c3a <iunlock+0x3a>
80101c13:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c16:	89 34 24             	mov    %esi,(%esp)
80101c19:	e8 e2 26 00 00       	call   80104300 <holdingsleep>
80101c1e:	85 c0                	test   %eax,%eax
80101c20:	74 18                	je     80101c3a <iunlock+0x3a>
80101c22:	8b 43 08             	mov    0x8(%ebx),%eax
80101c25:	85 c0                	test   %eax,%eax
80101c27:	7e 11                	jle    80101c3a <iunlock+0x3a>
    panic("iunlock");

  releasesleep(&ip->lock);
80101c29:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101c2c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101c2f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101c32:	89 ec                	mov    %ebp,%esp
80101c34:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
80101c35:	e9 f6 26 00 00       	jmp    80104330 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101c3a:	c7 04 24 f8 72 10 80 	movl   $0x801072f8,(%esp)
80101c41:	e8 8a e7 ff ff       	call   801003d0 <panic>
80101c46:	8d 76 00             	lea    0x0(%esi),%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c50 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	53                   	push   %ebx
80101c54:	83 ec 14             	sub    $0x14,%esp
80101c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c5a:	89 1c 24             	mov    %ebx,(%esp)
80101c5d:	e8 9e ff ff ff       	call   80101c00 <iunlock>
  iput(ip);
80101c62:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101c65:	83 c4 14             	add    $0x14,%esp
80101c68:	5b                   	pop    %ebx
80101c69:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101c6a:	e9 d1 f7 ff ff       	jmp    80101440 <iput>
80101c6f:	90                   	nop

80101c70 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	56                   	push   %esi
80101c74:	53                   	push   %ebx
80101c75:	83 ec 10             	sub    $0x10,%esp
80101c78:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101c7b:	85 db                	test   %ebx,%ebx
80101c7d:	0f 84 b0 00 00 00    	je     80101d33 <ilock+0xc3>
80101c83:	8b 53 08             	mov    0x8(%ebx),%edx
80101c86:	85 d2                	test   %edx,%edx
80101c88:	0f 8e a5 00 00 00    	jle    80101d33 <ilock+0xc3>
    panic("ilock");

  acquiresleep(&ip->lock);
80101c8e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c91:	89 04 24             	mov    %eax,(%esp)
80101c94:	e8 d7 26 00 00       	call   80104370 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101c99:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
80101c9d:	74 09                	je     80101ca8 <ilock+0x38>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101c9f:	83 c4 10             	add    $0x10,%esp
80101ca2:	5b                   	pop    %ebx
80101ca3:	5e                   	pop    %esi
80101ca4:	5d                   	pop    %ebp
80101ca5:	c3                   	ret    
80101ca6:	66 90                	xchg   %ax,%ax
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101ca8:	8b 43 04             	mov    0x4(%ebx),%eax
80101cab:	c1 e8 03             	shr    $0x3,%eax
80101cae:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101cb4:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cb8:	8b 03                	mov    (%ebx),%eax
80101cba:	89 04 24             	mov    %eax,(%esp)
80101cbd:	e8 4e e4 ff ff       	call   80100110 <bread>
80101cc2:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cc4:	8b 43 04             	mov    0x4(%ebx),%eax
80101cc7:	83 e0 07             	and    $0x7,%eax
80101cca:	c1 e0 06             	shl    $0x6,%eax
80101ccd:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101cd1:	0f b7 10             	movzwl (%eax),%edx
80101cd4:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101cd8:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101cdc:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101ce0:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101ce4:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101ce8:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101cec:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101cf0:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cf3:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
80101cf6:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cf9:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cfd:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101d00:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101d07:	00 
80101d08:	89 04 24             	mov    %eax,(%esp)
80101d0b:	e8 00 2a 00 00       	call   80104710 <memmove>
    brelse(bp);
80101d10:	89 34 24             	mov    %esi,(%esp)
80101d13:	e8 28 e3 ff ff       	call   80100040 <brelse>
    ip->flags |= I_VALID;
80101d18:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101d1c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101d21:	0f 85 78 ff ff ff    	jne    80101c9f <ilock+0x2f>
      panic("ilock: no type");
80101d27:	c7 04 24 06 73 10 80 	movl   $0x80107306,(%esp)
80101d2e:	e8 9d e6 ff ff       	call   801003d0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101d33:	c7 04 24 00 73 10 80 	movl   $0x80107300,(%esp)
80101d3a:	e8 91 e6 ff ff       	call   801003d0 <panic>
80101d3f:	90                   	nop

80101d40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	89 c3                	mov    %eax,%ebx
80101d48:	83 ec 2c             	sub    $0x2c,%esp
80101d4b:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d4e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101d51:	80 38 2f             	cmpb   $0x2f,(%eax)
80101d54:	0f 84 14 01 00 00    	je     80101e6e <namex+0x12e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101d5a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101d60:	8b 40 68             	mov    0x68(%eax),%eax
80101d63:	89 04 24             	mov    %eax,(%esp)
80101d66:	e8 35 f4 ff ff       	call   801011a0 <idup>
80101d6b:	89 c7                	mov    %eax,%edi
80101d6d:	eb 04                	jmp    80101d73 <namex+0x33>
80101d6f:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101d70:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101d73:	0f b6 03             	movzbl (%ebx),%eax
80101d76:	3c 2f                	cmp    $0x2f,%al
80101d78:	74 f6                	je     80101d70 <namex+0x30>
    path++;
  if(*path == 0)
80101d7a:	84 c0                	test   %al,%al
80101d7c:	75 1a                	jne    80101d98 <namex+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d7e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d81:	85 c9                	test   %ecx,%ecx
80101d83:	0f 85 0d 01 00 00    	jne    80101e96 <namex+0x156>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d89:	83 c4 2c             	add    $0x2c,%esp
80101d8c:	89 f8                	mov    %edi,%eax
80101d8e:	5b                   	pop    %ebx
80101d8f:	5e                   	pop    %esi
80101d90:	5f                   	pop    %edi
80101d91:	5d                   	pop    %ebp
80101d92:	c3                   	ret    
80101d93:	90                   	nop
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d98:	3c 2f                	cmp    $0x2f,%al
80101d9a:	0f 84 91 00 00 00    	je     80101e31 <namex+0xf1>
80101da0:	89 de                	mov    %ebx,%esi
80101da2:	eb 08                	jmp    80101dac <namex+0x6c>
80101da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101da8:	3c 2f                	cmp    $0x2f,%al
80101daa:	74 0a                	je     80101db6 <namex+0x76>
    path++;
80101dac:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101daf:	0f b6 06             	movzbl (%esi),%eax
80101db2:	84 c0                	test   %al,%al
80101db4:	75 f2                	jne    80101da8 <namex+0x68>
80101db6:	89 f2                	mov    %esi,%edx
80101db8:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101dba:	83 fa 0d             	cmp    $0xd,%edx
80101dbd:	7e 79                	jle    80101e38 <namex+0xf8>
    memmove(name, s, DIRSIZ);
80101dbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101dc2:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101dc9:	00 
80101dca:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dce:	89 04 24             	mov    %eax,(%esp)
80101dd1:	e8 3a 29 00 00       	call   80104710 <memmove>
80101dd6:	eb 03                	jmp    80101ddb <namex+0x9b>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
80101dd8:	83 c6 01             	add    $0x1,%esi
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ddb:	80 3e 2f             	cmpb   $0x2f,(%esi)
80101dde:	74 f8                	je     80101dd8 <namex+0x98>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80101de0:	85 f6                	test   %esi,%esi
80101de2:	74 9a                	je     80101d7e <namex+0x3e>
    ilock(ip);
80101de4:	89 3c 24             	mov    %edi,(%esp)
80101de7:	e8 84 fe ff ff       	call   80101c70 <ilock>
    if(ip->type != T_DIR){
80101dec:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80101df1:	75 67                	jne    80101e5a <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101df3:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101df6:	85 db                	test   %ebx,%ebx
80101df8:	74 09                	je     80101e03 <namex+0xc3>
80101dfa:	80 3e 00             	cmpb   $0x0,(%esi)
80101dfd:	0f 84 81 00 00 00    	je     80101e84 <namex+0x144>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e06:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e0d:	00 
80101e0e:	89 3c 24             	mov    %edi,(%esp)
80101e11:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e15:	e8 76 fb ff ff       	call   80101990 <dirlookup>
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	89 c3                	mov    %eax,%ebx
80101e1e:	74 3a                	je     80101e5a <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
80101e20:	89 3c 24             	mov    %edi,(%esp)
80101e23:	89 df                	mov    %ebx,%edi
80101e25:	89 f3                	mov    %esi,%ebx
80101e27:	e8 24 fe ff ff       	call   80101c50 <iunlockput>
80101e2c:	e9 42 ff ff ff       	jmp    80101d73 <namex+0x33>
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e31:	89 de                	mov    %ebx,%esi
80101e33:	31 d2                	xor    %edx,%edx
80101e35:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e3b:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e3f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e42:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e46:	89 04 24             	mov    %eax,(%esp)
80101e49:	e8 c2 28 00 00       	call   80104710 <memmove>
    name[len] = 0;
80101e4e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e54:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
80101e58:	eb 81                	jmp    80101ddb <namex+0x9b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
80101e5a:	89 3c 24             	mov    %edi,(%esp)
80101e5d:	31 ff                	xor    %edi,%edi
80101e5f:	e8 ec fd ff ff       	call   80101c50 <iunlockput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e64:	83 c4 2c             	add    $0x2c,%esp
80101e67:	89 f8                	mov    %edi,%eax
80101e69:	5b                   	pop    %ebx
80101e6a:	5e                   	pop    %esi
80101e6b:	5f                   	pop    %edi
80101e6c:	5d                   	pop    %ebp
80101e6d:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e6e:	ba 01 00 00 00       	mov    $0x1,%edx
80101e73:	b8 01 00 00 00       	mov    $0x1,%eax
80101e78:	e8 53 f3 ff ff       	call   801011d0 <iget>
80101e7d:	89 c7                	mov    %eax,%edi
80101e7f:	e9 ef fe ff ff       	jmp    80101d73 <namex+0x33>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e84:	89 3c 24             	mov    %edi,(%esp)
80101e87:	e8 74 fd ff ff       	call   80101c00 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e8c:	83 c4 2c             	add    $0x2c,%esp
80101e8f:	89 f8                	mov    %edi,%eax
80101e91:	5b                   	pop    %ebx
80101e92:	5e                   	pop    %esi
80101e93:	5f                   	pop    %edi
80101e94:	5d                   	pop    %ebp
80101e95:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e96:	89 3c 24             	mov    %edi,(%esp)
80101e99:	31 ff                	xor    %edi,%edi
80101e9b:	e8 a0 f5 ff ff       	call   80101440 <iput>
    return 0;
80101ea0:	e9 e4 fe ff ff       	jmp    80101d89 <namex+0x49>
80101ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <nameiparent>:
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101eb0:	55                   	push   %ebp
  return namex(path, 1, name);
80101eb1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101eb6:	89 e5                	mov    %esp,%ebp
80101eb8:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80101ebb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ebe:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ec1:	c9                   	leave  
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101ec2:	e9 79 fe ff ff       	jmp    80101d40 <namex>
80101ec7:	89 f6                	mov    %esi,%esi
80101ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ed0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ed0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ed1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ed3:	89 e5                	mov    %esp,%ebp
80101ed5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ed8:	8b 45 08             	mov    0x8(%ebp),%eax
80101edb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ede:	e8 5d fe ff ff       	call   80101d40 <namex>
}
80101ee3:	c9                   	leave  
80101ee4:	c3                   	ret    
80101ee5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ef0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	53                   	push   %ebx
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101ef4:	31 db                	xor    %ebx,%ebx
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101ef6:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101ef9:	c7 44 24 04 15 73 10 	movl   $0x80107315,0x4(%esp)
80101f00:	80 
80101f01:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101f08:	e8 03 25 00 00       	call   80104410 <initlock>
80101f0d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101f10:	8d 04 db             	lea    (%ebx,%ebx,8),%eax
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101f13:	83 c3 01             	add    $0x1,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101f16:	c1 e0 04             	shl    $0x4,%eax
80101f19:	05 40 0a 11 80       	add    $0x80110a40,%eax
80101f1e:	c7 44 24 04 1c 73 10 	movl   $0x8010731c,0x4(%esp)
80101f25:	80 
80101f26:	89 04 24             	mov    %eax,(%esp)
80101f29:	e8 a2 24 00 00       	call   801043d0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101f2e:	83 fb 32             	cmp    $0x32,%ebx
80101f31:	75 dd                	jne    80101f10 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
80101f33:	8b 45 08             	mov    0x8(%ebp),%eax
80101f36:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101f3d:	80 
80101f3e:	89 04 24             	mov    %eax,(%esp)
80101f41:	e8 0a f4 ff ff       	call   80101350 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101f46:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80101f4b:	c7 04 24 24 73 10 80 	movl   $0x80107324,(%esp)
80101f52:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101f56:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80101f5b:	89 44 24 18          	mov    %eax,0x18(%esp)
80101f5f:	a1 f0 09 11 80       	mov    0x801109f0,%eax
80101f64:	89 44 24 14          	mov    %eax,0x14(%esp)
80101f68:	a1 ec 09 11 80       	mov    0x801109ec,%eax
80101f6d:	89 44 24 10          	mov    %eax,0x10(%esp)
80101f71:	a1 e8 09 11 80       	mov    0x801109e8,%eax
80101f76:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101f7a:	a1 e4 09 11 80       	mov    0x801109e4,%eax
80101f7f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f83:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101f88:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f8c:	e8 df e8 ff ff       	call   80100870 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101f91:	83 c4 24             	add    $0x24,%esp
80101f94:	5b                   	pop    %ebx
80101f95:	5d                   	pop    %ebp
80101f96:	c3                   	ret    
	...

80101fa0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 c1                	mov    %eax,%ecx
80101fa3:	89 e5                	mov    %esp,%ebp
80101fa5:	56                   	push   %esi
80101fa6:	53                   	push   %ebx
80101fa7:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101faa:	85 c0                	test   %eax,%eax
80101fac:	0f 84 99 00 00 00    	je     8010204b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101fb2:	8b 58 08             	mov    0x8(%eax),%ebx
80101fb5:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101fbb:	0f 87 7e 00 00 00    	ja     8010203f <idestart+0x9f>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fc1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fc6:	66 90                	xchg   %ax,%ax
80101fc8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fc9:	25 c0 00 00 00       	and    $0xc0,%eax
80101fce:	83 f8 40             	cmp    $0x40,%eax
80101fd1:	75 f5                	jne    80101fc8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fd3:	31 f6                	xor    %esi,%esi
80101fd5:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fda:	89 f0                	mov    %esi,%eax
80101fdc:	ee                   	out    %al,(%dx)
80101fdd:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101fe2:	b8 01 00 00 00       	mov    $0x1,%eax
80101fe7:	ee                   	out    %al,(%dx)
80101fe8:	b2 f3                	mov    $0xf3,%dl
80101fea:	89 d8                	mov    %ebx,%eax
80101fec:	ee                   	out    %al,(%dx)
80101fed:	89 d8                	mov    %ebx,%eax
80101fef:	b2 f4                	mov    $0xf4,%dl
80101ff1:	c1 f8 08             	sar    $0x8,%eax
80101ff4:	ee                   	out    %al,(%dx)
80101ff5:	b2 f5                	mov    $0xf5,%dl
80101ff7:	89 f0                	mov    %esi,%eax
80101ff9:	ee                   	out    %al,(%dx)
80101ffa:	8b 41 04             	mov    0x4(%ecx),%eax
80101ffd:	b2 f6                	mov    $0xf6,%dl
80101fff:	83 e0 01             	and    $0x1,%eax
80102002:	c1 e0 04             	shl    $0x4,%eax
80102005:	83 c8 e0             	or     $0xffffffe0,%eax
80102008:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102009:	f6 01 04             	testb  $0x4,(%ecx)
8010200c:	75 12                	jne    80102020 <idestart+0x80>
8010200e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102013:	b8 20 00 00 00       	mov    $0x20,%eax
80102018:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102019:	83 c4 10             	add    $0x10,%esp
8010201c:	5b                   	pop    %ebx
8010201d:	5e                   	pop    %esi
8010201e:	5d                   	pop    %ebp
8010201f:	c3                   	ret    
80102020:	b2 f7                	mov    $0xf7,%dl
80102022:	b8 30 00 00 00       	mov    $0x30,%eax
80102027:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102028:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010202d:	8d 71 5c             	lea    0x5c(%ecx),%esi
80102030:	b9 80 00 00 00       	mov    $0x80,%ecx
80102035:	fc                   	cld    
80102036:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102038:	83 c4 10             	add    $0x10,%esp
8010203b:	5b                   	pop    %ebx
8010203c:	5e                   	pop    %esi
8010203d:	5d                   	pop    %ebp
8010203e:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010203f:	c7 04 24 80 73 10 80 	movl   $0x80107380,(%esp)
80102046:	e8 85 e3 ff ff       	call   801003d0 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010204b:	c7 04 24 77 73 10 80 	movl   $0x80107377,(%esp)
80102052:	e8 79 e3 ff ff       	call   801003d0 <panic>
80102057:	89 f6                	mov    %esi,%esi
80102059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102060 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102060:	55                   	push   %ebp
80102061:	89 e5                	mov    %esp,%ebp
80102063:	53                   	push   %ebx
80102064:	83 ec 14             	sub    $0x14,%esp
80102067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010206a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010206d:	89 04 24             	mov    %eax,(%esp)
80102070:	e8 8b 22 00 00       	call   80104300 <holdingsleep>
80102075:	85 c0                	test   %eax,%eax
80102077:	0f 84 8f 00 00 00    	je     8010210c <iderw+0xac>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010207d:	8b 03                	mov    (%ebx),%eax
8010207f:	83 e0 06             	and    $0x6,%eax
80102082:	83 f8 02             	cmp    $0x2,%eax
80102085:	0f 84 99 00 00 00    	je     80102124 <iderw+0xc4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010208b:	8b 53 04             	mov    0x4(%ebx),%edx
8010208e:	85 d2                	test   %edx,%edx
80102090:	74 09                	je     8010209b <iderw+0x3b>
80102092:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102097:	85 c0                	test   %eax,%eax
80102099:	74 7d                	je     80102118 <iderw+0xb8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010209b:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020a2:	e8 f9 24 00 00       	call   801045a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020a7:	ba b4 a5 10 80       	mov    $0x8010a5b4,%edx
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801020ac:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
801020b3:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020b8:	85 c0                	test   %eax,%eax
801020ba:	74 0e                	je     801020ca <iderw+0x6a>
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020c0:	8d 50 58             	lea    0x58(%eax),%edx
801020c3:	8b 40 58             	mov    0x58(%eax),%eax
801020c6:	85 c0                	test   %eax,%eax
801020c8:	75 f6                	jne    801020c0 <iderw+0x60>
    ;
  *pp = b;
801020ca:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801020cc:	39 1d b4 a5 10 80    	cmp    %ebx,0x8010a5b4
801020d2:	75 14                	jne    801020e8 <iderw+0x88>
801020d4:	eb 2d                	jmp    80102103 <iderw+0xa3>
801020d6:	66 90                	xchg   %ax,%ax
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
801020d8:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801020df:	80 
801020e0:	89 1c 24             	mov    %ebx,(%esp)
801020e3:	e8 28 19 00 00       	call   80103a10 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801020e8:	8b 03                	mov    (%ebx),%eax
801020ea:	83 e0 06             	and    $0x6,%eax
801020ed:	83 f8 02             	cmp    $0x2,%eax
801020f0:	75 e6                	jne    801020d8 <iderw+0x78>
    sleep(b, &idelock);
  }

  release(&idelock);
801020f2:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801020f9:	83 c4 14             	add    $0x14,%esp
801020fc:	5b                   	pop    %ebx
801020fd:	5d                   	pop    %ebp
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
801020fe:	e9 4d 24 00 00       	jmp    80104550 <release>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102103:	89 d8                	mov    %ebx,%eax
80102105:	e8 96 fe ff ff       	call   80101fa0 <idestart>
8010210a:	eb dc                	jmp    801020e8 <iderw+0x88>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010210c:	c7 04 24 92 73 10 80 	movl   $0x80107392,(%esp)
80102113:	e8 b8 e2 ff ff       	call   801003d0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102118:	c7 04 24 bd 73 10 80 	movl   $0x801073bd,(%esp)
8010211f:	e8 ac e2 ff ff       	call   801003d0 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102124:	c7 04 24 a8 73 10 80 	movl   $0x801073a8,(%esp)
8010212b:	e8 a0 e2 ff ff       	call   801003d0 <panic>

80102130 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	57                   	push   %edi
80102134:	53                   	push   %ebx
80102135:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102138:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
8010213f:	e8 5c 24 00 00       	call   801045a0 <acquire>
  if((b = idequeue) == 0){
80102144:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
8010214a:	85 db                	test   %ebx,%ebx
8010214c:	74 2d                	je     8010217b <ideintr+0x4b>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
8010214e:	8b 43 58             	mov    0x58(%ebx),%eax
80102151:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102156:	8b 0b                	mov    (%ebx),%ecx
80102158:	f6 c1 04             	test   $0x4,%cl
8010215b:	74 33                	je     80102190 <ideintr+0x60>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
8010215d:	83 c9 02             	or     $0x2,%ecx
80102160:	83 e1 fb             	and    $0xfffffffb,%ecx
80102163:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102165:	89 1c 24             	mov    %ebx,(%esp)
80102168:	e8 43 17 00 00       	call   801038b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
8010216d:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
80102172:	85 c0                	test   %eax,%eax
80102174:	74 05                	je     8010217b <ideintr+0x4b>
    idestart(idequeue);
80102176:	e8 25 fe ff ff       	call   80101fa0 <idestart>

  release(&idelock);
8010217b:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102182:	e8 c9 23 00 00       	call   80104550 <release>
}
80102187:	83 c4 10             	add    $0x10,%esp
8010218a:	5b                   	pop    %ebx
8010218b:	5f                   	pop    %edi
8010218c:	5d                   	pop    %ebp
8010218d:	c3                   	ret    
8010218e:	66 90                	xchg   %ax,%ax
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102190:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102195:	8d 76 00             	lea    0x0(%esi),%esi
80102198:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102199:	0f b6 c0             	movzbl %al,%eax
8010219c:	89 c7                	mov    %eax,%edi
8010219e:	81 e7 c0 00 00 00    	and    $0xc0,%edi
801021a4:	83 ff 40             	cmp    $0x40,%edi
801021a7:	75 ef                	jne    80102198 <ideintr+0x68>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021a9:	a8 21                	test   $0x21,%al
801021ab:	75 b0                	jne    8010215d <ideintr+0x2d>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801021ad:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801021b0:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b5:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021ba:	fc                   	cld    
801021bb:	f3 6d                	rep insl (%dx),%es:(%edi)
801021bd:	8b 0b                	mov    (%ebx),%ecx
801021bf:	eb 9c                	jmp    8010215d <ideintr+0x2d>
801021c1:	eb 0d                	jmp    801021d0 <ideinit>
801021c3:	90                   	nop
801021c4:	90                   	nop
801021c5:	90                   	nop
801021c6:	90                   	nop
801021c7:	90                   	nop
801021c8:	90                   	nop
801021c9:	90                   	nop
801021ca:	90                   	nop
801021cb:	90                   	nop
801021cc:	90                   	nop
801021cd:	90                   	nop
801021ce:	90                   	nop
801021cf:	90                   	nop

801021d0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801021d0:	55                   	push   %ebp
801021d1:	89 e5                	mov    %esp,%ebp
801021d3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801021d6:	c7 44 24 04 db 73 10 	movl   $0x801073db,0x4(%esp)
801021dd:	80 
801021de:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801021e5:	e8 26 22 00 00       	call   80104410 <initlock>
  picenable(IRQ_IDE);
801021ea:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801021f1:	e8 da 10 00 00       	call   801032d0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021f6:	a1 80 2d 11 80       	mov    0x80112d80,%eax
801021fb:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102202:	83 e8 01             	sub    $0x1,%eax
80102205:	89 44 24 04          	mov    %eax,0x4(%esp)
80102209:	e8 52 00 00 00       	call   80102260 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010220e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102213:	90                   	nop
80102214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102218:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102219:	25 c0 00 00 00       	and    $0xc0,%eax
8010221e:	83 f8 40             	cmp    $0x40,%eax
80102221:	75 f5                	jne    80102218 <ideinit+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102223:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102228:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010222d:	ee                   	out    %al,(%dx)
8010222e:	31 c9                	xor    %ecx,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102230:	b2 f7                	mov    $0xf7,%dl
80102232:	eb 0f                	jmp    80102243 <ideinit+0x73>
80102234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102238:	83 c1 01             	add    $0x1,%ecx
8010223b:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
80102241:	74 0f                	je     80102252 <ideinit+0x82>
80102243:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102244:	84 c0                	test   %al,%al
80102246:	74 f0                	je     80102238 <ideinit+0x68>
      havedisk1 = 1;
80102248:	c7 05 b8 a5 10 80 01 	movl   $0x1,0x8010a5b8
8010224f:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102252:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102257:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010225c:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010225d:	c9                   	leave  
8010225e:	c3                   	ret    
	...

80102260 <ioapicenable>:
}

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102260:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102266:	55                   	push   %ebp
80102267:	89 e5                	mov    %esp,%ebp
80102269:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010226c:	85 d2                	test   %edx,%edx
8010226e:	74 31                	je     801022a1 <ioapicenable+0x41>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102270:	8b 15 54 26 11 80    	mov    0x80112654,%edx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102276:	8d 48 20             	lea    0x20(%eax),%ecx
80102279:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227d:	89 02                	mov    %eax,(%edx)
  ioapic->data = data;
8010227f:	8b 15 54 26 11 80    	mov    0x80112654,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102285:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102288:	89 4a 10             	mov    %ecx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010228b:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102291:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102294:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102296:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010229b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010229e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022a1:	5d                   	pop    %ebp
801022a2:	c3                   	ret    
801022a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	56                   	push   %esi
801022b4:	53                   	push   %ebx
801022b5:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
801022b8:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
801022be:	85 c9                	test   %ecx,%ecx
801022c0:	0f 84 9e 00 00 00    	je     80102364 <ioapicinit+0xb4>
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022c6:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801022cd:	00 00 00 
  return ioapic->data;
801022d0:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022d6:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022db:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
801022e2:	00 00 00 
  return ioapic->data;
801022e5:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022ea:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801022f8:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022fb:	c1 ee 10             	shr    $0x10,%esi
  id = ioapicread(REG_ID) >> 24;
801022fe:	c1 e8 18             	shr    $0x18,%eax

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102301:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102307:	39 c2                	cmp    %eax,%edx
80102309:	74 12                	je     8010231d <ioapicinit+0x6d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010230b:	c7 04 24 e0 73 10 80 	movl   $0x801073e0,(%esp)
80102312:	e8 59 e5 ff ff       	call   80100870 <cprintf>
80102317:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010231d:	ba 10 00 00 00       	mov    $0x10,%edx
80102322:	31 c0                	xor    %eax,%eax
80102324:	eb 08                	jmp    8010232e <ioapicinit+0x7e>
80102326:	66 90                	xchg   %ax,%ax

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102328:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010232e:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
80102330:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102336:	8d 48 20             	lea    0x20(%eax),%ecx
80102339:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010233f:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102342:	89 4b 10             	mov    %ecx,0x10(%ebx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102345:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010234b:	8d 5a 01             	lea    0x1(%edx),%ebx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010234e:	83 c2 02             	add    $0x2,%edx
80102351:	39 c6                	cmp    %eax,%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102353:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102355:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010235b:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102362:	7d c4                	jge    80102328 <ioapicinit+0x78>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102364:	83 c4 10             	add    $0x10,%esp
80102367:	5b                   	pop    %ebx
80102368:	5e                   	pop    %esi
80102369:	5d                   	pop    %ebp
8010236a:	c3                   	ret    
8010236b:	00 00                	add    %al,(%eax)
8010236d:	00 00                	add    %al,(%eax)
	...

80102370 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	53                   	push   %ebx
80102374:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102377:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010237d:	85 d2                	test   %edx,%edx
8010237f:	75 2f                	jne    801023b0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102381:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102387:	85 db                	test   %ebx,%ebx
80102389:	74 07                	je     80102392 <kalloc+0x22>
    kmem.freelist = r->next;
8010238b:	8b 03                	mov    (%ebx),%eax
8010238d:	a3 98 26 11 80       	mov    %eax,0x80112698
  if(kmem.use_lock)
80102392:	a1 94 26 11 80       	mov    0x80112694,%eax
80102397:	85 c0                	test   %eax,%eax
80102399:	74 0c                	je     801023a7 <kalloc+0x37>
    release(&kmem.lock);
8010239b:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801023a2:	e8 a9 21 00 00       	call   80104550 <release>
  return (char*)r;
}
801023a7:	89 d8                	mov    %ebx,%eax
801023a9:	83 c4 14             	add    $0x14,%esp
801023ac:	5b                   	pop    %ebx
801023ad:	5d                   	pop    %ebp
801023ae:	c3                   	ret    
801023af:	90                   	nop
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023b0:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801023b7:	e8 e4 21 00 00       	call   801045a0 <acquire>
801023bc:	eb c3                	jmp    80102381 <kalloc+0x11>
801023be:	66 90                	xchg   %ax,%ax

801023c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	53                   	push   %ebx
801023c4:	83 ec 14             	sub    $0x14,%esp
801023c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023d0:	75 7c                	jne    8010244e <kfree+0x8e>
801023d2:	81 fb 28 57 11 80    	cmp    $0x80115728,%ebx
801023d8:	72 74                	jb     8010244e <kfree+0x8e>
801023da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023e5:	77 67                	ja     8010244e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023e7:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801023ee:	00 
801023ef:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801023f6:	00 
801023f7:	89 1c 24             	mov    %ebx,(%esp)
801023fa:	e8 41 22 00 00       	call   80104640 <memset>

  if(kmem.use_lock)
801023ff:	a1 94 26 11 80       	mov    0x80112694,%eax
80102404:	85 c0                	test   %eax,%eax
80102406:	75 38                	jne    80102440 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102408:	a1 98 26 11 80       	mov    0x80112698,%eax
8010240d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010240f:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102415:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
8010241b:	85 c9                	test   %ecx,%ecx
8010241d:	75 09                	jne    80102428 <kfree+0x68>
    release(&kmem.lock);
}
8010241f:	83 c4 14             	add    $0x14,%esp
80102422:	5b                   	pop    %ebx
80102423:	5d                   	pop    %ebp
80102424:	c3                   	ret    
80102425:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102428:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
8010242f:	83 c4 14             	add    $0x14,%esp
80102432:	5b                   	pop    %ebx
80102433:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102434:	e9 17 21 00 00       	jmp    80104550 <release>
80102439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102440:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102447:	e8 54 21 00 00       	call   801045a0 <acquire>
8010244c:	eb ba                	jmp    80102408 <kfree+0x48>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010244e:	c7 04 24 12 74 10 80 	movl   $0x80107412,(%esp)
80102455:	e8 76 df ff ff       	call   801003d0 <panic>
8010245a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102460 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
80102465:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102468:	8b 55 08             	mov    0x8(%ebp),%edx
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010246b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010246e:	81 c2 ff 0f 00 00    	add    $0xfff,%edx
80102474:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010247a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102480:	39 f3                	cmp    %esi,%ebx
80102482:	76 08                	jbe    8010248c <freerange+0x2c>
80102484:	eb 18                	jmp    8010249e <freerange+0x3e>
80102486:	66 90                	xchg   %ax,%ax
80102488:	89 da                	mov    %ebx,%edx
8010248a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010248c:	89 14 24             	mov    %edx,(%esp)
8010248f:	e8 2c ff ff ff       	call   801023c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102494:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010249a:	39 f0                	cmp    %esi,%eax
8010249c:	76 ea                	jbe    80102488 <freerange+0x28>
    kfree(p);
}
8010249e:	83 c4 10             	add    $0x10,%esp
801024a1:	5b                   	pop    %ebx
801024a2:	5e                   	pop    %esi
801024a3:	5d                   	pop    %ebp
801024a4:	c3                   	ret    
801024a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024b0 <kinit2>:
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
801024b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801024b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801024bd:	8b 45 08             	mov    0x8(%ebp),%eax
801024c0:	89 04 24             	mov    %eax,(%esp)
801024c3:	e8 98 ff ff ff       	call   80102460 <freerange>
  kmem.use_lock = 1;
801024c8:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024cf:	00 00 00 
}
801024d2:	c9                   	leave  
801024d3:	c3                   	ret    
801024d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801024e0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	83 ec 18             	sub    $0x18,%esp
801024e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801024e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801024ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
801024ef:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024f2:	c7 44 24 04 18 74 10 	movl   $0x80107418,0x4(%esp)
801024f9:	80 
801024fa:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102501:	e8 0a 1f 00 00       	call   80104410 <initlock>
  kmem.use_lock = 0;
  freerange(vstart, vend);
80102506:	89 75 0c             	mov    %esi,0xc(%ebp)
}
80102509:	8b 75 fc             	mov    -0x4(%ebp),%esi
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010250c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010250f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102512:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102519:	00 00 00 
  freerange(vstart, vend);
}
8010251c:	89 ec                	mov    %ebp,%esp
8010251e:	5d                   	pop    %ebp
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010251f:	e9 3c ff ff ff       	jmp    80102460 <freerange>
	...

80102530 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102530:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102531:	ba 64 00 00 00       	mov    $0x64,%edx
80102536:	89 e5                	mov    %esp,%ebp
80102538:	ec                   	in     (%dx),%al
80102539:	89 c2                	mov    %eax,%edx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
8010253b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102540:	83 e2 01             	and    $0x1,%edx
80102543:	74 41                	je     80102586 <kbdgetc+0x56>
80102545:	ba 60 00 00 00       	mov    $0x60,%edx
8010254a:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010254b:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
8010254e:	3d e0 00 00 00       	cmp    $0xe0,%eax
80102553:	0f 84 7f 00 00 00    	je     801025d8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102559:	84 c0                	test   %al,%al
8010255b:	79 2b                	jns    80102588 <kbdgetc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010255d:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80102563:	89 c1                	mov    %eax,%ecx
80102565:	83 e1 7f             	and    $0x7f,%ecx
80102568:	f6 c2 40             	test   $0x40,%dl
8010256b:	0f 44 c1             	cmove  %ecx,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010256e:	0f b6 80 20 74 10 80 	movzbl -0x7fef8be0(%eax),%eax
80102575:	83 c8 40             	or     $0x40,%eax
80102578:	0f b6 c0             	movzbl %al,%eax
8010257b:	f7 d0                	not    %eax
8010257d:	21 d0                	and    %edx,%eax
8010257f:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
80102584:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102586:	5d                   	pop    %ebp
80102587:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102588:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
8010258e:	f6 c1 40             	test   $0x40,%cl
80102591:	74 05                	je     80102598 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102593:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
80102595:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102598:	0f b6 90 20 74 10 80 	movzbl -0x7fef8be0(%eax),%edx
8010259f:	09 ca                	or     %ecx,%edx
801025a1:	0f b6 88 20 75 10 80 	movzbl -0x7fef8ae0(%eax),%ecx
801025a8:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801025aa:	89 d1                	mov    %edx,%ecx
801025ac:	83 e1 03             	and    $0x3,%ecx
801025af:	8b 0c 8d 20 76 10 80 	mov    -0x7fef89e0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025b6:	89 15 bc a5 10 80    	mov    %edx,0x8010a5bc
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
801025bc:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025bf:	0f b6 04 01          	movzbl (%ecx,%eax,1),%eax
  if(shift & CAPSLOCK){
801025c3:	74 c1                	je     80102586 <kbdgetc+0x56>
    if('a' <= c && c <= 'z')
801025c5:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c8:	83 fa 19             	cmp    $0x19,%edx
801025cb:	77 1b                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025cd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025d0:	5d                   	pop    %ebp
801025d1:	c3                   	ret    
801025d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025d8:	30 c0                	xor    %al,%al
801025da:	83 0d bc a5 10 80 40 	orl    $0x40,0x8010a5bc
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025e1:	5d                   	pop    %ebp
801025e2:	c3                   	ret    
801025e3:	90                   	nop
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
801025ee:	83 f9 19             	cmp    $0x19,%ecx
801025f1:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025f4:	5d                   	pop    %ebp
801025f5:	c3                   	ret    
801025f6:	8d 76 00             	lea    0x0(%esi),%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102600 <kbdintr>:

void
kbdintr(void)
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102606:	c7 04 24 30 25 10 80 	movl   $0x80102530,(%esp)
8010260d:	e8 2e e0 ff ff       	call   80100640 <consoleintr>
}
80102612:	c9                   	leave  
80102613:	c3                   	ret    
	...

80102620 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102620:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102625:	55                   	push   %ebp
80102626:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102628:	85 c0                	test   %eax,%eax
8010262a:	0f 84 09 01 00 00    	je     80102739 <lapicinit+0x119>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102630:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102637:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010263a:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010263f:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102642:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102649:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010264c:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102651:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102654:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010265b:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
8010265e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102663:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102666:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010266d:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102670:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102675:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102678:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010267f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102682:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102687:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268a:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102691:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102699:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269c:	8b 50 30             	mov    0x30(%eax),%edx
8010269f:	c1 ea 10             	shr    $0x10,%edx
801026a2:	80 fa 03             	cmp    $0x3,%dl
801026a5:	0f 87 95 00 00 00    	ja     80102740 <lapicinit+0x120>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ab:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b5:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026ba:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026bd:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c7:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026cc:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026cf:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026d6:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d9:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026de:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e1:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026eb:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f3:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fd:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102702:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102705:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010270c:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
8010270f:	8b 0d 9c 26 11 80    	mov    0x8011269c,%ecx
80102715:	8b 41 20             	mov    0x20(%ecx),%eax
80102718:	8d 91 00 03 00 00    	lea    0x300(%ecx),%edx
8010271e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102720:	8b 02                	mov    (%edx),%eax
80102722:	f6 c4 10             	test   $0x10,%ah
80102725:	75 f9                	jne    80102720 <lapicinit+0x100>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102727:	c7 81 80 00 00 00 00 	movl   $0x0,0x80(%ecx)
8010272e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102731:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102736:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102739:	5d                   	pop    %ebp
8010273a:	c3                   	ret    
8010273b:	90                   	nop
8010273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102740:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102747:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274a:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010274f:	8b 50 20             	mov    0x20(%eax),%edx
80102752:	e9 54 ff ff ff       	jmp    801026ab <lapicinit+0x8b>
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102760:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 12                	je     8010277e <lapiceoi+0x1e>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102773:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102776:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010277b:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
8010277e:	5d                   	pop    %ebp
8010277f:	c3                   	ret    

80102780 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
}
80102783:	5d                   	pop    %ebp
80102784:	c3                   	ret    
80102785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102790:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102791:	ba 70 00 00 00       	mov    $0x70,%edx
80102796:	89 e5                	mov    %esp,%ebp
80102798:	b8 0f 00 00 00       	mov    $0xf,%eax
8010279d:	53                   	push   %ebx
8010279e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027a1:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
801027a5:	ee                   	out    %al,(%dx)
801027a6:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ab:	b2 71                	mov    $0x71,%dl
801027ad:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027ae:	89 c8                	mov    %ecx,%eax
801027b0:	c1 e8 04             	shr    $0x4,%eax
801027b3:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b9:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027be:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027c1:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801027c8:	00 00 

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
801027ca:	c1 e9 0c             	shr    $0xc,%ecx
801027cd:	80 cd 06             	or     $0x6,%ch
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d0:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d6:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027db:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027de:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027e5:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e8:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027ed:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f0:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027f7:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027ff:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102802:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102808:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010280d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102810:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102816:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010281e:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102824:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102829:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010282c:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102832:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102837:	5b                   	pop    %ebx
80102838:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
80102839:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010283c:	c3                   	ret    
8010283d:	8d 76 00             	lea    0x0(%esi),%esi

80102840 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	89 e5                	mov    %esp,%ebp
80102848:	b8 0b 00 00 00       	mov    $0xb,%eax
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 6c             	sub    $0x6c,%esp
80102853:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	b2 71                	mov    $0x71,%dl
80102856:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102857:	bb 70 00 00 00       	mov    $0x70,%ebx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285c:	88 45 a7             	mov    %al,-0x59(%ebp)
8010285f:	90                   	nop
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102860:	31 c0                	xor    %eax,%eax
80102862:	89 da                	mov    %ebx,%edx
80102864:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102865:	b9 71 00 00 00       	mov    $0x71,%ecx
8010286a:	89 ca                	mov    %ecx,%edx
8010286c:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010286d:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102870:	89 da                	mov    %ebx,%edx
80102872:	b8 02 00 00 00       	mov    $0x2,%eax
80102877:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102878:	89 ca                	mov    %ecx,%edx
8010287a:	ec                   	in     (%dx),%al
8010287b:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010287e:	89 da                	mov    %ebx,%edx
80102880:	89 45 a8             	mov    %eax,-0x58(%ebp)
80102883:	b8 04 00 00 00       	mov    $0x4,%eax
80102888:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102889:	89 ca                	mov    %ecx,%edx
8010288b:	ec                   	in     (%dx),%al
8010288c:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288f:	89 da                	mov    %ebx,%edx
80102891:	89 45 ac             	mov    %eax,-0x54(%ebp)
80102894:	b8 07 00 00 00       	mov    $0x7,%eax
80102899:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	89 ca                	mov    %ecx,%edx
8010289c:	ec                   	in     (%dx),%al
8010289d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a0:	89 da                	mov    %ebx,%edx
801028a2:	89 45 b0             	mov    %eax,-0x50(%ebp)
801028a5:	b8 08 00 00 00       	mov    $0x8,%eax
801028aa:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ab:	89 ca                	mov    %ecx,%edx
801028ad:	ec                   	in     (%dx),%al
801028ae:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b1:	89 da                	mov    %ebx,%edx
801028b3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801028b6:	b8 09 00 00 00       	mov    $0x9,%eax
801028bb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028bc:	89 ca                	mov    %ecx,%edx
801028be:	ec                   	in     (%dx),%al
801028bf:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c2:	89 da                	mov    %ebx,%edx
801028c4:	b8 0a 00 00 00       	mov    $0xa,%eax
801028c9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ca:	89 ca                	mov    %ecx,%edx
801028cc:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028cd:	84 c0                	test   %al,%al
801028cf:	78 8f                	js     80102860 <cmostime+0x20>
801028d1:	8b 45 a8             	mov    -0x58(%ebp),%eax
801028d4:	8b 55 ac             	mov    -0x54(%ebp),%edx
801028d7:	89 75 d0             	mov    %esi,-0x30(%ebp)
801028da:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801028dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028e0:	8b 45 b0             	mov    -0x50(%ebp),%eax
801028e3:	89 55 d8             	mov    %edx,-0x28(%ebp)
801028e6:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801028e9:	89 45 dc             	mov    %eax,-0x24(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ec:	31 c0                	xor    %eax,%eax
801028ee:	89 55 e0             	mov    %edx,-0x20(%ebp)
801028f1:	89 da                	mov    %ebx,%edx
801028f3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f4:	89 ca                	mov    %ecx,%edx
801028f6:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028f7:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fa:	89 da                	mov    %ebx,%edx
801028fc:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028ff:	b8 02 00 00 00       	mov    $0x2,%eax
80102904:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102905:	89 ca                	mov    %ecx,%edx
80102907:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102908:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290b:	89 da                	mov    %ebx,%edx
8010290d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102910:	b8 04 00 00 00       	mov    $0x4,%eax
80102915:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102916:	89 ca                	mov    %ecx,%edx
80102918:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102919:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010291c:	89 da                	mov    %ebx,%edx
8010291e:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102921:	b8 07 00 00 00       	mov    $0x7,%eax
80102926:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102927:	89 ca                	mov    %ecx,%edx
80102929:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
8010292a:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010292d:	89 da                	mov    %ebx,%edx
8010292f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102932:	b8 08 00 00 00       	mov    $0x8,%eax
80102937:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102938:	89 ca                	mov    %ecx,%edx
8010293a:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
8010293b:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010293e:	89 da                	mov    %ebx,%edx
80102940:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102943:	b8 09 00 00 00       	mov    $0x9,%eax
80102948:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102949:	89 ca                	mov    %ecx,%edx
8010294b:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
8010294c:	0f b6 c8             	movzbl %al,%ecx
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294f:	8d 55 d0             	lea    -0x30(%ebp),%edx
80102952:	8d 45 b8             	lea    -0x48(%ebp),%eax
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102955:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102958:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
8010295f:	00 
80102960:	89 44 24 04          	mov    %eax,0x4(%esp)
80102964:	89 14 24             	mov    %edx,(%esp)
80102967:	e8 44 1d 00 00       	call   801046b0 <memcmp>
8010296c:	85 c0                	test   %eax,%eax
8010296e:	0f 85 ec fe ff ff    	jne    80102860 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102974:	f6 45 a7 04          	testb  $0x4,-0x59(%ebp)
80102978:	75 78                	jne    801029f2 <cmostime+0x1b2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010297a:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010297d:	89 c2                	mov    %eax,%edx
8010297f:	83 e0 0f             	and    $0xf,%eax
80102982:	c1 ea 04             	shr    $0x4,%edx
80102985:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102988:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(minute);
8010298e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80102991:	89 c2                	mov    %eax,%edx
80102993:	83 e0 0f             	and    $0xf,%eax
80102996:	c1 ea 04             	shr    $0x4,%edx
80102999:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010299c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(hour  );
801029a2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801029a5:	89 c2                	mov    %eax,%edx
801029a7:	83 e0 0f             	and    $0xf,%eax
801029aa:	c1 ea 04             	shr    $0x4,%edx
801029ad:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b0:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(day   );
801029b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801029b9:	89 c2                	mov    %eax,%edx
801029bb:	83 e0 0f             	and    $0xf,%eax
801029be:	c1 ea 04             	shr    $0x4,%edx
801029c1:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c4:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(month );
801029ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
801029cd:	89 c2                	mov    %eax,%edx
801029cf:	83 e0 0f             	and    $0xf,%eax
801029d2:	c1 ea 04             	shr    $0x4,%edx
801029d5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029d8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(year  );
801029de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801029e1:	89 c2                	mov    %eax,%edx
801029e3:	83 e0 0f             	and    $0xf,%eax
801029e6:	c1 ea 04             	shr    $0x4,%edx
801029e9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ec:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
#undef     CONV
  }

  *r = t1;
801029f2:	8b 45 d0             	mov    -0x30(%ebp),%eax
801029f5:	8b 55 08             	mov    0x8(%ebp),%edx
801029f8:	89 02                	mov    %eax,(%edx)
801029fa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801029fd:	89 42 04             	mov    %eax,0x4(%edx)
80102a00:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102a03:	89 42 08             	mov    %eax,0x8(%edx)
80102a06:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102a09:	89 42 0c             	mov    %eax,0xc(%edx)
80102a0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102a0f:	89 42 10             	mov    %eax,0x10(%edx)
80102a12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102a15:	89 42 14             	mov    %eax,0x14(%edx)
  r->year += 2000;
80102a18:	81 42 14 d0 07 00 00 	addl   $0x7d0,0x14(%edx)
}
80102a1f:	83 c4 6c             	add    $0x6c,%esp
80102a22:	5b                   	pop    %ebx
80102a23:	5e                   	pop    %esi
80102a24:	5f                   	pop    %edi
80102a25:	5d                   	pop    %ebp
80102a26:	c3                   	ret    
80102a27:	89 f6                	mov    %esi,%esi
80102a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a30 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102a30:	55                   	push   %ebp
80102a31:	89 e5                	mov    %esp,%ebp
80102a33:	56                   	push   %esi
80102a34:	53                   	push   %ebx
80102a35:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102a38:	9c                   	pushf  
80102a39:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102a3a:	f6 c4 02             	test   $0x2,%ah
80102a3d:	74 12                	je     80102a51 <cpunum+0x21>
    static int n;
    if(n++ == 0)
80102a3f:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80102a44:	8d 50 01             	lea    0x1(%eax),%edx
80102a47:	85 c0                	test   %eax,%eax
80102a49:	89 15 c0 a5 10 80    	mov    %edx,0x8010a5c0
80102a4f:	74 4a                	je     80102a9b <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
80102a51:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102a56:	85 c0                	test   %eax,%eax
80102a58:	74 5d                	je     80102ab7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102a5a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102a60:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
80102a63:	85 f6                	test   %esi,%esi
80102a65:	7e 59                	jle    80102ac0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102a67:	0f b6 0d a0 27 11 80 	movzbl 0x801127a0,%ecx
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102a6e:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
80102a71:	31 c0                	xor    %eax,%eax
80102a73:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
80102a78:	39 d9                	cmp    %ebx,%ecx
80102a7a:	74 3b                	je     80102ab7 <cpunum+0x87>
80102a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102a80:	83 c0 01             	add    $0x1,%eax
80102a83:	39 f0                	cmp    %esi,%eax
80102a85:	7d 39                	jge    80102ac0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102a87:	0f b6 0a             	movzbl (%edx),%ecx
80102a8a:	81 c2 bc 00 00 00    	add    $0xbc,%edx
80102a90:	39 d9                	cmp    %ebx,%ecx
80102a92:	75 ec                	jne    80102a80 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
80102a94:	83 c4 10             	add    $0x10,%esp
80102a97:	5b                   	pop    %ebx
80102a98:	5e                   	pop    %esi
80102a99:	5d                   	pop    %ebp
80102a9a:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102a9b:	8b 45 04             	mov    0x4(%ebp),%eax
80102a9e:	c7 04 24 30 76 10 80 	movl   $0x80107630,(%esp)
80102aa5:	89 44 24 04          	mov    %eax,0x4(%esp)
80102aa9:	e8 c2 dd ff ff       	call   80100870 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
80102aae:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102ab3:	85 c0                	test   %eax,%eax
80102ab5:	75 a3                	jne    80102a5a <cpunum+0x2a>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
80102ab7:	83 c4 10             	add    $0x10,%esp
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102aba:	31 c0                	xor    %eax,%eax
}
80102abc:	5b                   	pop    %ebx
80102abd:	5e                   	pop    %esi
80102abe:	5d                   	pop    %ebp
80102abf:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102ac0:	c7 04 24 5c 76 10 80 	movl   $0x8010765c,(%esp)
80102ac7:	e8 04 d9 ff ff       	call   801003d0 <panic>
80102acc:	00 00                	add    %al,(%eax)
	...

80102ad0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ad7:	a1 e8 26 11 80       	mov    0x801126e8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102adc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102adf:	83 f8 1d             	cmp    $0x1d,%eax
80102ae2:	7f 7e                	jg     80102b62 <log_write+0x92>
80102ae4:	8b 15 d8 26 11 80    	mov    0x801126d8,%edx
80102aea:	83 ea 01             	sub    $0x1,%edx
80102aed:	39 d0                	cmp    %edx,%eax
80102aef:	7d 71                	jge    80102b62 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102af1:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102af6:	85 c0                	test   %eax,%eax
80102af8:	7e 74                	jle    80102b6e <log_write+0x9e>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102afa:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102b01:	e8 9a 1a 00 00       	call   801045a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102b06:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102b0c:	85 c9                	test   %ecx,%ecx
80102b0e:	7e 4b                	jle    80102b5b <log_write+0x8b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b10:	8b 53 08             	mov    0x8(%ebx),%edx
80102b13:	31 c0                	xor    %eax,%eax
80102b15:	39 15 ec 26 11 80    	cmp    %edx,0x801126ec
80102b1b:	75 0c                	jne    80102b29 <log_write+0x59>
80102b1d:	eb 11                	jmp    80102b30 <log_write+0x60>
80102b1f:	90                   	nop
80102b20:	3b 14 85 ec 26 11 80 	cmp    -0x7feed914(,%eax,4),%edx
80102b27:	74 07                	je     80102b30 <log_write+0x60>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b29:	83 c0 01             	add    $0x1,%eax
80102b2c:	39 c8                	cmp    %ecx,%eax
80102b2e:	7c f0                	jl     80102b20 <log_write+0x50>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102b30:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80102b37:	39 05 e8 26 11 80    	cmp    %eax,0x801126e8
80102b3d:	75 08                	jne    80102b47 <log_write+0x77>
    log.lh.n++;
80102b3f:	83 c0 01             	add    $0x1,%eax
80102b42:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102b47:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102b4a:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102b51:	83 c4 14             	add    $0x14,%esp
80102b54:	5b                   	pop    %ebx
80102b55:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102b56:	e9 f5 19 00 00       	jmp    80104550 <release>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b5b:	8b 53 08             	mov    0x8(%ebx),%edx
80102b5e:	31 c0                	xor    %eax,%eax
80102b60:	eb ce                	jmp    80102b30 <log_write+0x60>
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102b62:	c7 04 24 6c 76 10 80 	movl   $0x8010766c,(%esp)
80102b69:	e8 62 d8 ff ff       	call   801003d0 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102b6e:	c7 04 24 82 76 10 80 	movl   $0x80107682,(%esp)
80102b75:	e8 56 d8 ff ff       	call   801003d0 <panic>
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b80 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	57                   	push   %edi
80102b84:	56                   	push   %esi
80102b85:	53                   	push   %ebx
80102b86:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b89:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102b8f:	85 d2                	test   %edx,%edx
80102b91:	7e 78                	jle    80102c0b <install_trans+0x8b>
80102b93:	31 db                	xor    %ebx,%ebx
80102b95:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b98:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b9d:	8d 44 03 01          	lea    0x1(%ebx,%eax,1),%eax
80102ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ba5:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102baa:	89 04 24             	mov    %eax,(%esp)
80102bad:	e8 5e d5 ff ff       	call   80100110 <bread>
80102bb2:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bb4:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bbb:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbe:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bc2:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102bc7:	89 04 24             	mov    %eax,(%esp)
80102bca:	e8 41 d5 ff ff       	call   80100110 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bcf:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102bd6:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bd7:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bd9:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80102be0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102be3:	89 04 24             	mov    %eax,(%esp)
80102be6:	e8 25 1b 00 00       	call   80104710 <memmove>
    bwrite(dbuf);  // write dst to disk
80102beb:	89 34 24             	mov    %esi,(%esp)
80102bee:	e8 dd d4 ff ff       	call   801000d0 <bwrite>
    brelse(lbuf);
80102bf3:	89 3c 24             	mov    %edi,(%esp)
80102bf6:	e8 45 d4 ff ff       	call   80100040 <brelse>
    brelse(dbuf);
80102bfb:	89 34 24             	mov    %esi,(%esp)
80102bfe:	e8 3d d4 ff ff       	call   80100040 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c03:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102c09:	7f 8d                	jg     80102b98 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102c0b:	83 c4 1c             	add    $0x1c,%esp
80102c0e:	5b                   	pop    %ebx
80102c0f:	5e                   	pop    %esi
80102c10:	5f                   	pop    %edi
80102c11:	5d                   	pop    %ebp
80102c12:	c3                   	ret    
80102c13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	56                   	push   %esi
80102c24:	53                   	push   %ebx
80102c25:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c28:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c31:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102c36:	89 04 24             	mov    %eax,(%esp)
80102c39:	e8 d2 d4 ff ff       	call   80100110 <bread>
80102c3e:	89 c6                	mov    %eax,%esi
  struct logheader *hb = (struct logheader *) (buf->data);
80102c40:	8d 58 5c             	lea    0x5c(%eax),%ebx
  int i;
  hb->n = log.lh.n;
80102c43:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c48:	89 46 5c             	mov    %eax,0x5c(%esi)
  for (i = 0; i < log.lh.n; i++) {
80102c4b:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c51:	85 c9                	test   %ecx,%ecx
80102c53:	7e 19                	jle    80102c6e <write_head+0x4e>
80102c55:	31 d2                	xor    %edx,%edx
80102c57:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c58:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c5f:	89 4c 93 04          	mov    %ecx,0x4(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c63:	83 c2 01             	add    $0x1,%edx
80102c66:	39 15 e8 26 11 80    	cmp    %edx,0x801126e8
80102c6c:	7f ea                	jg     80102c58 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c6e:	89 34 24             	mov    %esi,(%esp)
80102c71:	e8 5a d4 ff ff       	call   801000d0 <bwrite>
  brelse(buf);
80102c76:	89 34 24             	mov    %esi,(%esp)
80102c79:	e8 c2 d3 ff ff       	call   80100040 <brelse>
}
80102c7e:	83 c4 10             	add    $0x10,%esp
80102c81:	5b                   	pop    %ebx
80102c82:	5e                   	pop    %esi
80102c83:	5d                   	pop    %ebp
80102c84:	c3                   	ret    
80102c85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c90 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	57                   	push   %edi
80102c94:	56                   	push   %esi
80102c95:	53                   	push   %ebx
80102c96:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c99:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ca0:	e8 fb 18 00 00       	call   801045a0 <acquire>
  log.outstanding -= 1;
80102ca5:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102caa:	8b 3d e0 26 11 80    	mov    0x801126e0,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cb0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102cb3:	85 ff                	test   %edi,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cb5:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102cba:	0f 85 f2 00 00 00    	jne    80102db2 <end_op+0x122>
    panic("log.committing");
  if(log.outstanding == 0){
80102cc0:	85 c0                	test   %eax,%eax
80102cc2:	0f 85 ca 00 00 00    	jne    80102d92 <end_op+0x102>
    do_commit = 1;
    log.committing = 1;
80102cc8:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102ccf:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cd2:	31 db                	xor    %ebx,%ebx
80102cd4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102cdb:	e8 70 18 00 00       	call   80104550 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ce0:	8b 35 e8 26 11 80    	mov    0x801126e8,%esi
80102ce6:	85 f6                	test   %esi,%esi
80102ce8:	0f 8e 8e 00 00 00    	jle    80102d7c <end_op+0xec>
80102cee:	66 90                	xchg   %ax,%ax
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102cf0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102cf5:	8d 44 03 01          	lea    0x1(%ebx,%eax,1),%eax
80102cf9:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cfd:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d02:	89 04 24             	mov    %eax,(%esp)
80102d05:	e8 06 d4 ff ff       	call   80100110 <bread>
80102d0a:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d0c:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d13:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d16:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d1a:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d1f:	89 04 24             	mov    %eax,(%esp)
80102d22:	e8 e9 d3 ff ff       	call   80100110 <bread>
    memmove(to->data, from->data, BSIZE);
80102d27:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102d2e:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d2f:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d31:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d34:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d38:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d3b:	89 04 24             	mov    %eax,(%esp)
80102d3e:	e8 cd 19 00 00       	call   80104710 <memmove>
    bwrite(to);  // write the log
80102d43:	89 34 24             	mov    %esi,(%esp)
80102d46:	e8 85 d3 ff ff       	call   801000d0 <bwrite>
    brelse(from);
80102d4b:	89 3c 24             	mov    %edi,(%esp)
80102d4e:	e8 ed d2 ff ff       	call   80100040 <brelse>
    brelse(to);
80102d53:	89 34 24             	mov    %esi,(%esp)
80102d56:	e8 e5 d2 ff ff       	call   80100040 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d5b:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d61:	7c 8d                	jl     80102cf0 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d63:	e8 b8 fe ff ff       	call   80102c20 <write_head>
    install_trans(); // Now install writes to home locations
80102d68:	e8 13 fe ff ff       	call   80102b80 <install_trans>
    log.lh.n = 0;
80102d6d:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d74:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d77:	e8 a4 fe ff ff       	call   80102c20 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d7c:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d83:	e8 18 18 00 00       	call   801045a0 <acquire>
    log.committing = 0;
80102d88:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d8f:	00 00 00 
    wakeup(&log);
80102d92:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d99:	e8 12 0b 00 00       	call   801038b0 <wakeup>
    release(&log.lock);
80102d9e:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102da5:	e8 a6 17 00 00       	call   80104550 <release>
  }
}
80102daa:	83 c4 1c             	add    $0x1c,%esp
80102dad:	5b                   	pop    %ebx
80102dae:	5e                   	pop    %esi
80102daf:	5f                   	pop    %edi
80102db0:	5d                   	pop    %ebp
80102db1:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102db2:	c7 04 24 9d 76 10 80 	movl   $0x8010769d,(%esp)
80102db9:	e8 12 d6 ff ff       	call   801003d0 <panic>
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102dc6:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dcd:	e8 ce 17 00 00       	call   801045a0 <acquire>
80102dd2:	eb 18                	jmp    80102dec <begin_op+0x2c>
80102dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80102dd8:	c7 44 24 04 a0 26 11 	movl   $0x801126a0,0x4(%esp)
80102ddf:	80 
80102de0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102de7:	e8 24 0c 00 00       	call   80103a10 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102dec:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102df1:	85 c0                	test   %eax,%eax
80102df3:	75 e3                	jne    80102dd8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102df5:	8b 15 dc 26 11 80    	mov    0x801126dc,%edx
80102dfb:	83 c2 01             	add    $0x1,%edx
80102dfe:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102e01:	01 c0                	add    %eax,%eax
80102e03:	03 05 e8 26 11 80    	add    0x801126e8,%eax
80102e09:	83 f8 1e             	cmp    $0x1e,%eax
80102e0c:	7f ca                	jg     80102dd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e0e:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102e15:	89 15 dc 26 11 80    	mov    %edx,0x801126dc
      release(&log.lock);
80102e1b:	e8 30 17 00 00       	call   80104550 <release>
      break;
    }
  }
}
80102e20:	c9                   	leave  
80102e21:	c3                   	ret    
80102e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e30 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	56                   	push   %esi
80102e34:	53                   	push   %ebx
80102e35:	83 ec 30             	sub    $0x30,%esp
80102e38:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102e3b:	c7 44 24 04 ac 76 10 	movl   $0x801076ac,0x4(%esp)
80102e42:	80 
80102e43:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e4a:	e8 c1 15 00 00       	call   80104410 <initlock>
  readsb(dev, &sb);
80102e4f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e52:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e56:	89 1c 24             	mov    %ebx,(%esp)
80102e59:	e8 f2 e4 ff ff       	call   80101350 <readsb>
  log.start = sb.logstart;
80102e5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102e61:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.dev = dev;
80102e64:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e6a:	89 1c 24             	mov    %ebx,(%esp)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102e6d:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102e72:	89 15 d8 26 11 80    	mov    %edx,0x801126d8

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e78:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e7c:	e8 8f d2 ff ff       	call   80100110 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e81:	8b 58 5c             	mov    0x5c(%eax),%ebx
// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
80102e84:	8d 70 5c             	lea    0x5c(%eax),%esi
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102e87:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e89:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102e8f:	7e 19                	jle    80102eaa <initlog+0x7a>
80102e91:	31 d2                	xor    %edx,%edx
80102e93:	90                   	nop
80102e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102e98:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102e9c:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102ea3:	83 c2 01             	add    $0x1,%edx
80102ea6:	39 da                	cmp    %ebx,%edx
80102ea8:	75 ee                	jne    80102e98 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102eaa:	89 04 24             	mov    %eax,(%esp)
80102ead:	e8 8e d1 ff ff       	call   80100040 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102eb2:	e8 c9 fc ff ff       	call   80102b80 <install_trans>
  log.lh.n = 0;
80102eb7:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102ebe:	00 00 00 
  write_head(); // clear the log
80102ec1:	e8 5a fd ff ff       	call   80102c20 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102ec6:	83 c4 30             	add    $0x30,%esp
80102ec9:	5b                   	pop    %ebx
80102eca:	5e                   	pop    %esi
80102ecb:	5d                   	pop    %ebp
80102ecc:	c3                   	ret    
80102ecd:	00 00                	add    %al,(%eax)
	...

80102ed0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102ed6:	e8 55 fb ff ff       	call   80102a30 <cpunum>
80102edb:	c7 04 24 b0 76 10 80 	movl   $0x801076b0,(%esp)
80102ee2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ee6:	e8 85 d9 ff ff       	call   80100870 <cprintf>
  idtinit();       // load idt register
80102eeb:	e8 a0 2a 00 00       	call   80105990 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102ef0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102ef7:	b8 01 00 00 00       	mov    $0x1,%eax
80102efc:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f03:	e8 18 0c 00 00       	call   80103b20 <scheduler>
80102f08:	90                   	nop
80102f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f10 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	83 e4 f0             	and    $0xfffffff0,%esp
80102f16:	53                   	push   %ebx
80102f17:	83 ec 1c             	sub    $0x1c,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f1a:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102f21:	80 
80102f22:	c7 04 24 28 57 11 80 	movl   $0x80115728,(%esp)
80102f29:	e8 b2 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f2e:	e8 cd 3b 00 00       	call   80106b00 <kvmalloc>
  mpinit();        // detect other processors
80102f33:	e8 c8 01 00 00       	call   80103100 <mpinit>
  lapicinit();     // interrupt controller
80102f38:	e8 e3 f6 ff ff       	call   80102620 <lapicinit>
80102f3d:	8d 76 00             	lea    0x0(%esi),%esi
  seginit();       // segment descriptors
80102f40:	e8 4b 41 00 00       	call   80107090 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f45:	e8 e6 fa ff ff       	call   80102a30 <cpunum>
80102f4a:	c7 04 24 c1 76 10 80 	movl   $0x801076c1,(%esp)
80102f51:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f55:	e8 16 d9 ff ff       	call   80100870 <cprintf>
  picinit();       // another interrupt controller
80102f5a:	e8 a1 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102f5f:	e8 4c f3 ff ff       	call   801022b0 <ioapicinit>
  consoleinit();   // console hardware
80102f64:	e8 07 d3 ff ff       	call   80100270 <consoleinit>
  uartinit();      // serial port
80102f69:	e8 f2 2d 00 00       	call   80105d60 <uartinit>
80102f6e:	66 90                	xchg   %ax,%ax
  pinit();         // process table
80102f70:	e8 6b 13 00 00       	call   801042e0 <pinit>
  tvinit();        // trap vectors
80102f75:	e8 b6 2c 00 00       	call   80105c30 <tvinit>
  binit();         // buffer cache
80102f7a:	e8 61 d2 ff ff       	call   801001e0 <binit>
80102f7f:	90                   	nop
  fileinit();      // file table
80102f80:	e8 cb e1 ff ff       	call   80101150 <fileinit>
  ideinit();       // disk
80102f85:	e8 46 f2 ff ff       	call   801021d0 <ideinit>
  if(!ismp)
80102f8a:	a1 84 27 11 80       	mov    0x80112784,%eax
80102f8f:	85 c0                	test   %eax,%eax
80102f91:	0f 84 ca 00 00 00    	je     80103061 <main+0x151>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f97:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102f9e:	00 
80102f9f:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102fa6:	80 
80102fa7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102fae:	e8 5d 17 00 00       	call   80104710 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fb3:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102fba:	00 00 00 
80102fbd:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fc2:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80102fc7:	76 7a                	jbe    80103043 <main+0x133>
80102fc9:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80102fce:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
80102fd0:	e8 5b fa ff ff       	call   80102a30 <cpunum>
80102fd5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102fdb:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fe0:	39 c3                	cmp    %eax,%ebx
80102fe2:	74 46                	je     8010302a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102fe4:	e8 87 f3 ff ff       	call   80102370 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
80102fe9:	c7 05 f8 6f 00 80 70 	movl   $0x80103070,0x80006ff8
80102ff0:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ff3:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102ffa:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ffd:	05 00 10 00 00       	add    $0x1000,%eax
80103002:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103007:	0f b6 03             	movzbl (%ebx),%eax
8010300a:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80103011:	00 
80103012:	89 04 24             	mov    %eax,(%esp)
80103015:	e8 76 f7 ff ff       	call   80102790 <lapicstartap>
8010301a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103020:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103026:	85 c0                	test   %eax,%eax
80103028:	74 f6                	je     80103020 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010302a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103031:	00 00 00 
80103034:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010303a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010303f:	39 c3                	cmp    %eax,%ebx
80103041:	72 8d                	jb     80102fd0 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103043:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
8010304a:	8e 
8010304b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103052:	e8 59 f4 ff ff       	call   801024b0 <kinit2>
  userinit();      // first user process
80103057:	e8 84 11 00 00       	call   801041e0 <userinit>
  mpmain();        // finish this processor's setup
8010305c:	e8 6f fe ff ff       	call   80102ed0 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80103061:	e8 ca 28 00 00       	call   80105930 <timerinit>
80103066:	e9 2c ff ff ff       	jmp    80102f97 <main+0x87>
8010306b:	90                   	nop
8010306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103070 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103076:	e8 15 38 00 00       	call   80106890 <switchkvm>
  seginit();
8010307b:	e8 10 40 00 00       	call   80107090 <seginit>
  lapicinit();
80103080:	e8 9b f5 ff ff       	call   80102620 <lapicinit>
  mpmain();
80103085:	e8 46 fe ff ff       	call   80102ed0 <mpmain>
8010308a:	00 00                	add    %al,(%eax)
8010308c:	00 00                	add    %al,(%eax)
	...

80103090 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	56                   	push   %esi
80103094:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80103095:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010309b:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010309e:	8d 34 13             	lea    (%ebx,%edx,1),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
801030a1:	39 f3                	cmp    %esi,%ebx
801030a3:	73 3c                	jae    801030e1 <mpsearch1+0x51>
801030a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030a8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801030af:	00 
801030b0:	c7 44 24 04 d8 76 10 	movl   $0x801076d8,0x4(%esp)
801030b7:	80 
801030b8:	89 1c 24             	mov    %ebx,(%esp)
801030bb:	e8 f0 15 00 00       	call   801046b0 <memcmp>
801030c0:	85 c0                	test   %eax,%eax
801030c2:	75 16                	jne    801030da <mpsearch1+0x4a>
801030c4:	31 d2                	xor    %edx,%edx
801030c6:	66 90                	xchg   %ax,%ax
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030c8:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030cc:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030cf:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030d1:	83 f8 10             	cmp    $0x10,%eax
801030d4:	75 f2                	jne    801030c8 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030d6:	84 d2                	test   %dl,%dl
801030d8:	74 10                	je     801030ea <mpsearch1+0x5a>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030da:	83 c3 10             	add    $0x10,%ebx
801030dd:	39 de                	cmp    %ebx,%esi
801030df:	77 c7                	ja     801030a8 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030e1:	83 c4 10             	add    $0x10,%esp
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030e4:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030e6:	5b                   	pop    %ebx
801030e7:	5e                   	pop    %esi
801030e8:	5d                   	pop    %ebp
801030e9:	c3                   	ret    
801030ea:	83 c4 10             	add    $0x10,%esp

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
801030ed:	89 d8                	mov    %ebx,%eax
  return 0;
}
801030ef:	5b                   	pop    %ebx
801030f0:	5e                   	pop    %esi
801030f1:	5d                   	pop    %ebp
801030f2:	c3                   	ret    
801030f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103100 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103100:	55                   	push   %ebp
80103101:	89 e5                	mov    %esp,%ebp
80103103:	57                   	push   %edi
80103104:	56                   	push   %esi
80103105:	53                   	push   %ebx
80103106:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103109:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103110:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103117:	c1 e0 08             	shl    $0x8,%eax
8010311a:	09 d0                	or     %edx,%eax
8010311c:	c1 e0 04             	shl    $0x4,%eax
8010311f:	85 c0                	test   %eax,%eax
80103121:	75 1b                	jne    8010313e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103123:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010312a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103131:	c1 e0 08             	shl    $0x8,%eax
80103134:	09 d0                	or     %edx,%eax
80103136:	c1 e0 0a             	shl    $0xa,%eax
80103139:	2d 00 04 00 00       	sub    $0x400,%eax
8010313e:	ba 00 04 00 00       	mov    $0x400,%edx
80103143:	e8 48 ff ff ff       	call   80103090 <mpsearch1>
80103148:	85 c0                	test   %eax,%eax
8010314a:	89 c6                	mov    %eax,%esi
8010314c:	0f 84 a6 00 00 00    	je     801031f8 <mpinit+0xf8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103152:	8b 7e 04             	mov    0x4(%esi),%edi
80103155:	85 ff                	test   %edi,%edi
80103157:	75 08                	jne    80103161 <mpinit+0x61>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103159:	83 c4 2c             	add    $0x2c,%esp
8010315c:	5b                   	pop    %ebx
8010315d:	5e                   	pop    %esi
8010315e:	5f                   	pop    %edi
8010315f:	5d                   	pop    %ebp
80103160:	c3                   	ret    
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103161:	8d 9f 00 00 00 80    	lea    -0x80000000(%edi),%ebx
  if(memcmp(conf, "PCMP", 4) != 0)
80103167:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010316e:	00 
8010316f:	c7 44 24 04 dd 76 10 	movl   $0x801076dd,0x4(%esp)
80103176:	80 
80103177:	89 1c 24             	mov    %ebx,(%esp)
8010317a:	e8 31 15 00 00       	call   801046b0 <memcmp>
8010317f:	85 c0                	test   %eax,%eax
80103181:	75 d6                	jne    80103159 <mpinit+0x59>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103183:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
80103187:	3c 04                	cmp    $0x4,%al
80103189:	74 04                	je     8010318f <mpinit+0x8f>
8010318b:	3c 01                	cmp    $0x1,%al
8010318d:	75 ca                	jne    80103159 <mpinit+0x59>
  *pmp = mp;
  return conf;
}

void
mpinit(void)
8010318f:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103193:	89 d8                	mov    %ebx,%eax
  *pmp = mp;
  return conf;
}

void
mpinit(void)
80103195:	8d 8c 17 00 00 00 80 	lea    -0x80000000(%edi,%edx,1),%ecx
8010319c:	31 d2                	xor    %edx,%edx
8010319e:	eb 08                	jmp    801031a8 <mpinit+0xa8>
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801031a0:	0f b6 38             	movzbl (%eax),%edi
801031a3:	83 c0 01             	add    $0x1,%eax
801031a6:	01 fa                	add    %edi,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031a8:	39 c8                	cmp    %ecx,%eax
801031aa:	75 f4                	jne    801031a0 <mpinit+0xa0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031ac:	84 d2                	test   %dl,%dl
801031ae:	75 a9                	jne    80103159 <mpinit+0x59>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
801031b0:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
801031b7:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801031ba:	8b 43 24             	mov    0x24(%ebx),%eax
801031bd:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031c2:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
801031c6:	8d 43 2c             	lea    0x2c(%ebx),%eax
801031c9:	01 d3                	add    %edx,%ebx
801031cb:	39 d8                	cmp    %ebx,%eax
801031cd:	72 17                	jb     801031e6 <mpinit+0xe6>
801031cf:	eb 5f                	jmp    80103230 <mpinit+0x130>
801031d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031d8:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801031df:	00 00 00 

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031e2:	39 c3                	cmp    %eax,%ebx
801031e4:	76 41                	jbe    80103227 <mpinit+0x127>
    switch(*p){
801031e6:	80 38 04             	cmpb   $0x4,(%eax)
801031e9:	77 ed                	ja     801031d8 <mpinit+0xd8>
801031eb:	0f b6 10             	movzbl (%eax),%edx
801031ee:	ff 24 95 e4 76 10 80 	jmp    *-0x7fef891c(,%edx,4)
801031f5:	8d 76 00             	lea    0x0(%esi),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031f8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031fd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103202:	e8 89 fe ff ff       	call   80103090 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103207:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103209:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010320b:	0f 85 41 ff ff ff    	jne    80103152 <mpinit+0x52>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103211:	83 c4 2c             	add    $0x2c,%esp
80103214:	5b                   	pop    %ebx
80103215:	5e                   	pop    %esi
80103216:	5f                   	pop    %edi
80103217:	5d                   	pop    %ebp
80103218:	c3                   	ret    
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103220:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103223:	39 c3                	cmp    %eax,%ebx
80103225:	77 bf                	ja     801031e6 <mpinit+0xe6>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
80103227:	a1 84 27 11 80       	mov    0x80112784,%eax
8010322c:	85 c0                	test   %eax,%eax
8010322e:	74 70                	je     801032a0 <mpinit+0x1a0>
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
80103230:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103234:	0f 84 1f ff ff ff    	je     80103159 <mpinit+0x59>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010323a:	ba 22 00 00 00       	mov    $0x22,%edx
8010323f:	b8 70 00 00 00       	mov    $0x70,%eax
80103244:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103245:	b2 23                	mov    $0x23,%dl
80103247:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103248:	83 c8 01             	or     $0x1,%eax
8010324b:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010324c:	83 c4 2c             	add    $0x2c,%esp
8010324f:	5b                   	pop    %ebx
80103250:	5e                   	pop    %esi
80103251:	5f                   	pop    %edi
80103252:	5d                   	pop    %ebp
80103253:	c3                   	ret    
80103254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103258:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
8010325e:	83 fa 07             	cmp    $0x7,%edx
80103261:	7f 1b                	jg     8010327e <mpinit+0x17e>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103263:	69 ca bc 00 00 00    	imul   $0xbc,%edx,%ecx
        ncpu++;
80103269:	83 c2 01             	add    $0x1,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010326c:	89 cf                	mov    %ecx,%edi
8010326e:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
        ncpu++;
80103272:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103278:	88 8f a0 27 11 80    	mov    %cl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010327e:	83 c0 14             	add    $0x14,%eax
      continue;
80103281:	e9 5c ff ff ff       	jmp    801031e2 <mpinit+0xe2>
80103286:	66 90                	xchg   %ax,%ax
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010328c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010328f:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
80103295:	e9 48 ff ff ff       	jmp    801031e2 <mpinit+0xe2>
8010329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    }
  }
  if(!ismp){
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
801032a0:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
801032a7:	00 00 00 
    lapic = 0;
801032aa:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
801032b1:	00 00 00 
    ioapicid = 0;
801032b4:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032bb:	83 c4 2c             	add    $0x2c,%esp
801032be:	5b                   	pop    %ebx
801032bf:	5e                   	pop    %esi
801032c0:	5f                   	pop    %edi
801032c1:	5d                   	pop    %ebp
801032c2:	c3                   	ret    
	...

801032d0 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801032d0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
801032d1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801032d6:	89 e5                	mov    %esp,%ebp
801032d8:	ba 21 00 00 00       	mov    $0x21,%edx
  picsetmask(irqmask & ~(1<<irq));
801032dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801032e0:	d3 c0                	rol    %cl,%eax
801032e2:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
801032e9:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801032ef:	ee                   	out    %al,(%dx)
801032f0:	66 c1 e8 08          	shr    $0x8,%ax
801032f4:	b2 a1                	mov    $0xa1,%dl
801032f6:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
801032f7:	5d                   	pop    %ebp
801032f8:	c3                   	ret    
801032f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103300 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103300:	55                   	push   %ebp
80103301:	b9 21 00 00 00       	mov    $0x21,%ecx
80103306:	89 e5                	mov    %esp,%ebp
80103308:	83 ec 0c             	sub    $0xc,%esp
8010330b:	89 1c 24             	mov    %ebx,(%esp)
8010330e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103313:	89 ca                	mov    %ecx,%edx
80103315:	89 74 24 04          	mov    %esi,0x4(%esp)
80103319:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010331d:	ee                   	out    %al,(%dx)
8010331e:	bb a1 00 00 00       	mov    $0xa1,%ebx
80103323:	89 da                	mov    %ebx,%edx
80103325:	ee                   	out    %al,(%dx)
80103326:	be 11 00 00 00       	mov    $0x11,%esi
8010332b:	b2 20                	mov    $0x20,%dl
8010332d:	89 f0                	mov    %esi,%eax
8010332f:	ee                   	out    %al,(%dx)
80103330:	b8 20 00 00 00       	mov    $0x20,%eax
80103335:	89 ca                	mov    %ecx,%edx
80103337:	ee                   	out    %al,(%dx)
80103338:	b8 04 00 00 00       	mov    $0x4,%eax
8010333d:	ee                   	out    %al,(%dx)
8010333e:	bf 03 00 00 00       	mov    $0x3,%edi
80103343:	89 f8                	mov    %edi,%eax
80103345:	ee                   	out    %al,(%dx)
80103346:	b1 a0                	mov    $0xa0,%cl
80103348:	89 f0                	mov    %esi,%eax
8010334a:	89 ca                	mov    %ecx,%edx
8010334c:	ee                   	out    %al,(%dx)
8010334d:	b8 28 00 00 00       	mov    $0x28,%eax
80103352:	89 da                	mov    %ebx,%edx
80103354:	ee                   	out    %al,(%dx)
80103355:	b8 02 00 00 00       	mov    $0x2,%eax
8010335a:	ee                   	out    %al,(%dx)
8010335b:	89 f8                	mov    %edi,%eax
8010335d:	ee                   	out    %al,(%dx)
8010335e:	be 68 00 00 00       	mov    $0x68,%esi
80103363:	b2 20                	mov    $0x20,%dl
80103365:	89 f0                	mov    %esi,%eax
80103367:	ee                   	out    %al,(%dx)
80103368:	bb 0a 00 00 00       	mov    $0xa,%ebx
8010336d:	89 d8                	mov    %ebx,%eax
8010336f:	ee                   	out    %al,(%dx)
80103370:	89 f0                	mov    %esi,%eax
80103372:	89 ca                	mov    %ecx,%edx
80103374:	ee                   	out    %al,(%dx)
80103375:	89 d8                	mov    %ebx,%eax
80103377:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103378:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
8010337f:	66 83 f8 ff          	cmp    $0xffffffff,%ax
80103383:	74 0a                	je     8010338f <picinit+0x8f>
80103385:	b2 21                	mov    $0x21,%dl
80103387:	ee                   	out    %al,(%dx)
80103388:	66 c1 e8 08          	shr    $0x8,%ax
8010338c:	b2 a1                	mov    $0xa1,%dl
8010338e:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
8010338f:	8b 1c 24             	mov    (%esp),%ebx
80103392:	8b 74 24 04          	mov    0x4(%esp),%esi
80103396:	8b 7c 24 08          	mov    0x8(%esp),%edi
8010339a:	89 ec                	mov    %ebp,%esp
8010339c:	5d                   	pop    %ebp
8010339d:	c3                   	ret    
	...

801033a0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	57                   	push   %edi
801033a4:	56                   	push   %esi
801033a5:	53                   	push   %ebx
801033a6:	83 ec 1c             	sub    $0x1c,%esp
801033a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033ac:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801033af:	89 1c 24             	mov    %ebx,(%esp)
801033b2:	e8 e9 11 00 00       	call   801045a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033b7:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801033bd:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
801033c3:	75 58                	jne    8010341d <piperead+0x7d>
801033c5:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801033cb:	85 f6                	test   %esi,%esi
801033cd:	74 4e                	je     8010341d <piperead+0x7d>
    if(proc->killed){
801033cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801033d5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
801033db:	8b 48 24             	mov    0x24(%eax),%ecx
801033de:	85 c9                	test   %ecx,%ecx
801033e0:	74 21                	je     80103403 <piperead+0x63>
801033e2:	e9 99 00 00 00       	jmp    80103480 <piperead+0xe0>
801033e7:	90                   	nop
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033e8:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033ee:	85 c0                	test   %eax,%eax
801033f0:	74 2b                	je     8010341d <piperead+0x7d>
    if(proc->killed){
801033f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801033f8:	8b 50 24             	mov    0x24(%eax),%edx
801033fb:	85 d2                	test   %edx,%edx
801033fd:	0f 85 7d 00 00 00    	jne    80103480 <piperead+0xe0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103403:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103407:	89 34 24             	mov    %esi,(%esp)
8010340a:	e8 01 06 00 00       	call   80103a10 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010340f:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
80103415:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
8010341b:	74 cb                	je     801033e8 <piperead+0x48>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010341d:	85 ff                	test   %edi,%edi
8010341f:	7e 76                	jle    80103497 <piperead+0xf7>
    if(p->nread == p->nwrite)
80103421:	31 f6                	xor    %esi,%esi
80103423:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103429:	75 0d                	jne    80103438 <piperead+0x98>
8010342b:	eb 6a                	jmp    80103497 <piperead+0xf7>
8010342d:	8d 76 00             	lea    0x0(%esi),%esi
80103430:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
80103436:	74 22                	je     8010345a <piperead+0xba>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103438:	89 d0                	mov    %edx,%eax
8010343a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010343d:	83 c2 01             	add    $0x1,%edx
80103440:	25 ff 01 00 00       	and    $0x1ff,%eax
80103445:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
8010344a:	88 04 31             	mov    %al,(%ecx,%esi,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010344d:	83 c6 01             	add    $0x1,%esi
80103450:	39 f7                	cmp    %esi,%edi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103452:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103458:	7f d6                	jg     80103430 <piperead+0x90>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010345a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103460:	89 04 24             	mov    %eax,(%esp)
80103463:	e8 48 04 00 00       	call   801038b0 <wakeup>
  release(&p->lock);
80103468:	89 1c 24             	mov    %ebx,(%esp)
8010346b:	e8 e0 10 00 00       	call   80104550 <release>
  return i;
}
80103470:	83 c4 1c             	add    $0x1c,%esp
80103473:	89 f0                	mov    %esi,%eax
80103475:	5b                   	pop    %ebx
80103476:	5e                   	pop    %esi
80103477:	5f                   	pop    %edi
80103478:	5d                   	pop    %ebp
80103479:	c3                   	ret    
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
80103480:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103485:	89 1c 24             	mov    %ebx,(%esp)
80103488:	e8 c3 10 00 00       	call   80104550 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010348d:	83 c4 1c             	add    $0x1c,%esp
80103490:	89 f0                	mov    %esi,%eax
80103492:	5b                   	pop    %ebx
80103493:	5e                   	pop    %esi
80103494:	5f                   	pop    %edi
80103495:	5d                   	pop    %ebp
80103496:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103497:	31 f6                	xor    %esi,%esi
80103499:	eb bf                	jmp    8010345a <piperead+0xba>
8010349b:	90                   	nop
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034a0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	57                   	push   %edi
801034a4:	56                   	push   %esi
801034a5:	53                   	push   %ebx
801034a6:	83 ec 3c             	sub    $0x3c,%esp
801034a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034ac:	89 1c 24             	mov    %ebx,(%esp)
801034af:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034b5:	e8 e6 10 00 00       	call   801045a0 <acquire>
  for(i = 0; i < n; i++){
801034ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
801034bd:	85 c9                	test   %ecx,%ecx
801034bf:	0f 8e 8d 00 00 00    	jle    80103552 <pipewrite+0xb2>
801034c5:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034cb:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
801034d1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801034d8:	eb 37                	jmp    80103511 <pipewrite+0x71>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801034e0:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034e6:	85 c0                	test   %eax,%eax
801034e8:	74 7e                	je     80103568 <pipewrite+0xc8>
801034ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801034f0:	8b 50 24             	mov    0x24(%eax),%edx
801034f3:	85 d2                	test   %edx,%edx
801034f5:	75 71                	jne    80103568 <pipewrite+0xc8>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034f7:	89 34 24             	mov    %esi,(%esp)
801034fa:	e8 b1 03 00 00       	call   801038b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103503:	89 3c 24             	mov    %edi,(%esp)
80103506:	e8 05 05 00 00       	call   80103a10 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010350b:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103511:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
80103517:	81 c2 00 02 00 00    	add    $0x200,%edx
8010351d:	39 d0                	cmp    %edx,%eax
8010351f:	74 bf                	je     801034e0 <pipewrite+0x40>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103521:	89 c2                	mov    %eax,%edx
80103523:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103526:	83 c0 01             	add    $0x1,%eax
80103529:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010352f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80103532:	8b 55 0c             	mov    0xc(%ebp),%edx
80103535:	0f b6 0c 0a          	movzbl (%edx,%ecx,1),%ecx
80103539:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010353c:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103540:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103546:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010354a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010354d:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103550:	7f bf                	jg     80103511 <pipewrite+0x71>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103552:	89 34 24             	mov    %esi,(%esp)
80103555:	e8 56 03 00 00       	call   801038b0 <wakeup>
  release(&p->lock);
8010355a:	89 1c 24             	mov    %ebx,(%esp)
8010355d:	e8 ee 0f 00 00       	call   80104550 <release>
  return n;
80103562:	eb 13                	jmp    80103577 <pipewrite+0xd7>
80103564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103568:	89 1c 24             	mov    %ebx,(%esp)
8010356b:	e8 e0 0f 00 00       	call   80104550 <release>
80103570:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103577:	8b 45 10             	mov    0x10(%ebp),%eax
8010357a:	83 c4 3c             	add    $0x3c,%esp
8010357d:	5b                   	pop    %ebx
8010357e:	5e                   	pop    %esi
8010357f:	5f                   	pop    %edi
80103580:	5d                   	pop    %ebp
80103581:	c3                   	ret    
80103582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103590 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	83 ec 18             	sub    $0x18,%esp
80103596:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103599:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010359c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010359f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035a2:	89 1c 24             	mov    %ebx,(%esp)
801035a5:	e8 f6 0f 00 00       	call   801045a0 <acquire>
  if(writable){
801035aa:	85 f6                	test   %esi,%esi
801035ac:	74 42                	je     801035f0 <pipeclose+0x60>
    p->writeopen = 0;
801035ae:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801035b5:	00 00 00 
    wakeup(&p->nread);
801035b8:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035be:	89 04 24             	mov    %eax,(%esp)
801035c1:	e8 ea 02 00 00       	call   801038b0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035c6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035cc:	85 c0                	test   %eax,%eax
801035ce:	75 0a                	jne    801035da <pipeclose+0x4a>
801035d0:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035d6:	85 f6                	test   %esi,%esi
801035d8:	74 36                	je     80103610 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035da:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035dd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801035e0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801035e3:	89 ec                	mov    %ebp,%esp
801035e5:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035e6:	e9 65 0f 00 00       	jmp    80104550 <release>
801035eb:	90                   	nop
801035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801035f0:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035f7:	00 00 00 
    wakeup(&p->nwrite);
801035fa:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103600:	89 04 24             	mov    %eax,(%esp)
80103603:	e8 a8 02 00 00       	call   801038b0 <wakeup>
80103608:	eb bc                	jmp    801035c6 <pipeclose+0x36>
8010360a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103610:	89 1c 24             	mov    %ebx,(%esp)
80103613:	e8 38 0f 00 00       	call   80104550 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
80103618:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
8010361b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
8010361e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103621:	89 ec                	mov    %ebp,%esp
80103623:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103624:	e9 97 ed ff ff       	jmp    801023c0 <kfree>
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103630 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	57                   	push   %edi
80103634:	56                   	push   %esi
80103635:	53                   	push   %ebx
80103636:	83 ec 1c             	sub    $0x1c,%esp
80103639:	8b 75 08             	mov    0x8(%ebp),%esi
8010363c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010363f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103645:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010364b:	e8 a0 d9 ff ff       	call   80100ff0 <filealloc>
80103650:	85 c0                	test   %eax,%eax
80103652:	89 06                	mov    %eax,(%esi)
80103654:	0f 84 9c 00 00 00    	je     801036f6 <pipealloc+0xc6>
8010365a:	e8 91 d9 ff ff       	call   80100ff0 <filealloc>
8010365f:	85 c0                	test   %eax,%eax
80103661:	89 03                	mov    %eax,(%ebx)
80103663:	0f 84 7f 00 00 00    	je     801036e8 <pipealloc+0xb8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103669:	e8 02 ed ff ff       	call   80102370 <kalloc>
8010366e:	85 c0                	test   %eax,%eax
80103670:	89 c7                	mov    %eax,%edi
80103672:	74 74                	je     801036e8 <pipealloc+0xb8>
    goto bad;
  p->readopen = 1;
80103674:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010367b:	00 00 00 
  p->writeopen = 1;
8010367e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103685:	00 00 00 
  p->nwrite = 0;
80103688:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010368f:	00 00 00 
  p->nread = 0;
80103692:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103699:	00 00 00 
  initlock(&p->lock, "pipe");
8010369c:	89 04 24             	mov    %eax,(%esp)
8010369f:	c7 44 24 04 f8 76 10 	movl   $0x801076f8,0x4(%esp)
801036a6:	80 
801036a7:	e8 64 0d 00 00       	call   80104410 <initlock>
  (*f0)->type = FD_PIPE;
801036ac:	8b 06                	mov    (%esi),%eax
801036ae:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801036b4:	8b 06                	mov    (%esi),%eax
801036b6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801036ba:	8b 06                	mov    (%esi),%eax
801036bc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801036c0:	8b 06                	mov    (%esi),%eax
801036c2:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801036c5:	8b 03                	mov    (%ebx),%eax
801036c7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801036cd:	8b 03                	mov    (%ebx),%eax
801036cf:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801036d3:	8b 03                	mov    (%ebx),%eax
801036d5:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801036d9:	8b 03                	mov    (%ebx),%eax
801036db:	89 78 0c             	mov    %edi,0xc(%eax)
801036de:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036e0:	83 c4 1c             	add    $0x1c,%esp
801036e3:	5b                   	pop    %ebx
801036e4:	5e                   	pop    %esi
801036e5:	5f                   	pop    %edi
801036e6:	5d                   	pop    %ebp
801036e7:	c3                   	ret    

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801036e8:	8b 06                	mov    (%esi),%eax
801036ea:	85 c0                	test   %eax,%eax
801036ec:	74 08                	je     801036f6 <pipealloc+0xc6>
    fileclose(*f0);
801036ee:	89 04 24             	mov    %eax,(%esp)
801036f1:	e8 7a d9 ff ff       	call   80101070 <fileclose>
  if(*f1)
801036f6:	8b 13                	mov    (%ebx),%edx
801036f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036fd:	85 d2                	test   %edx,%edx
801036ff:	74 df                	je     801036e0 <pipealloc+0xb0>
    fileclose(*f1);
80103701:	89 14 24             	mov    %edx,(%esp)
80103704:	e8 67 d9 ff ff       	call   80101070 <fileclose>
80103709:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010370e:	eb d0                	jmp    801036e0 <pipealloc+0xb0>

80103710 <setpriority>:
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}

int setpriority(int priority)			//added lab1p2
{												//sets given priorty for given process
80103710:	55                   	push   %ebp
  
    //acquire(&ptable.lock);

    //for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      //if(p->pid == pid)
     proc->priority = priority; 
80103711:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}

int setpriority(int priority)			//added lab1p2
{												//sets given priorty for given process
80103717:	89 e5                	mov    %esp,%ebp
  
    //acquire(&ptable.lock);

    //for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      //if(p->pid == pid)
     proc->priority = priority; 
80103719:	8b 55 08             	mov    0x8(%ebp),%edx
8010371c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //}

    //release(&ptable.lock);

    return 0;
}
80103722:	31 c0                	xor    %eax,%eax
80103724:	5d                   	pop    %ebp
80103725:	c3                   	ret    
80103726:	8d 76 00             	lea    0x0(%esi),%esi
80103729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103730 <hello>:
  }
}


void 
hello(void) {
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 18             	sub    $0x18,%esp
	
	cprintf("\nHello!!!!!!! \n");
80103736:	c7 04 24 fd 76 10 80 	movl   $0x801076fd,(%esp)
8010373d:	e8 2e d1 ff ff       	call   80100870 <cprintf>
}
80103742:	c9                   	leave  
80103743:	c3                   	ret    
80103744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010374a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103750 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	57                   	push   %edi
80103754:	56                   	push   %esi
80103755:	53                   	push   %ebx
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
80103756:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
8010375b:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010375e:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103761:	eb 4e                	jmp    801037b1 <procdump+0x61>
80103763:	90                   	nop
80103764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103768:	8b 04 85 e0 77 10 80 	mov    -0x7fef8820(,%eax,4),%eax
8010376f:	85 c0                	test   %eax,%eax
80103771:	74 4a                	je     801037bd <procdump+0x6d>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103773:	89 44 24 08          	mov    %eax,0x8(%esp)
80103777:	8b 43 10             	mov    0x10(%ebx),%eax
8010377a:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010377d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80103781:	c7 04 24 11 77 10 80 	movl   $0x80107711,(%esp)
80103788:	89 44 24 04          	mov    %eax,0x4(%esp)
8010378c:	e8 df d0 ff ff       	call   80100870 <cprintf>
    if(p->state == SLEEPING){
80103791:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103795:	74 31                	je     801037c8 <procdump+0x78>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103797:	c7 04 24 d6 76 10 80 	movl   $0x801076d6,(%esp)
8010379e:	e8 cd d0 ff ff       	call   80100870 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037a3:	81 c3 84 00 00 00    	add    $0x84,%ebx
801037a9:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
801037af:	74 57                	je     80103808 <procdump+0xb8>
    if(p->state == UNUSED)
801037b1:	8b 43 0c             	mov    0xc(%ebx),%eax
801037b4:	85 c0                	test   %eax,%eax
801037b6:	74 eb                	je     801037a3 <procdump+0x53>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801037b8:	83 f8 05             	cmp    $0x5,%eax
801037bb:	76 ab                	jbe    80103768 <procdump+0x18>
801037bd:	b8 0d 77 10 80       	mov    $0x8010770d,%eax
801037c2:	eb af                	jmp    80103773 <procdump+0x23>
801037c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
801037c8:	8b 43 1c             	mov    0x1c(%ebx),%eax
801037cb:	31 f6                	xor    %esi,%esi
801037cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
801037d1:	8b 40 0c             	mov    0xc(%eax),%eax
801037d4:	83 c0 08             	add    $0x8,%eax
801037d7:	89 04 24             	mov    %eax,(%esp)
801037da:	e8 51 0c 00 00       	call   80104430 <getcallerpcs>
801037df:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
801037e0:	8b 04 b7             	mov    (%edi,%esi,4),%eax
801037e3:	85 c0                	test   %eax,%eax
801037e5:	74 b0                	je     80103797 <procdump+0x47>
801037e7:	83 c6 01             	add    $0x1,%esi
        cprintf(" %p", pc[i]);
801037ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801037ee:	c7 04 24 11 72 10 80 	movl   $0x80107211,(%esp)
801037f5:	e8 76 d0 ff ff       	call   80100870 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801037fa:	83 fe 0a             	cmp    $0xa,%esi
801037fd:	75 e1                	jne    801037e0 <procdump+0x90>
801037ff:	eb 96                	jmp    80103797 <procdump+0x47>
80103801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80103808:	83 c4 4c             	add    $0x4c,%esp
8010380b:	5b                   	pop    %ebx
8010380c:	5e                   	pop    %esi
8010380d:	5f                   	pop    %edi
8010380e:	5d                   	pop    %ebp
8010380f:	90                   	nop
80103810:	c3                   	ret    
80103811:	eb 0d                	jmp    80103820 <kill>
80103813:	90                   	nop
80103814:	90                   	nop
80103815:	90                   	nop
80103816:	90                   	nop
80103817:	90                   	nop
80103818:	90                   	nop
80103819:	90                   	nop
8010381a:	90                   	nop
8010381b:	90                   	nop
8010381c:	90                   	nop
8010381d:	90                   	nop
8010381e:	90                   	nop
8010381f:	90                   	nop

80103820 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	53                   	push   %ebx
80103824:	83 ec 14             	sub    $0x14,%esp
80103827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010382a:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103831:	e8 6a 0d 00 00       	call   801045a0 <acquire>

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
80103836:	b8 58 2e 11 80       	mov    $0x80112e58,%eax
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
8010383b:	39 1d e4 2d 11 80    	cmp    %ebx,0x80112de4
80103841:	75 11                	jne    80103854 <kill+0x34>
80103843:	eb 62                	jmp    801038a7 <kill+0x87>
80103845:	8d 76 00             	lea    0x0(%esi),%esi
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103848:	05 84 00 00 00       	add    $0x84,%eax
8010384d:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103852:	74 3c                	je     80103890 <kill+0x70>
    if(p->pid == pid){
80103854:	39 58 10             	cmp    %ebx,0x10(%eax)
80103857:	75 ef                	jne    80103848 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103859:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
8010385d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103864:	74 1a                	je     80103880 <kill+0x60>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103866:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010386d:	e8 de 0c 00 00       	call   80104550 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103872:	83 c4 14             	add    $0x14,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
80103875:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103877:	5b                   	pop    %ebx
80103878:	5d                   	pop    %ebp
80103879:	c3                   	ret    
8010387a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103880:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103887:	eb dd                	jmp    80103866 <kill+0x46>
80103889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103890:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103897:	e8 b4 0c 00 00       	call   80104550 <release>
  return -1;
}
8010389c:	83 c4 14             	add    $0x14,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
8010389f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
801038a4:	5b                   	pop    %ebx
801038a5:	5d                   	pop    %ebp
801038a6:	c3                   	ret    
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
801038a7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801038ac:	eb ab                	jmp    80103859 <kill+0x39>
801038ae:	66 90                	xchg   %ax,%ax

801038b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 14             	sub    $0x14,%esp
801038b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801038ba:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801038c1:	e8 da 0c 00 00       	call   801045a0 <acquire>
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
801038c6:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801038cb:	eb 0f                	jmp    801038dc <wakeup+0x2c>
801038cd:	8d 76 00             	lea    0x0(%esi),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038d0:	05 84 00 00 00       	add    $0x84,%eax
801038d5:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
801038da:	74 24                	je     80103900 <wakeup+0x50>
    if(p->state == SLEEPING && p->chan == chan)
801038dc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801038e0:	75 ee                	jne    801038d0 <wakeup+0x20>
801038e2:	3b 58 20             	cmp    0x20(%eax),%ebx
801038e5:	75 e9                	jne    801038d0 <wakeup+0x20>
      p->state = RUNNABLE;
801038e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038ee:	05 84 00 00 00       	add    $0x84,%eax
801038f3:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
801038f8:	75 e2                	jne    801038dc <wakeup+0x2c>
801038fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103900:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80103907:	83 c4 14             	add    $0x14,%esp
8010390a:	5b                   	pop    %ebx
8010390b:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
8010390c:	e9 3f 0c 00 00       	jmp    80104550 <release>
80103911:	eb 0d                	jmp    80103920 <forkret>
80103913:	90                   	nop
80103914:	90                   	nop
80103915:	90                   	nop
80103916:	90                   	nop
80103917:	90                   	nop
80103918:	90                   	nop
80103919:	90                   	nop
8010391a:	90                   	nop
8010391b:	90                   	nop
8010391c:	90                   	nop
8010391d:	90                   	nop
8010391e:	90                   	nop
8010391f:	90                   	nop

80103920 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103926:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010392d:	e8 1e 0c 00 00       	call   80104550 <release>

  if (first) {
80103932:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80103937:	85 c0                	test   %eax,%eax
80103939:	75 05                	jne    80103940 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010393b:	c9                   	leave  
8010393c:	c3                   	ret    
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103940:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103947:	c7 05 08 a0 10 80 00 	movl   $0x0,0x8010a008
8010394e:	00 00 00 
    iinit(ROOTDEV);
80103951:	e8 9a e5 ff ff       	call   80101ef0 <iinit>
    initlog(ROOTDEV);
80103956:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010395d:	e8 ce f4 ff ff       	call   80102e30 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103962:	c9                   	leave  
80103963:	c3                   	ret    
80103964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010396a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103970 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
80103977:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010397e:	e8 0d 0b 00 00       	call   80104490 <holding>
80103983:	85 c0                	test   %eax,%eax
80103985:	74 4d                	je     801039d4 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103987:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010398d:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
80103994:	75 62                	jne    801039f8 <sched+0x88>
    panic("sched locks");
  if(proc->state == RUNNING)
80103996:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010399d:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
801039a1:	74 49                	je     801039ec <sched+0x7c>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801039a3:	9c                   	pushf  
801039a4:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
801039a5:	80 e5 02             	and    $0x2,%ch
801039a8:	75 36                	jne    801039e0 <sched+0x70>
    panic("sched interruptible");
  intena = cpu->intena;
801039aa:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  swtch(&proc->context, cpu->scheduler);
801039b0:	83 c2 1c             	add    $0x1c,%edx
801039b3:	8b 40 04             	mov    0x4(%eax),%eax
801039b6:	89 14 24             	mov    %edx,(%esp)
801039b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801039bd:	e8 ca 0e 00 00       	call   8010488c <swtch>
  cpu->intena = intena;
801039c2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801039c8:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
801039ce:	83 c4 14             	add    $0x14,%esp
801039d1:	5b                   	pop    %ebx
801039d2:	5d                   	pop    %ebp
801039d3:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
801039d4:	c7 04 24 1a 77 10 80 	movl   $0x8010771a,(%esp)
801039db:	e8 f0 c9 ff ff       	call   801003d0 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
801039e0:	c7 04 24 46 77 10 80 	movl   $0x80107746,(%esp)
801039e7:	e8 e4 c9 ff ff       	call   801003d0 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
801039ec:	c7 04 24 38 77 10 80 	movl   $0x80107738,(%esp)
801039f3:	e8 d8 c9 ff ff       	call   801003d0 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
801039f8:	c7 04 24 2c 77 10 80 	movl   $0x8010772c,(%esp)
801039ff:	e8 cc c9 ff ff       	call   801003d0 <panic>
80103a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103a10 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
80103a15:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
80103a18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103a1e:	8b 75 08             	mov    0x8(%ebp),%esi
80103a21:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103a24:	85 c0                	test   %eax,%eax
80103a26:	0f 84 a1 00 00 00    	je     80103acd <sleep+0xbd>
    panic("sleep");

  if(lk == 0)
80103a2c:	85 db                	test   %ebx,%ebx
80103a2e:	0f 84 8d 00 00 00    	je     80103ac1 <sleep+0xb1>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103a34:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103a3a:	74 5c                	je     80103a98 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103a3c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a43:	e8 58 0b 00 00       	call   801045a0 <acquire>
    release(lk);
80103a48:	89 1c 24             	mov    %ebx,(%esp)
80103a4b:	e8 00 0b 00 00       	call   80104550 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103a50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a56:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103a59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a5f:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103a66:	e8 05 ff ff ff       	call   80103970 <sched>

  // Tidy up.
  proc->chan = 0;
80103a6b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a71:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103a78:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a7f:	e8 cc 0a 00 00       	call   80104550 <release>
    acquire(lk);
80103a84:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
80103a87:	83 c4 10             	add    $0x10,%esp
80103a8a:	5b                   	pop    %ebx
80103a8b:	5e                   	pop    %esi
80103a8c:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103a8d:	e9 0e 0b 00 00       	jmp    801045a0 <acquire>
80103a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103a98:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103a9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103aa1:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103aa8:	e8 c3 fe ff ff       	call   80103970 <sched>

  // Tidy up.
  proc->chan = 0;
80103aad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ab3:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103aba:	83 c4 10             	add    $0x10,%esp
80103abd:	5b                   	pop    %ebx
80103abe:	5e                   	pop    %esi
80103abf:	5d                   	pop    %ebp
80103ac0:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103ac1:	c7 04 24 60 77 10 80 	movl   $0x80107760,(%esp)
80103ac8:	e8 03 c9 ff ff       	call   801003d0 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103acd:	c7 04 24 5a 77 10 80 	movl   $0x8010775a,(%esp)
80103ad4:	e8 f7 c8 ff ff       	call   801003d0 <panic>
80103ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ae0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ae6:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103aed:	e8 ae 0a 00 00       	call   801045a0 <acquire>
  proc->state = RUNNABLE;
80103af2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103af8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103aff:	e8 6c fe ff ff       	call   80103970 <sched>
  release(&ptable.lock);
80103b04:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b0b:	e8 40 0a 00 00       	call   80104550 <release>
}
80103b10:	c9                   	leave  
80103b11:	c3                   	ret    
80103b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b20 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	56                   	push   %esi
80103b24:	53                   	push   %ebx
80103b25:	83 ec 10             	sub    $0x10,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b28:	fb                   	sti    
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
80103b29:	be 40 00 00 00       	mov    $0x40,%esi
    // Enable interrupts on this processor.
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b2e:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b35:	e8 66 0a 00 00       	call   801045a0 <acquire>
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
80103b3a:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103b3f:	eb 13                	jmp    80103b54 <scheduler+0x34>
80103b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b48:	05 84 00 00 00       	add    $0x84,%eax
80103b4d:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103b52:	74 1d                	je     80103b71 <scheduler+0x51>
      if(p->state != RUNNABLE)
80103b54:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b58:	75 ee                	jne    80103b48 <scheduler+0x28>
80103b5a:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80103b60:	39 d6                	cmp    %edx,%esi
80103b62:	0f 4f f2             	cmovg  %edx,%esi
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b65:	05 84 00 00 00       	add    $0x84,%eax
80103b6a:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103b6f:	75 e3                	jne    80103b54 <scheduler+0x34>
80103b71:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103b76:	eb 0e                	jmp    80103b86 <scheduler+0x66>
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b78:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103b7e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103b84:	74 5a                	je     80103be0 <scheduler+0xc0>
    {
      if(p->state != RUNNABLE || p->priority != highest_Priority)
80103b86:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b8a:	75 ec                	jne    80103b78 <scheduler+0x58>
80103b8c:	39 b3 80 00 00 00    	cmp    %esi,0x80(%ebx)
80103b92:	75 e4                	jne    80103b78 <scheduler+0x58>
      // before jumping back to us.
      
      //edited for lab 1 part 2 round robin scheduler
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
80103b94:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
		switchuvm(p);
80103b9b:	89 1c 24             	mov    %ebx,(%esp)
80103b9e:	e8 0d 34 00 00       	call   80106fb0 <switchuvm>
		p->state = RUNNING;
		swtch(&cpu->scheduler, p->context);
80103ba3:	8b 43 1c             	mov    0x1c(%ebx),%eax
      //edited for lab 1 part 2 round robin scheduler
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
		switchuvm(p);
		p->state = RUNNING;
80103ba6:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bad:	81 c3 84 00 00 00    	add    $0x84,%ebx
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
		switchuvm(p);
		p->state = RUNNING;
		swtch(&cpu->scheduler, p->context);
80103bb3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103bbd:	83 c0 04             	add    $0x4,%eax
80103bc0:	89 04 24             	mov    %eax,(%esp)
80103bc3:	e8 c4 0c 00 00       	call   8010488c <swtch>
		switchkvm();
80103bc8:	e8 c3 2c 00 00       	call   80106890 <switchkvm>
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bcd:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
		swtch(&cpu->scheduler, p->context);
		switchkvm();

		// Process is done running for now.
		// It should have changed its p->state before coming back.
		proc = 0;
80103bd3:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103bda:	00 00 00 00 
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bde:	75 a6                	jne    80103b86 <scheduler+0x66>
		// Process is done running for now.
		// It should have changed its p->state before coming back.
		proc = 0;
	  }
      
    release(&ptable.lock);
80103be0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103be7:	e8 64 09 00 00       	call   80104550 <release>

  }
80103bec:	e9 37 ff ff ff       	jmp    80103b28 <scheduler+0x8>
80103bf1:	eb 0d                	jmp    80103c00 <waitpid>
80103bf3:	90                   	nop
80103bf4:	90                   	nop
80103bf5:	90                   	nop
80103bf6:	90                   	nop
80103bf7:	90                   	nop
80103bf8:	90                   	nop
80103bf9:	90                   	nop
80103bfa:	90                   	nop
80103bfb:	90                   	nop
80103bfc:	90                   	nop
80103bfd:	90                   	nop
80103bfe:	90                   	nop
80103bff:	90                   	nop

80103c00 <waitpid>:
  }
}

int 
waitpid(int pid, int* status, int options)		//added lab1 part1 
{													//exactly the same as wait 
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
													//but now searches for passed in pid
  struct proc *p;									//pid flag substituted for child flag
  int foundPid;

  acquire(&ptable.lock);
80103c06:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
  }
}

int 
waitpid(int pid, int* status, int options)		//added lab1 part1 
{													//exactly the same as wait 
80103c0b:	83 ec 1c             	sub    $0x1c,%esp
80103c0e:	8b 75 08             	mov    0x8(%ebp),%esi
80103c11:	8b 7d 0c             	mov    0xc(%ebp),%edi
													//but now searches for passed in pid
  struct proc *p;									//pid flag substituted for child flag
  int foundPid;

  acquire(&ptable.lock);
80103c14:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103c1b:	e8 80 09 00 00       	call   801045a0 <acquire>
80103c20:	31 d2                	xor    %edx,%edx
80103c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c28:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103c2e:	72 31                	jb     80103c61 <waitpid+0x61>
	  return pid;
	  }
    }

    // If pid not found or killed(ERROR) has occured same as wait function
    if(!foundPid || proc->killed){
80103c30:	85 d2                	test   %edx,%edx
80103c32:	74 4c                	je     80103c80 <waitpid+0x80>
80103c34:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c3b:	8b 4a 24             	mov    0x24(%edx),%ecx
80103c3e:	85 c9                	test   %ecx,%ecx
80103c40:	75 3e                	jne    80103c80 <waitpid+0x80>
      release(&ptable.lock);
      return -1;
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
80103c42:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103c47:	89 14 24             	mov    %edx,(%esp)
80103c4a:	c7 44 24 04 a0 2d 11 	movl   $0x80112da0,0x4(%esp)
80103c51:	80 
80103c52:	e8 b9 fd ff ff       	call   80103a10 <sleep>
80103c57:	31 d2                	xor    %edx,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c59:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103c5f:	73 cf                	jae    80103c30 <waitpid+0x30>
      if(p->pid != pid)
80103c61:	39 73 10             	cmp    %esi,0x10(%ebx)
80103c64:	74 0a                	je     80103c70 <waitpid+0x70>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c66:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103c6c:	eb ba                	jmp    80103c28 <waitpid+0x28>
80103c6e:	66 90                	xchg   %ax,%ax
      if(p->pid != pid)
        continue;
      foundPid = 1;
      if(p->state == ZOMBIE){
80103c70:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103c74:	74 25                	je     80103c9b <waitpid+0x9b>
		if(status != 0){			//same as wait function addition
			*status = p->status;
		}
      release(&ptable.lock);
        
	  return pid;
80103c76:	ba 01 00 00 00       	mov    $0x1,%edx
80103c7b:	eb e9                	jmp    80103c66 <waitpid+0x66>
80103c7d:	8d 76 00             	lea    0x0(%esi),%esi
	  }
    }

    // If pid not found or killed(ERROR) has occured same as wait function
    if(!foundPid || proc->killed){
      release(&ptable.lock);
80103c80:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103c85:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103c8c:	e8 bf 08 00 00       	call   80104550 <release>
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}
80103c91:	83 c4 1c             	add    $0x1c,%esp
80103c94:	89 f0                	mov    %esi,%eax
80103c96:	5b                   	pop    %ebx
80103c97:	5e                   	pop    %esi
80103c98:	5f                   	pop    %edi
80103c99:	5d                   	pop    %ebp
80103c9a:	c3                   	ret    
        continue;
      foundPid = 1;
      if(p->state == ZOMBIE){
        // match pid
        pid = p->pid;
        kfree(p->kstack);
80103c9b:	8b 43 08             	mov    0x8(%ebx),%eax
80103c9e:	89 04 24             	mov    %eax,(%esp)
80103ca1:	e8 1a e7 ff ff       	call   801023c0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103ca6:	8b 43 04             	mov    0x4(%ebx),%eax
      foundPid = 1;
      if(p->state == ZOMBIE){
        // match pid
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103ca9:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103cb0:	89 04 24             	mov    %eax,(%esp)
80103cb3:	e8 c8 2f 00 00       	call   80106c80 <freevm>
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;

		if(status != 0){			//same as wait function addition
80103cb8:	85 ff                	test   %edi,%edi
        // match pid
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103cba:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103cc1:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103cc8:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ccc:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103cd3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)

		if(status != 0){			//same as wait function addition
80103cda:	74 05                	je     80103ce1 <waitpid+0xe1>
			*status = p->status;
80103cdc:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103cdf:	89 07                	mov    %eax,(%edi)
		}
      release(&ptable.lock);
80103ce1:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ce8:	e8 63 08 00 00       	call   80104550 <release>
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}
80103ced:	83 c4 1c             	add    $0x1c,%esp
80103cf0:	89 f0                	mov    %esi,%eax
80103cf2:	5b                   	pop    %ebx
80103cf3:	5e                   	pop    %esi
80103cf4:	5f                   	pop    %edi
80103cf5:	5d                   	pop    %ebp
80103cf6:	c3                   	ret    
80103cf7:	89 f6                	mov    %esi,%esi
80103cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d00 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	56                   	push   %esi
80103d04:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103d05:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80103d0a:	83 ec 20             	sub    $0x20,%esp
80103d0d:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103d10:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d17:	e8 84 08 00 00       	call   801045a0 <acquire>
80103d1c:	31 c0                	xor    %eax,%eax
80103d1e:	66 90                	xchg   %ax,%ax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d20:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103d26:	72 30                	jb     80103d58 <wait+0x58>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103d28:	85 c0                	test   %eax,%eax
80103d2a:	74 54                	je     80103d80 <wait+0x80>
80103d2c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d32:	8b 58 24             	mov    0x24(%eax),%ebx
80103d35:	85 db                	test   %ebx,%ebx
80103d37:	75 47                	jne    80103d80 <wait+0x80>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103d39:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103d3e:	89 04 24             	mov    %eax,(%esp)
80103d41:	c7 44 24 04 a0 2d 11 	movl   $0x80112da0,0x4(%esp)
80103d48:	80 
80103d49:	e8 c2 fc ff ff       	call   80103a10 <sleep>
80103d4e:	31 c0                	xor    %eax,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d50:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103d56:	73 d0                	jae    80103d28 <wait+0x28>
      if(p->parent != proc)
80103d58:	8b 53 14             	mov    0x14(%ebx),%edx
80103d5b:	65 3b 15 04 00 00 00 	cmp    %gs:0x4,%edx
80103d62:	74 0c                	je     80103d70 <wait+0x70>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d64:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103d6a:	eb b4                	jmp    80103d20 <wait+0x20>
80103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103d70:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103d74:	74 22                	je     80103d98 <wait+0x98>
        if(status != 0) {			//lab1 part 1b set status if status is not null
			*status = p->status;
		}
		
        release(&ptable.lock);
        return pid;
80103d76:	b8 01 00 00 00       	mov    $0x1,%eax
80103d7b:	eb e7                	jmp    80103d64 <wait+0x64>
80103d7d:	8d 76 00             	lea    0x0(%esi),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103d80:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d87:	e8 c4 07 00 00       	call   80104550 <release>
80103d8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103d91:	83 c4 20             	add    $0x20,%esp
80103d94:	5b                   	pop    %ebx
80103d95:	5e                   	pop    %esi
80103d96:	5d                   	pop    %ebp
80103d97:	c3                   	ret    
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103d98:	8b 43 10             	mov    0x10(%ebx),%eax
        kfree(p->kstack);
80103d9b:	8b 53 08             	mov    0x8(%ebx),%edx
80103d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103da1:	89 14 24             	mov    %edx,(%esp)
80103da4:	e8 17 e6 ff ff       	call   801023c0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103da9:	8b 53 04             	mov    0x4(%ebx),%edx
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103dac:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103db3:	89 14 24             	mov    %edx,(%esp)
80103db6:	e8 c5 2e 00 00       	call   80106c80 <freevm>
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        
        if(status != 0) {			//lab1 part 1b set status if status is not null
80103dbb:	85 f6                	test   %esi,%esi
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103dbd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103dc4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103dcb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103dcf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103dd6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        
        if(status != 0) {			//lab1 part 1b set status if status is not null
80103ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103de0:	74 05                	je     80103de7 <wait+0xe7>
			*status = p->status;
80103de2:	8b 53 7c             	mov    0x7c(%ebx),%edx
80103de5:	89 16                	mov    %edx,(%esi)
		}
		
        release(&ptable.lock);
80103de7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103dea:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103df1:	e8 5a 07 00 00       	call   80104550 <release>
        return pid;
80103df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df9:	eb 96                	jmp    80103d91 <wait+0x91>
80103dfb:	90                   	nop
80103dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e00 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103e05:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
{
80103e07:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80103e0a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103e11:	3b 15 c4 a5 10 80    	cmp    0x8010a5c4,%edx
80103e17:	0f 84 18 01 00 00    	je     80103f35 <exit+0x135>
80103e1d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103e20:	8d 73 08             	lea    0x8(%ebx),%esi
80103e23:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103e27:	85 c0                	test   %eax,%eax
80103e29:	74 1d                	je     80103e48 <exit+0x48>
      fileclose(proc->ofile[fd]);
80103e2b:	89 04 24             	mov    %eax,(%esp)
80103e2e:	e8 3d d2 ff ff       	call   80101070 <fileclose>
      proc->ofile[fd] = 0;
80103e33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e39:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80103e40:	00 
80103e41:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e48:	83 c3 01             	add    $0x1,%ebx
80103e4b:	83 fb 10             	cmp    $0x10,%ebx
80103e4e:	75 d0                	jne    80103e20 <exit+0x20>
      proc->ofile[fd] = 0;
    }
  }

  // save exit status
  proc->status = status; //lab1 part1a return exit status to created variable
80103e50:	8b 45 08             	mov    0x8(%ebp),%eax
80103e53:	89 42 7c             	mov    %eax,0x7c(%edx)
  
  begin_op();
80103e56:	e8 65 ef ff ff       	call   80102dc0 <begin_op>
  iput(proc->cwd);
80103e5b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e61:	8b 40 68             	mov    0x68(%eax),%eax
80103e64:	89 04 24             	mov    %eax,(%esp)
80103e67:	e8 d4 d5 ff ff       	call   80101440 <iput>
  end_op();
80103e6c:	e8 1f ee ff ff       	call   80102c90 <end_op>
  proc->cwd = 0;
80103e71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e77:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103e7e:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e85:	e8 16 07 00 00       	call   801045a0 <acquire>

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);
80103e8a:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
80103e91:	b9 d4 4e 11 80       	mov    $0x80114ed4,%ecx
80103e96:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);
80103e9b:	8b 53 14             	mov    0x14(%ebx),%edx
80103e9e:	eb 0c                	jmp    80103eac <exit+0xac>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ea0:	05 84 00 00 00       	add    $0x84,%eax
80103ea5:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103eaa:	74 1e                	je     80103eca <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103eac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103eb0:	75 ee                	jne    80103ea0 <exit+0xa0>
80103eb2:	3b 50 20             	cmp    0x20(%eax),%edx
80103eb5:	75 e9                	jne    80103ea0 <exit+0xa0>
      p->state = RUNNABLE;
80103eb7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ebe:	05 84 00 00 00       	add    $0x84,%eax
80103ec3:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103ec8:	75 e2                	jne    80103eac <exit+0xac>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103eca:	8b 35 c4 a5 10 80    	mov    0x8010a5c4,%esi
80103ed0:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103ed5:	eb 0f                	jmp    80103ee6 <exit+0xe6>
80103ed7:	90                   	nop

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed8:	81 c2 84 00 00 00    	add    $0x84,%edx
80103ede:	81 fa d4 4e 11 80    	cmp    $0x80114ed4,%edx
80103ee4:	74 37                	je     80103f1d <exit+0x11d>
    if(p->parent == proc){
80103ee6:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103ee9:	75 ed                	jne    80103ed8 <exit+0xd8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103eeb:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103eef:	89 72 14             	mov    %esi,0x14(%edx)
      if(p->state == ZOMBIE)
80103ef2:	75 e4                	jne    80103ed8 <exit+0xd8>
80103ef4:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103ef9:	eb 0e                	jmp    80103f09 <exit+0x109>
80103efb:	90                   	nop
80103efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f00:	05 84 00 00 00       	add    $0x84,%eax
80103f05:	39 c1                	cmp    %eax,%ecx
80103f07:	74 cf                	je     80103ed8 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103f09:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f0d:	75 f1                	jne    80103f00 <exit+0x100>
80103f0f:	3b 70 20             	cmp    0x20(%eax),%esi
80103f12:	75 ec                	jne    80103f00 <exit+0x100>
      p->state = RUNNABLE;
80103f14:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f1b:	eb e3                	jmp    80103f00 <exit+0x100>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103f1d:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f24:	e8 47 fa ff ff       	call   80103970 <sched>
  panic("zombie exit");
80103f29:	c7 04 24 7e 77 10 80 	movl   $0x8010777e,(%esp)
80103f30:	e8 9b c4 ff ff       	call   801003d0 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103f35:	c7 04 24 71 77 10 80 	movl   $0x80107771,(%esp)
80103f3c:	e8 8f c4 ff ff       	call   801003d0 <panic>
80103f41:	eb 0d                	jmp    80103f50 <allocproc>
80103f43:	90                   	nop
80103f44:	90                   	nop
80103f45:	90                   	nop
80103f46:	90                   	nop
80103f47:	90                   	nop
80103f48:	90                   	nop
80103f49:	90                   	nop
80103f4a:	90                   	nop
80103f4b:	90                   	nop
80103f4c:	90                   	nop
80103f4d:	90                   	nop
80103f4e:	90                   	nop
80103f4f:	90                   	nop

80103f50 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80103f57:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f5e:	e8 3d 06 00 00       	call   801045a0 <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
80103f63:	8b 15 e0 2d 11 80    	mov    0x80112de0,%edx
80103f69:	85 d2                	test   %edx,%edx
80103f6b:	0f 84 b5 00 00 00    	je     80104026 <allocproc+0xd6>
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
80103f71:	bb 58 2e 11 80       	mov    $0x80112e58,%ebx
80103f76:	eb 12                	jmp    80103f8a <allocproc+0x3a>
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f78:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103f7e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103f84:	0f 84 86 00 00 00    	je     80104010 <allocproc+0xc0>
    if(p->state == UNUSED)
80103f8a:	8b 43 0c             	mov    0xc(%ebx),%eax
80103f8d:	85 c0                	test   %eax,%eax
80103f8f:	75 e7                	jne    80103f78 <allocproc+0x28>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103f91:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103f98:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103f9d:	89 43 10             	mov    %eax,0x10(%ebx)
80103fa0:	83 c0 01             	add    $0x1,%eax
80103fa3:	a3 04 a0 10 80       	mov    %eax,0x8010a004

  p->priority = 20; 	//lab1 part2 sceduling - set default priority to lowest priority
80103fa8:	c7 83 80 00 00 00 14 	movl   $0x14,0x80(%ebx)
80103faf:	00 00 00 

  release(&ptable.lock);
80103fb2:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103fb9:	e8 92 05 00 00       	call   80104550 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103fbe:	e8 ad e3 ff ff       	call   80102370 <kalloc>
80103fc3:	85 c0                	test   %eax,%eax
80103fc5:	89 43 08             	mov    %eax,0x8(%ebx)
80103fc8:	74 66                	je     80104030 <allocproc+0xe0>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103fca:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->tf = (struct trapframe*)sp;
80103fd0:	89 53 18             	mov    %edx,0x18(%ebx)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103fd3:	c7 80 b0 0f 00 00 80 	movl   $0x80105980,0xfb0(%eax)
80103fda:	59 10 80 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103fdd:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103fe2:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103fe5:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103fec:	00 
80103fed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103ff4:	00 
80103ff5:	89 04 24             	mov    %eax,(%esp)
80103ff8:	e8 43 06 00 00       	call   80104640 <memset>
  p->context->eip = (uint)forkret;
80103ffd:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104000:	c7 40 10 20 39 10 80 	movl   $0x80103920,0x10(%eax)

  return p;
}
80104007:	89 d8                	mov    %ebx,%eax
80104009:	83 c4 14             	add    $0x14,%esp
8010400c:	5b                   	pop    %ebx
8010400d:	5d                   	pop    %ebp
8010400e:	c3                   	ret    
8010400f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104010:	31 db                	xor    %ebx,%ebx
80104012:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80104019:	e8 32 05 00 00       	call   80104550 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010401e:	89 d8                	mov    %ebx,%eax
80104020:	83 c4 14             	add    $0x14,%esp
80104023:	5b                   	pop    %ebx
80104024:	5d                   	pop    %ebp
80104025:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
80104026:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
8010402b:	e9 61 ff ff ff       	jmp    80103f91 <allocproc+0x41>

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104030:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104037:	31 db                	xor    %ebx,%ebx
    return 0;
80104039:	eb cc                	jmp    80104007 <allocproc+0xb7>
8010403b:	90                   	nop
8010403c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104040 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
80104045:	be ff ff ff ff       	mov    $0xffffffff,%esi
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010404a:	53                   	push   %ebx
8010404b:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
8010404e:	e8 fd fe ff ff       	call   80103f50 <allocproc>
80104053:	85 c0                	test   %eax,%eax
80104055:	89 c3                	mov    %eax,%ebx
80104057:	0f 84 d6 00 00 00    	je     80104133 <fork+0xf3>
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010405d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104063:	8b 10                	mov    (%eax),%edx
80104065:	89 54 24 04          	mov    %edx,0x4(%esp)
80104069:	8b 40 04             	mov    0x4(%eax),%eax
8010406c:	89 04 24             	mov    %eax,(%esp)
8010406f:	e8 8c 2c 00 00       	call   80106d00 <copyuvm>
80104074:	85 c0                	test   %eax,%eax
80104076:	89 43 04             	mov    %eax,0x4(%ebx)
80104079:	0f 84 be 00 00 00    	je     8010413d <fork+0xfd>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
8010407f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80104085:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
8010408a:	8b 00                	mov    (%eax),%eax
8010408c:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
8010408e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104094:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80104097:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010409e:	8b 43 18             	mov    0x18(%ebx),%eax
801040a1:	8b 72 18             	mov    0x18(%edx),%esi
801040a4:	89 c7                	mov    %eax,%edi
801040a6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801040a8:	31 f6                	xor    %esi,%esi
801040aa:	8b 43 18             	mov    0x18(%ebx),%eax
801040ad:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801040b4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801040bb:	90                   	nop
801040bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
801040c0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
801040c4:	85 c0                	test   %eax,%eax
801040c6:	74 13                	je     801040db <fork+0x9b>
      np->ofile[i] = filedup(proc->ofile[i]);
801040c8:	89 04 24             	mov    %eax,(%esp)
801040cb:	e8 d0 ce ff ff       	call   80100fa0 <filedup>
801040d0:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
801040d4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801040db:	83 c6 01             	add    $0x1,%esi
801040de:	83 fe 10             	cmp    $0x10,%esi
801040e1:	75 dd                	jne    801040c0 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801040e3:	8b 42 68             	mov    0x68(%edx),%eax
801040e6:	89 04 24             	mov    %eax,(%esp)
801040e9:	e8 b2 d0 ff ff       	call   801011a0 <idup>
801040ee:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801040f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040f7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801040fe:	00 
801040ff:	83 c0 6c             	add    $0x6c,%eax
80104102:	89 44 24 04          	mov    %eax,0x4(%esp)
80104106:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104109:	89 04 24             	mov    %eax,(%esp)
8010410c:	e8 1f 07 00 00       	call   80104830 <safestrcpy>

  pid = np->pid;
80104111:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80104114:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010411b:	e8 80 04 00 00       	call   801045a0 <acquire>

  np->state = RUNNABLE;
80104120:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80104127:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010412e:	e8 1d 04 00 00       	call   80104550 <release>

  return pid;
}
80104133:	83 c4 1c             	add    $0x1c,%esp
80104136:	89 f0                	mov    %esi,%eax
80104138:	5b                   	pop    %ebx
80104139:	5e                   	pop    %esi
8010413a:	5f                   	pop    %edi
8010413b:	5d                   	pop    %ebp
8010413c:	c3                   	ret    
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
8010413d:	8b 43 08             	mov    0x8(%ebx),%eax
80104140:	89 04 24             	mov    %eax,(%esp)
80104143:	e8 78 e2 ff ff       	call   801023c0 <kfree>
    np->kstack = 0;
80104148:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
8010414f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104156:	eb db                	jmp    80104133 <fork+0xf3>
80104158:	90                   	nop
80104159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104160 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80104166:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010416d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80104170:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80104172:	83 f9 00             	cmp    $0x0,%ecx
80104175:	7f 19                	jg     80104190 <growproc+0x30>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80104177:	75 39                	jne    801041b2 <growproc+0x52>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80104179:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
8010417b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104181:	89 04 24             	mov    %eax,(%esp)
80104184:	e8 27 2e 00 00       	call   80106fb0 <switchuvm>
80104189:	31 c0                	xor    %eax,%eax
  return 0;
}
8010418b:	c9                   	leave  
8010418c:	c3                   	ret    
8010418d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104190:	01 c1                	add    %eax,%ecx
80104192:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80104196:	89 44 24 04          	mov    %eax,0x4(%esp)
8010419a:	8b 42 04             	mov    0x4(%edx),%eax
8010419d:	89 04 24             	mov    %eax,(%esp)
801041a0:	e8 2b 2c 00 00       	call   80106dd0 <allocuvm>
801041a5:	85 c0                	test   %eax,%eax
801041a7:	74 27                	je     801041d0 <growproc+0x70>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801041a9:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801041b0:	eb c7                	jmp    80104179 <growproc+0x19>
801041b2:	01 c1                	add    %eax,%ecx
801041b4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801041b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801041bc:	8b 42 04             	mov    0x4(%edx),%eax
801041bf:	89 04 24             	mov    %eax,(%esp)
801041c2:	e8 19 2a 00 00       	call   80106be0 <deallocuvm>
801041c7:	85 c0                	test   %eax,%eax
801041c9:	75 de                	jne    801041a9 <growproc+0x49>
801041cb:	90                   	nop
801041cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
801041d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041d5:	c9                   	leave  
801041d6:	c3                   	ret    
801041d7:	89 f6                	mov    %esi,%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041e0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801041e7:	e8 64 fd ff ff       	call   80103f50 <allocproc>
801041ec:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801041ee:	a3 c4 a5 10 80       	mov    %eax,0x8010a5c4
  if((p->pgdir = setupkvm()) == 0)
801041f3:	e8 88 28 00 00       	call   80106a80 <setupkvm>
801041f8:	85 c0                	test   %eax,%eax
801041fa:	89 43 04             	mov    %eax,0x4(%ebx)
801041fd:	0f 84 ce 00 00 00    	je     801042d1 <userinit+0xf1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104203:	89 04 24             	mov    %eax,(%esp)
80104206:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010420d:	00 
8010420e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80104215:	80 
80104216:	e8 35 29 00 00       	call   80106b50 <inituvm>
  p->sz = PGSIZE;
8010421b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104221:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80104228:	00 
80104229:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104230:	00 
80104231:	8b 43 18             	mov    0x18(%ebx),%eax
80104234:	89 04 24             	mov    %eax,(%esp)
80104237:	e8 04 04 00 00       	call   80104640 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010423c:	8b 43 18             	mov    0x18(%ebx),%eax
8010423f:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104245:	8b 43 18             	mov    0x18(%ebx),%eax
80104248:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010424e:	8b 43 18             	mov    0x18(%ebx),%eax
80104251:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104255:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104259:	8b 43 18             	mov    0x18(%ebx),%eax
8010425c:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104260:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104264:	8b 43 18             	mov    0x18(%ebx),%eax
80104267:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010426e:	8b 43 18             	mov    0x18(%ebx),%eax
80104271:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104278:	8b 43 18             	mov    0x18(%ebx),%eax
8010427b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104282:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104285:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010428c:	00 
8010428d:	c7 44 24 04 a3 77 10 	movl   $0x801077a3,0x4(%esp)
80104294:	80 
80104295:	89 04 24             	mov    %eax,(%esp)
80104298:	e8 93 05 00 00       	call   80104830 <safestrcpy>
  p->cwd = namei("/");
8010429d:	c7 04 24 ac 77 10 80 	movl   $0x801077ac,(%esp)
801042a4:	e8 27 dc ff ff       	call   80101ed0 <namei>
801042a9:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801042ac:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042b3:	e8 e8 02 00 00       	call   801045a0 <acquire>

  p->state = RUNNABLE;
801042b8:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801042bf:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042c6:	e8 85 02 00 00       	call   80104550 <release>
}
801042cb:	83 c4 14             	add    $0x14,%esp
801042ce:	5b                   	pop    %ebx
801042cf:	5d                   	pop    %ebp
801042d0:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801042d1:	c7 04 24 8a 77 10 80 	movl   $0x8010778a,(%esp)
801042d8:	e8 f3 c0 ff ff       	call   801003d0 <panic>
801042dd:	8d 76 00             	lea    0x0(%esi),%esi

801042e0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801042e6:	c7 44 24 04 ae 77 10 	movl   $0x801077ae,0x4(%esp)
801042ed:	80 
801042ee:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042f5:	e8 16 01 00 00       	call   80104410 <initlock>
}
801042fa:	c9                   	leave  
801042fb:	c3                   	ret    
801042fc:	00 00                	add    %al,(%eax)
	...

80104300 <holdingsleep>:
  release(&lk->lk);
}

int
holdingsleep(struct sleeplock *lk)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	83 ec 18             	sub    $0x18,%esp
80104306:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104309:	8b 75 08             	mov    0x8(%ebp),%esi
8010430c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  int r;
  
  acquire(&lk->lk);
8010430f:	8d 5e 04             	lea    0x4(%esi),%ebx
80104312:	89 1c 24             	mov    %ebx,(%esp)
80104315:	e8 86 02 00 00       	call   801045a0 <acquire>
  r = lk->locked;
8010431a:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
8010431c:	89 1c 24             	mov    %ebx,(%esp)
8010431f:	e8 2c 02 00 00       	call   80104550 <release>
  return r;
}
80104324:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104327:	89 f0                	mov    %esi,%eax
80104329:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010432c:	89 ec                	mov    %ebp,%esp
8010432e:	5d                   	pop    %ebp
8010432f:	c3                   	ret    

80104330 <releasesleep>:
  release(&lk->lk);
}

void
releasesleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	83 ec 18             	sub    $0x18,%esp
80104336:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104339:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010433c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010433f:	8d 73 04             	lea    0x4(%ebx),%esi
80104342:	89 34 24             	mov    %esi,(%esp)
80104345:	e8 56 02 00 00       	call   801045a0 <acquire>
  lk->locked = 0;
8010434a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104350:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104357:	89 1c 24             	mov    %ebx,(%esp)
8010435a:	e8 51 f5 ff ff       	call   801038b0 <wakeup>
  release(&lk->lk);
}
8010435f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104362:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104365:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104368:	89 ec                	mov    %ebp,%esp
8010436a:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
8010436b:	e9 e0 01 00 00       	jmp    80104550 <release>

80104370 <acquiresleep>:
  lk->pid = 0;
}

void
acquiresleep(struct sleeplock *lk)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	56                   	push   %esi
80104374:	53                   	push   %ebx
80104375:	83 ec 10             	sub    $0x10,%esp
80104378:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010437b:	8d 73 04             	lea    0x4(%ebx),%esi
8010437e:	89 34 24             	mov    %esi,(%esp)
80104381:	e8 1a 02 00 00       	call   801045a0 <acquire>
  while (lk->locked) {
80104386:	8b 13                	mov    (%ebx),%edx
80104388:	85 d2                	test   %edx,%edx
8010438a:	74 16                	je     801043a2 <acquiresleep+0x32>
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104390:	89 74 24 04          	mov    %esi,0x4(%esp)
80104394:	89 1c 24             	mov    %ebx,(%esp)
80104397:	e8 74 f6 ff ff       	call   80103a10 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010439c:	8b 03                	mov    (%ebx),%eax
8010439e:	85 c0                	test   %eax,%eax
801043a0:	75 ee                	jne    80104390 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801043a2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
801043a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043ae:	8b 40 10             	mov    0x10(%eax),%eax
801043b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043b7:	83 c4 10             	add    $0x10,%esp
801043ba:	5b                   	pop    %ebx
801043bb:	5e                   	pop    %esi
801043bc:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
801043bd:	e9 8e 01 00 00       	jmp    80104550 <release>
801043c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	53                   	push   %ebx
801043d4:	83 ec 14             	sub    $0x14,%esp
801043d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801043da:	c7 44 24 04 f8 77 10 	movl   $0x801077f8,0x4(%esp)
801043e1:	80 
801043e2:	8d 43 04             	lea    0x4(%ebx),%eax
801043e5:	89 04 24             	mov    %eax,(%esp)
801043e8:	e8 23 00 00 00       	call   80104410 <initlock>
  lk->name = name;
801043ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043f0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043f6:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801043fd:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80104400:	83 c4 14             	add    $0x14,%esp
80104403:	5b                   	pop    %ebx
80104404:	5d                   	pop    %ebp
80104405:	c3                   	ret    
	...

80104410 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104416:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104419:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010441f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104422:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104429:	5d                   	pop    %ebp
8010442a:	c3                   	ret    
8010442b:	90                   	nop
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104430 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104430:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104431:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104433:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104435:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104438:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010443b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010443c:	83 ea 08             	sub    $0x8,%edx
8010443f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104440:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104446:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010444c:	77 1a                	ja     80104468 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010444e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104451:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104454:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104457:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104459:	83 f8 0a             	cmp    $0xa,%eax
8010445c:	75 e2                	jne    80104440 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010445e:	5b                   	pop    %ebx
8010445f:	5d                   	pop    %ebp
80104460:	c3                   	ret    
80104461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104468:	83 f8 09             	cmp    $0x9,%eax
8010446b:	7f f1                	jg     8010445e <getcallerpcs+0x2e>
8010446d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104470:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104477:	83 c0 01             	add    $0x1,%eax
8010447a:	83 f8 0a             	cmp    $0xa,%eax
8010447d:	75 f1                	jne    80104470 <getcallerpcs+0x40>
    pcs[i] = 0;
}
8010447f:	5b                   	pop    %ebx
80104480:	5d                   	pop    %ebp
80104481:	c3                   	ret    
80104482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104490:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
80104491:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104493:	89 e5                	mov    %esp,%ebp
80104495:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104498:	8b 0a                	mov    (%edx),%ecx
8010449a:	85 c9                	test   %ecx,%ecx
8010449c:	74 10                	je     801044ae <holding+0x1e>
8010449e:	8b 42 08             	mov    0x8(%edx),%eax
801044a1:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
801044a8:	0f 94 c0             	sete   %al
801044ab:	0f b6 c0             	movzbl %al,%eax
}
801044ae:	5d                   	pop    %ebp
801044af:	c3                   	ret    

801044b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044b3:	9c                   	pushf  
801044b4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801044b5:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801044b6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801044bc:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801044c2:	85 d2                	test   %edx,%edx
801044c4:	75 18                	jne    801044de <pushcli+0x2e>
    cpu->intena = eflags & FL_IF;
801044c6:	81 e1 00 02 00 00    	and    $0x200,%ecx
801044cc:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
801044d2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801044d8:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  cpu->ncli += 1;
801044de:	83 c2 01             	add    $0x1,%edx
801044e1:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
801044e7:	5d                   	pop    %ebp
801044e8:	c3                   	ret    
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044f0 <popcli>:

void
popcli(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044f6:	9c                   	pushf  
801044f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044f8:	f6 c4 02             	test   $0x2,%ah
801044fb:	75 43                	jne    80104540 <popcli+0x50>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801044fd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104504:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
8010450a:	83 e8 01             	sub    $0x1,%eax
8010450d:	85 c0                	test   %eax,%eax
8010450f:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
80104515:	78 1d                	js     80104534 <popcli+0x44>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104517:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010451d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104523:	85 d2                	test   %edx,%edx
80104525:	75 0b                	jne    80104532 <popcli+0x42>
80104527:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010452d:	85 c0                	test   %eax,%eax
8010452f:	74 01                	je     80104532 <popcli+0x42>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104531:	fb                   	sti    
    sti();
}
80104532:	c9                   	leave  
80104533:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
80104534:	c7 04 24 1a 78 10 80 	movl   $0x8010781a,(%esp)
8010453b:	e8 90 be ff ff       	call   801003d0 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104540:	c7 04 24 03 78 10 80 	movl   $0x80107803,(%esp)
80104547:	e8 84 be ff ff       	call   801003d0 <panic>
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104550 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	83 ec 18             	sub    $0x18,%esp
80104556:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104559:	8b 08                	mov    (%eax),%ecx
8010455b:	85 c9                	test   %ecx,%ecx
8010455d:	74 0c                	je     8010456b <release+0x1b>
8010455f:	8b 50 08             	mov    0x8(%eax),%edx
80104562:	65 3b 15 00 00 00 00 	cmp    %gs:0x0,%edx
80104569:	74 0d                	je     80104578 <release+0x28>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010456b:	c7 04 24 21 78 10 80 	movl   $0x80107821,(%esp)
80104572:	e8 59 be ff ff       	call   801003d0 <panic>
80104577:	90                   	nop

  lk->pcs[0] = 0;
80104578:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
8010457f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104586:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010458b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104591:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104592:	e9 59 ff ff ff       	jmp    801044f0 <popcli>
80104597:	89 f6                	mov    %esi,%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045a6:	9c                   	pushf  
801045a7:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801045a8:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801045a9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801045af:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801045b5:	85 d2                	test   %edx,%edx
801045b7:	75 18                	jne    801045d1 <acquire+0x31>
    cpu->intena = eflags & FL_IF;
801045b9:	81 e1 00 02 00 00    	and    $0x200,%ecx
801045bf:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
801045c5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801045cb:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  cpu->ncli += 1;
801045d1:	83 c2 01             	add    $0x1,%edx
801045d4:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
801045da:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801045dd:	8b 02                	mov    (%edx),%eax
801045df:	85 c0                	test   %eax,%eax
801045e1:	74 0c                	je     801045ef <acquire+0x4f>
801045e3:	8b 42 08             	mov    0x8(%edx),%eax
801045e6:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
801045ed:	74 41                	je     80104630 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801045ef:	b9 01 00 00 00       	mov    $0x1,%ecx
801045f4:	eb 05                	jmp    801045fb <acquire+0x5b>
801045f6:	66 90                	xchg   %ax,%ax
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801045f8:	8b 55 08             	mov    0x8(%ebp),%edx
801045fb:	89 c8                	mov    %ecx,%eax
801045fd:	f0 87 02             	lock xchg %eax,(%edx)
80104600:	85 c0                	test   %eax,%eax
80104602:	75 f4                	jne    801045f8 <acquire+0x58>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104604:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104609:	8b 45 08             	mov    0x8(%ebp),%eax
8010460c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104613:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104616:	8b 45 08             	mov    0x8(%ebp),%eax
80104619:	83 c0 0c             	add    $0xc,%eax
8010461c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104620:	8d 45 08             	lea    0x8(%ebp),%eax
80104623:	89 04 24             	mov    %eax,(%esp)
80104626:	e8 05 fe ff ff       	call   80104430 <getcallerpcs>
}
8010462b:	c9                   	leave  
8010462c:	c3                   	ret    
8010462d:	8d 76 00             	lea    0x0(%esi),%esi
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104630:	c7 04 24 29 78 10 80 	movl   $0x80107829,(%esp)
80104637:	e8 94 bd ff ff       	call   801003d0 <panic>
8010463c:	00 00                	add    %al,(%eax)
	...

80104640 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 08             	sub    $0x8,%esp
80104646:	8b 55 08             	mov    0x8(%ebp),%edx
80104649:	89 1c 24             	mov    %ebx,(%esp)
8010464c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010464f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104653:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104656:	f6 c2 03             	test   $0x3,%dl
80104659:	75 05                	jne    80104660 <memset+0x20>
8010465b:	f6 c1 03             	test   $0x3,%cl
8010465e:	74 18                	je     80104678 <memset+0x38>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104660:	89 d7                	mov    %edx,%edi
80104662:	fc                   	cld    
80104663:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104665:	89 d0                	mov    %edx,%eax
80104667:	8b 1c 24             	mov    (%esp),%ebx
8010466a:	8b 7c 24 04          	mov    0x4(%esp),%edi
8010466e:	89 ec                	mov    %ebp,%esp
80104670:	5d                   	pop    %ebp
80104671:	c3                   	ret    
80104672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104678:	0f b6 f8             	movzbl %al,%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010467b:	89 f8                	mov    %edi,%eax
8010467d:	89 fb                	mov    %edi,%ebx
8010467f:	c1 e0 18             	shl    $0x18,%eax
80104682:	c1 e3 10             	shl    $0x10,%ebx
80104685:	09 d8                	or     %ebx,%eax
80104687:	09 f8                	or     %edi,%eax
80104689:	c1 e7 08             	shl    $0x8,%edi
8010468c:	09 f8                	or     %edi,%eax
8010468e:	89 d7                	mov    %edx,%edi
80104690:	c1 e9 02             	shr    $0x2,%ecx
80104693:	fc                   	cld    
80104694:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104696:	89 d0                	mov    %edx,%eax
80104698:	8b 1c 24             	mov    (%esp),%ebx
8010469b:	8b 7c 24 04          	mov    0x4(%esp),%edi
8010469f:	89 ec                	mov    %ebp,%esp
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	8b 55 10             	mov    0x10(%ebp),%edx
801046b6:	57                   	push   %edi
801046b7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801046ba:	56                   	push   %esi
801046bb:	8b 75 08             	mov    0x8(%ebp),%esi
801046be:	53                   	push   %ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046bf:	85 d2                	test   %edx,%edx
801046c1:	74 2d                	je     801046f0 <memcmp+0x40>
    if(*s1 != *s2)
801046c3:	0f b6 1e             	movzbl (%esi),%ebx
801046c6:	0f b6 0f             	movzbl (%edi),%ecx
801046c9:	38 cb                	cmp    %cl,%bl
801046cb:	75 2b                	jne    801046f8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046cd:	83 ea 01             	sub    $0x1,%edx
801046d0:	31 c0                	xor    %eax,%eax
801046d2:	eb 18                	jmp    801046ec <memcmp+0x3c>
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s1 != *s2)
801046d8:	0f b6 5c 06 01       	movzbl 0x1(%esi,%eax,1),%ebx
801046dd:	83 ea 01             	sub    $0x1,%edx
801046e0:	0f b6 4c 07 01       	movzbl 0x1(%edi,%eax,1),%ecx
801046e5:	83 c0 01             	add    $0x1,%eax
801046e8:	38 cb                	cmp    %cl,%bl
801046ea:	75 0c                	jne    801046f8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046ec:	85 d2                	test   %edx,%edx
801046ee:	75 e8                	jne    801046d8 <memcmp+0x28>
801046f0:	31 c0                	xor    %eax,%eax
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046f2:	5b                   	pop    %ebx
801046f3:	5e                   	pop    %esi
801046f4:	5f                   	pop    %edi
801046f5:	5d                   	pop    %ebp
801046f6:	c3                   	ret    
801046f7:	90                   	nop

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046f8:	0f b6 c3             	movzbl %bl,%eax
801046fb:	0f b6 c9             	movzbl %cl,%ecx
801046fe:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80104700:	5b                   	pop    %ebx
80104701:	5e                   	pop    %esi
80104702:	5f                   	pop    %edi
80104703:	5d                   	pop    %ebp
80104704:	c3                   	ret    
80104705:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	57                   	push   %edi
80104714:	8b 45 08             	mov    0x8(%ebp),%eax
80104717:	56                   	push   %esi
80104718:	8b 75 0c             	mov    0xc(%ebp),%esi
8010471b:	53                   	push   %ebx
8010471c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010471f:	39 c6                	cmp    %eax,%esi
80104721:	73 2d                	jae    80104750 <memmove+0x40>
80104723:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
80104726:	39 f8                	cmp    %edi,%eax
80104728:	73 26                	jae    80104750 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
8010472a:	85 db                	test   %ebx,%ebx
8010472c:	74 1d                	je     8010474b <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
8010472e:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80104731:	31 d2                	xor    %edx,%edx
80104733:	90                   	nop
80104734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
80104738:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
8010473d:	88 4c 16 ff          	mov    %cl,-0x1(%esi,%edx,1)
80104741:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104744:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80104747:	85 c9                	test   %ecx,%ecx
80104749:	75 ed                	jne    80104738 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010474b:	5b                   	pop    %ebx
8010474c:	5e                   	pop    %esi
8010474d:	5f                   	pop    %edi
8010474e:	5d                   	pop    %ebp
8010474f:	c3                   	ret    
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104750:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
80104752:	85 db                	test   %ebx,%ebx
80104754:	74 f5                	je     8010474b <memmove+0x3b>
80104756:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104758:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
8010475c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
8010475f:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104762:	39 d3                	cmp    %edx,%ebx
80104764:	75 f2                	jne    80104758 <memmove+0x48>
      *d++ = *s++;

  return dst;
}
80104766:	5b                   	pop    %ebx
80104767:	5e                   	pop    %esi
80104768:	5f                   	pop    %edi
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	90                   	nop
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104770 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104773:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104774:	e9 97 ff ff ff       	jmp    80104710 <memmove>
80104779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104780 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	57                   	push   %edi
80104784:	8b 7d 10             	mov    0x10(%ebp),%edi
80104787:	56                   	push   %esi
80104788:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010478b:	53                   	push   %ebx
8010478c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010478f:	85 ff                	test   %edi,%edi
80104791:	74 3d                	je     801047d0 <strncmp+0x50>
80104793:	0f b6 01             	movzbl (%ecx),%eax
80104796:	84 c0                	test   %al,%al
80104798:	75 18                	jne    801047b2 <strncmp+0x32>
8010479a:	eb 3c                	jmp    801047d8 <strncmp+0x58>
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047a0:	83 ef 01             	sub    $0x1,%edi
801047a3:	74 2b                	je     801047d0 <strncmp+0x50>
    n--, p++, q++;
801047a5:	83 c1 01             	add    $0x1,%ecx
801047a8:	83 c3 01             	add    $0x1,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047ab:	0f b6 01             	movzbl (%ecx),%eax
801047ae:	84 c0                	test   %al,%al
801047b0:	74 26                	je     801047d8 <strncmp+0x58>
801047b2:	0f b6 33             	movzbl (%ebx),%esi
801047b5:	89 f2                	mov    %esi,%edx
801047b7:	38 d0                	cmp    %dl,%al
801047b9:	74 e5                	je     801047a0 <strncmp+0x20>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801047bb:	81 e6 ff 00 00 00    	and    $0xff,%esi
801047c1:	0f b6 c0             	movzbl %al,%eax
801047c4:	29 f0                	sub    %esi,%eax
}
801047c6:	5b                   	pop    %ebx
801047c7:	5e                   	pop    %esi
801047c8:	5f                   	pop    %edi
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    
801047cb:	90                   	nop
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047d0:	31 c0                	xor    %eax,%eax
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047d2:	5b                   	pop    %ebx
801047d3:	5e                   	pop    %esi
801047d4:	5f                   	pop    %edi
801047d5:	5d                   	pop    %ebp
801047d6:	c3                   	ret    
801047d7:	90                   	nop
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047d8:	0f b6 33             	movzbl (%ebx),%esi
801047db:	eb de                	jmp    801047bb <strncmp+0x3b>
801047dd:	8d 76 00             	lea    0x0(%esi),%esi

801047e0 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	8b 45 08             	mov    0x8(%ebp),%eax
801047e6:	56                   	push   %esi
801047e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047ea:	53                   	push   %ebx
801047eb:	8b 75 0c             	mov    0xc(%ebp),%esi
801047ee:	89 c3                	mov    %eax,%ebx
801047f0:	eb 09                	jmp    801047fb <strncpy+0x1b>
801047f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047f8:	83 c6 01             	add    $0x1,%esi
801047fb:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801047fe:	8d 51 01             	lea    0x1(%ecx),%edx
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104801:	85 d2                	test   %edx,%edx
80104803:	7e 0c                	jle    80104811 <strncpy+0x31>
80104805:	0f b6 16             	movzbl (%esi),%edx
80104808:	88 13                	mov    %dl,(%ebx)
8010480a:	83 c3 01             	add    $0x1,%ebx
8010480d:	84 d2                	test   %dl,%dl
8010480f:	75 e7                	jne    801047f8 <strncpy+0x18>
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
80104811:	31 d2                	xor    %edx,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104813:	85 c9                	test   %ecx,%ecx
80104815:	7e 0c                	jle    80104823 <strncpy+0x43>
80104817:	90                   	nop
    *s++ = 0;
80104818:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
8010481c:	83 c2 01             	add    $0x1,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010481f:	39 ca                	cmp    %ecx,%edx
80104821:	75 f5                	jne    80104818 <strncpy+0x38>
    *s++ = 0;
  return os;
}
80104823:	5b                   	pop    %ebx
80104824:	5e                   	pop    %esi
80104825:	5d                   	pop    %ebp
80104826:	c3                   	ret    
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	8b 55 10             	mov    0x10(%ebp),%edx
80104836:	56                   	push   %esi
80104837:	8b 45 08             	mov    0x8(%ebp),%eax
8010483a:	53                   	push   %ebx
8010483b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  if(n <= 0)
8010483e:	85 d2                	test   %edx,%edx
80104840:	7e 1f                	jle    80104861 <safestrcpy+0x31>
80104842:	89 c1                	mov    %eax,%ecx
80104844:	eb 05                	jmp    8010484b <safestrcpy+0x1b>
80104846:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104848:	83 c6 01             	add    $0x1,%esi
8010484b:	83 ea 01             	sub    $0x1,%edx
8010484e:	85 d2                	test   %edx,%edx
80104850:	7e 0c                	jle    8010485e <safestrcpy+0x2e>
80104852:	0f b6 1e             	movzbl (%esi),%ebx
80104855:	88 19                	mov    %bl,(%ecx)
80104857:	83 c1 01             	add    $0x1,%ecx
8010485a:	84 db                	test   %bl,%bl
8010485c:	75 ea                	jne    80104848 <safestrcpy+0x18>
    ;
  *s = 0;
8010485e:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104861:	5b                   	pop    %ebx
80104862:	5e                   	pop    %esi
80104863:	5d                   	pop    %ebp
80104864:	c3                   	ret    
80104865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <strlen>:

int
strlen(const char *s)
{
80104870:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104871:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104873:	89 e5                	mov    %esp,%ebp
80104875:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104878:	80 3a 00             	cmpb   $0x0,(%edx)
8010487b:	74 0c                	je     80104889 <strlen+0x19>
8010487d:	8d 76 00             	lea    0x0(%esi),%esi
80104880:	83 c0 01             	add    $0x1,%eax
80104883:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104887:	75 f7                	jne    80104880 <strlen+0x10>
    ;
  return n;
}
80104889:	5d                   	pop    %ebp
8010488a:	c3                   	ret    
	...

8010488c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010488c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104890:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104894:	55                   	push   %ebp
  pushl %ebx
80104895:	53                   	push   %ebx
  pushl %esi
80104896:	56                   	push   %esi
  pushl %edi
80104897:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104898:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010489a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010489c:	5f                   	pop    %edi
  popl %esi
8010489d:	5e                   	pop    %esi
  popl %ebx
8010489e:	5b                   	pop    %ebx
  popl %ebp
8010489f:	5d                   	pop    %ebp
  ret
801048a0:	c3                   	ret    
	...

801048b0 <fetchint>:

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048b0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048b7:	55                   	push   %ebp
801048b8:	89 e5                	mov    %esp,%ebp
801048ba:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
801048bd:	8b 12                	mov    (%edx),%edx
801048bf:	39 c2                	cmp    %eax,%edx
801048c1:	77 0d                	ja     801048d0 <fetchint+0x20>
    return -1;
  *ip = *(int*)(addr);
  return 0;
801048c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048d0:	8d 48 04             	lea    0x4(%eax),%ecx
801048d3:	39 ca                	cmp    %ecx,%edx
801048d5:	72 ec                	jb     801048c3 <fetchint+0x13>
    return -1;
  *ip = *(int*)(addr);
801048d7:	8b 10                	mov    (%eax),%edx
801048d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801048dc:	89 10                	mov    %edx,(%eax)
801048de:	31 c0                	xor    %eax,%eax
  return 0;
}
801048e0:	5d                   	pop    %ebp
801048e1:	c3                   	ret    
801048e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048f0 <fetchstr>:
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
801048f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048f6:	55                   	push   %ebp
801048f7:	89 e5                	mov    %esp,%ebp
801048f9:	8b 55 08             	mov    0x8(%ebp),%edx
801048fc:	53                   	push   %ebx
  char *s, *ep;

  if(addr >= proc->sz)
801048fd:	39 10                	cmp    %edx,(%eax)
801048ff:	77 0f                	ja     80104910 <fetchstr+0x20>
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104901:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
80104906:	5b                   	pop    %ebx
80104907:	5d                   	pop    %ebp
80104908:	c3                   	ret    
80104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
80104910:	8b 45 0c             	mov    0xc(%ebp),%eax
80104913:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80104915:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010491b:	8b 18                	mov    (%eax),%ebx
  for(s = *pp; s < ep; s++)
8010491d:	39 da                	cmp    %ebx,%edx
8010491f:	73 e0                	jae    80104901 <fetchstr+0x11>
    if(*s == 0)
80104921:	31 c0                	xor    %eax,%eax
80104923:	89 d1                	mov    %edx,%ecx
80104925:	80 3a 00             	cmpb   $0x0,(%edx)
80104928:	74 dc                	je     80104906 <fetchstr+0x16>
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104930:	83 c1 01             	add    $0x1,%ecx
80104933:	39 cb                	cmp    %ecx,%ebx
80104935:	76 ca                	jbe    80104901 <fetchstr+0x11>
    if(*s == 0)
80104937:	80 39 00             	cmpb   $0x0,(%ecx)
8010493a:	75 f4                	jne    80104930 <fetchstr+0x40>
8010493c:	89 c8                	mov    %ecx,%eax
8010493e:	29 d0                	sub    %edx,%eax
80104940:	eb c4                	jmp    80104906 <fetchstr+0x16>
80104942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104950:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104956:	55                   	push   %ebp
80104957:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104959:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010495c:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010495f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104961:	8b 52 44             	mov    0x44(%edx),%edx
80104964:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104968:	39 c2                	cmp    %eax,%edx
8010496a:	72 0c                	jb     80104978 <argint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010496c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104971:	5d                   	pop    %ebp
80104972:	c3                   	ret    
80104973:	90                   	nop
80104974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104978:	8d 4a 04             	lea    0x4(%edx),%ecx
8010497b:	39 c8                	cmp    %ecx,%eax
8010497d:	72 ed                	jb     8010496c <argint+0x1c>
    return -1;
  *ip = *(int*)(addr);
8010497f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104982:	8b 12                	mov    (%edx),%edx
80104984:	89 10                	mov    %edx,(%eax)
80104986:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104988:	5d                   	pop    %ebp
80104989:	c3                   	ret    
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104990 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104990:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104996:	55                   	push   %ebp
80104997:	89 e5                	mov    %esp,%ebp
80104999:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010499a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010499d:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801049a0:	8b 00                	mov    (%eax),%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049a2:	8b 5d 10             	mov    0x10(%ebp),%ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049a5:	8b 52 44             	mov    0x44(%edx),%edx
801049a8:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801049ac:	39 c2                	cmp    %eax,%edx
801049ae:	73 07                	jae    801049b7 <argptr+0x27>
801049b0:	8d 4a 04             	lea    0x4(%edx),%ecx
801049b3:	39 c8                	cmp    %ecx,%eax
801049b5:	73 09                	jae    801049c0 <argptr+0x30>
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
801049b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049bc:	5b                   	pop    %ebx
801049bd:	5d                   	pop    %ebp
801049be:	c3                   	ret    
801049bf:	90                   	nop
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801049c0:	85 db                	test   %ebx,%ebx
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801049c2:	8b 12                	mov    (%edx),%edx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801049c4:	78 f1                	js     801049b7 <argptr+0x27>
801049c6:	39 c2                	cmp    %eax,%edx
801049c8:	73 ed                	jae    801049b7 <argptr+0x27>
801049ca:	8d 1c 1a             	lea    (%edx,%ebx,1),%ebx
801049cd:	39 c3                	cmp    %eax,%ebx
801049cf:	77 e6                	ja     801049b7 <argptr+0x27>
    return -1;
  *pp = (char*)i;
801049d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801049d4:	89 10                	mov    %edx,(%eax)
801049d6:	31 c0                	xor    %eax,%eax
  return 0;
801049d8:	eb e2                	jmp    801049bc <argptr+0x2c>
801049da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049e0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049e6:	55                   	push   %ebp
801049e7:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049ec:	8b 50 18             	mov    0x18(%eax),%edx
801049ef:	8b 52 44             	mov    0x44(%edx),%edx
801049f2:	8d 4c 8a 04          	lea    0x4(%edx,%ecx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801049f6:	8b 10                	mov    (%eax),%edx
801049f8:	39 d1                	cmp    %edx,%ecx
801049fa:	73 07                	jae    80104a03 <argstr+0x23>
801049fc:	8d 41 04             	lea    0x4(%ecx),%eax
801049ff:	39 c2                	cmp    %eax,%edx
80104a01:	73 0d                	jae    80104a10 <argstr+0x30>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104a03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104a08:	5d                   	pop    %ebp
80104a09:	c3                   	ret    
80104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104a10:	8b 09                	mov    (%ecx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104a12:	39 d1                	cmp    %edx,%ecx
80104a14:	73 ed                	jae    80104a03 <argstr+0x23>
    return -1;
  *pp = (char*)addr;
80104a16:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a19:	89 c8                	mov    %ecx,%eax
80104a1b:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104a1d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a24:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104a26:	39 d1                	cmp    %edx,%ecx
80104a28:	73 d9                	jae    80104a03 <argstr+0x23>
    if(*s == 0)
80104a2a:	80 39 00             	cmpb   $0x0,(%ecx)
80104a2d:	75 13                	jne    80104a42 <argstr+0x62>
80104a2f:	eb 1f                	jmp    80104a50 <argstr+0x70>
80104a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a38:	80 38 00             	cmpb   $0x0,(%eax)
80104a3b:	90                   	nop
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a40:	74 0e                	je     80104a50 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104a42:	83 c0 01             	add    $0x1,%eax
80104a45:	39 c2                	cmp    %eax,%edx
80104a47:	77 ef                	ja     80104a38 <argstr+0x58>
80104a49:	eb b8                	jmp    80104a03 <argstr+0x23>
80104a4b:	90                   	nop
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
      return s - *pp;
80104a50:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104a52:	5d                   	pop    %ebp
80104a53:	c3                   	ret    
80104a54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a60 <syscall>:
[SYS_setpriority] sys_setpriority,	//lab 1 part2
};

void
syscall(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80104a67:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a6e:	8b 5a 18             	mov    0x18(%edx),%ebx
80104a71:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a74:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104a77:	83 f9 17             	cmp    $0x17,%ecx
80104a7a:	77 1c                	ja     80104a98 <syscall+0x38>
80104a7c:	8b 0c 85 60 78 10 80 	mov    -0x7fef87a0(,%eax,4),%ecx
80104a83:	85 c9                	test   %ecx,%ecx
80104a85:	74 11                	je     80104a98 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
80104a87:	ff d1                	call   *%ecx
80104a89:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104a8c:	83 c4 14             	add    $0x14,%esp
80104a8f:	5b                   	pop    %ebx
80104a90:	5d                   	pop    %ebp
80104a91:	c3                   	ret    
80104a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a98:	89 44 24 0c          	mov    %eax,0xc(%esp)
80104a9c:	8d 42 6c             	lea    0x6c(%edx),%eax
80104a9f:	89 44 24 08          	mov    %eax,0x8(%esp)
80104aa3:	8b 42 10             	mov    0x10(%edx),%eax
80104aa6:	c7 04 24 31 78 10 80 	movl   $0x80107831,(%esp)
80104aad:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ab1:	e8 ba bd ff ff       	call   80100870 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80104ab6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104abc:	8b 40 18             	mov    0x18(%eax),%eax
80104abf:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104ac6:	83 c4 14             	add    $0x14,%esp
80104ac9:	5b                   	pop    %ebx
80104aca:	5d                   	pop    %ebp
80104acb:	c3                   	ret    
80104acc:	00 00                	add    %al,(%eax)
	...

80104ad0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104ad6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80104ad9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104adc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104adf:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80104ae6:	00 
80104ae7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104aeb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104af2:	e8 99 fe ff ff       	call   80104990 <argptr>
80104af7:	85 c0                	test   %eax,%eax
80104af9:	79 15                	jns    80104b10 <sys_pipe+0x40>
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80104afb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80104b00:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104b03:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104b06:	89 ec                	mov    %ebp,%esp
80104b08:	5d                   	pop    %ebp
80104b09:	c3                   	ret    
80104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104b10:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b1a:	89 04 24             	mov    %eax,(%esp)
80104b1d:	e8 0e eb ff ff       	call   80103630 <pipealloc>
80104b22:	85 c0                	test   %eax,%eax
80104b24:	78 d5                	js     80104afb <sys_pipe+0x2b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104b26:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104b29:	31 c0                	xor    %eax,%eax
80104b2b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104b38:	8b 5c 82 28          	mov    0x28(%edx,%eax,4),%ebx
80104b3c:	85 db                	test   %ebx,%ebx
80104b3e:	74 28                	je     80104b68 <sys_pipe+0x98>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b40:	83 c0 01             	add    $0x1,%eax
80104b43:	83 f8 10             	cmp    $0x10,%eax
80104b46:	75 f0                	jne    80104b38 <sys_pipe+0x68>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80104b48:	89 0c 24             	mov    %ecx,(%esp)
80104b4b:	e8 20 c5 ff ff       	call   80101070 <fileclose>
    fileclose(wf);
80104b50:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b53:	89 04 24             	mov    %eax,(%esp)
80104b56:	e8 15 c5 ff ff       	call   80101070 <fileclose>
80104b5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
80104b60:	eb 9e                	jmp    80104b00 <sys_pipe+0x30>
80104b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104b68:	8d 58 08             	lea    0x8(%eax),%ebx
80104b6b:	89 4c 9a 08          	mov    %ecx,0x8(%edx,%ebx,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104b6f:	8b 75 ec             	mov    -0x14(%ebp),%esi
80104b72:	31 d2                	xor    %edx,%edx
80104b74:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80104b7b:	90                   	nop
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104b80:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80104b85:	74 19                	je     80104ba0 <sys_pipe+0xd0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b87:	83 c2 01             	add    $0x1,%edx
80104b8a:	83 fa 10             	cmp    $0x10,%edx
80104b8d:	75 f1                	jne    80104b80 <sys_pipe+0xb0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
80104b8f:	c7 44 99 08 00 00 00 	movl   $0x0,0x8(%ecx,%ebx,4)
80104b96:	00 
80104b97:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104b9a:	eb ac                	jmp    80104b48 <sys_pipe+0x78>
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104ba0:	89 74 91 28          	mov    %esi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104ba4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104ba7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80104ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bac:	89 50 04             	mov    %edx,0x4(%eax)
80104baf:	31 c0                	xor    %eax,%eax
  return 0;
80104bb1:	e9 4a ff ff ff       	jmp    80104b00 <sys_pipe+0x30>
80104bb6:	8d 76 00             	lea    0x0(%esi),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bc0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	81 ec b8 00 00 00    	sub    $0xb8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104bc9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
80104bcc:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104bcf:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104bd2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104bd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bd9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104be0:	e8 fb fd ff ff       	call   801049e0 <argstr>
80104be5:	85 c0                	test   %eax,%eax
80104be7:	79 17                	jns    80104c00 <sys_exec+0x40>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
80104be9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80104bee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104bf1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104bf4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104bf7:	89 ec                	mov    %ebp,%esp
80104bf9:	5d                   	pop    %ebp
80104bfa:	c3                   	ret    
80104bfb:	90                   	nop
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104c00:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104c03:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c07:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c0e:	e8 3d fd ff ff       	call   80104950 <argint>
80104c13:	85 c0                	test   %eax,%eax
80104c15:	78 d2                	js     80104be9 <sys_exec+0x29>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104c17:	8d bd 5c ff ff ff    	lea    -0xa4(%ebp),%edi
80104c1d:	31 f6                	xor    %esi,%esi
80104c1f:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80104c26:	00 
80104c27:	31 db                	xor    %ebx,%ebx
80104c29:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104c30:	00 
80104c31:	89 3c 24             	mov    %edi,(%esp)
80104c34:	e8 07 fa ff ff       	call   80104640 <memset>
80104c39:	eb 22                	jmp    80104c5d <sys_exec+0x9d>
80104c3b:	90                   	nop
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104c40:	8d 14 b7             	lea    (%edi,%esi,4),%edx
80104c43:	89 54 24 04          	mov    %edx,0x4(%esp)
80104c47:	89 04 24             	mov    %eax,(%esp)
80104c4a:	e8 a1 fc ff ff       	call   801048f0 <fetchstr>
80104c4f:	85 c0                	test   %eax,%eax
80104c51:	78 96                	js     80104be9 <sys_exec+0x29>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104c53:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80104c56:	83 fb 20             	cmp    $0x20,%ebx

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104c59:	89 de                	mov    %ebx,%esi
    if(i >= NELEM(argv))
80104c5b:	74 8c                	je     80104be9 <sys_exec+0x29>
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104c5d:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104c60:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c64:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
80104c6b:	03 45 e0             	add    -0x20(%ebp),%eax
80104c6e:	89 04 24             	mov    %eax,(%esp)
80104c71:	e8 3a fc ff ff       	call   801048b0 <fetchint>
80104c76:	85 c0                	test   %eax,%eax
80104c78:	0f 88 6b ff ff ff    	js     80104be9 <sys_exec+0x29>
      return -1;
    if(uarg == 0){
80104c7e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104c81:	85 c0                	test   %eax,%eax
80104c83:	75 bb                	jne    80104c40 <sys_exec+0x80>
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104c85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80104c88:	c7 84 9d 5c ff ff ff 	movl   $0x0,-0xa4(%ebp,%ebx,4)
80104c8f:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104c93:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c97:	89 04 24             	mov    %eax,(%esp)
80104c9a:	e8 41 bd ff ff       	call   801009e0 <exec>
80104c9f:	e9 4a ff ff ff       	jmp    80104bee <sys_exec+0x2e>
80104ca4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104caa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cb0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	53                   	push   %ebx
80104cb4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104cb7:	e8 04 e1 ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104cbc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cbf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cc3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104cca:	e8 11 fd ff ff       	call   801049e0 <argstr>
80104ccf:	85 c0                	test   %eax,%eax
80104cd1:	78 5d                	js     80104d30 <sys_chdir+0x80>
80104cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd6:	89 04 24             	mov    %eax,(%esp)
80104cd9:	e8 f2 d1 ff ff       	call   80101ed0 <namei>
80104cde:	85 c0                	test   %eax,%eax
80104ce0:	89 c3                	mov    %eax,%ebx
80104ce2:	74 4c                	je     80104d30 <sys_chdir+0x80>
    end_op();
    return -1;
  }
  ilock(ip);
80104ce4:	89 04 24             	mov    %eax,(%esp)
80104ce7:	e8 84 cf ff ff       	call   80101c70 <ilock>
  if(ip->type != T_DIR){
80104cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104cf1:	75 35                	jne    80104d28 <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104cf3:	89 1c 24             	mov    %ebx,(%esp)
80104cf6:	e8 05 cf ff ff       	call   80101c00 <iunlock>
  iput(proc->cwd);
80104cfb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d01:	8b 40 68             	mov    0x68(%eax),%eax
80104d04:	89 04 24             	mov    %eax,(%esp)
80104d07:	e8 34 c7 ff ff       	call   80101440 <iput>
  end_op();
80104d0c:	e8 7f df ff ff       	call   80102c90 <end_op>
  proc->cwd = ip;
80104d11:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d17:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
}
80104d1a:	83 c4 24             	add    $0x24,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
80104d1d:	31 c0                	xor    %eax,%eax
  return 0;
}
80104d1f:	5b                   	pop    %ebx
80104d20:	5d                   	pop    %ebp
80104d21:	c3                   	ret    
80104d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80104d28:	89 1c 24             	mov    %ebx,(%esp)
80104d2b:	e8 20 cf ff ff       	call   80101c50 <iunlockput>
    end_op();
80104d30:	e8 5b df ff ff       	call   80102c90 <end_op>
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
80104d35:	83 c4 24             	add    $0x24,%esp
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
80104d38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
80104d3d:	5b                   	pop    %ebx
80104d3e:	5d                   	pop    %ebp
80104d3f:	c3                   	ret    

80104d40 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	83 ec 58             	sub    $0x58,%esp
80104d46:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
80104d49:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d4c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d4f:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d52:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d55:	31 db                	xor    %ebx,%ebx
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d57:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104d5a:	89 d7                	mov    %edx,%edi
80104d5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d5f:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d63:	89 04 24             	mov    %eax,(%esp)
80104d66:	e8 45 d1 ff ff       	call   80101eb0 <nameiparent>
80104d6b:	85 c0                	test   %eax,%eax
80104d6d:	74 47                	je     80104db6 <create+0x76>
    return 0;
  ilock(dp);
80104d6f:	89 04 24             	mov    %eax,(%esp)
80104d72:	89 45 bc             	mov    %eax,-0x44(%ebp)
80104d75:	e8 f6 ce ff ff       	call   80101c70 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104d7a:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104d7d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104d80:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d84:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d88:	89 14 24             	mov    %edx,(%esp)
80104d8b:	e8 00 cc ff ff       	call   80101990 <dirlookup>
80104d90:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104d93:	85 c0                	test   %eax,%eax
80104d95:	89 c3                	mov    %eax,%ebx
80104d97:	74 4f                	je     80104de8 <create+0xa8>
    iunlockput(dp);
80104d99:	89 14 24             	mov    %edx,(%esp)
80104d9c:	e8 af ce ff ff       	call   80101c50 <iunlockput>
    ilock(ip);
80104da1:	89 1c 24             	mov    %ebx,(%esp)
80104da4:	e8 c7 ce ff ff       	call   80101c70 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104da9:	66 83 ff 02          	cmp    $0x2,%di
80104dad:	75 19                	jne    80104dc8 <create+0x88>
80104daf:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104db4:	75 12                	jne    80104dc8 <create+0x88>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104db6:	89 d8                	mov    %ebx,%eax
80104db8:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104dbb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104dbe:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104dc1:	89 ec                	mov    %ebp,%esp
80104dc3:	5d                   	pop    %ebp
80104dc4:	c3                   	ret    
80104dc5:	8d 76 00             	lea    0x0(%esi),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104dc8:	89 1c 24             	mov    %ebx,(%esp)
80104dcb:	31 db                	xor    %ebx,%ebx
80104dcd:	e8 7e ce ff ff       	call   80101c50 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104dd2:	89 d8                	mov    %ebx,%eax
80104dd4:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104dd7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104dda:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104ddd:	89 ec                	mov    %ebp,%esp
80104ddf:	5d                   	pop    %ebp
80104de0:	c3                   	ret    
80104de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104de8:	0f bf c7             	movswl %di,%eax
80104deb:	89 44 24 04          	mov    %eax,0x4(%esp)
80104def:	8b 02                	mov    (%edx),%eax
80104df1:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104df4:	89 04 24             	mov    %eax,(%esp)
80104df7:	e8 34 cd ff ff       	call   80101b30 <ialloc>
80104dfc:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104dff:	85 c0                	test   %eax,%eax
80104e01:	89 c3                	mov    %eax,%ebx
80104e03:	0f 84 cb 00 00 00    	je     80104ed4 <create+0x194>
    panic("create: ialloc");

  ilock(ip);
80104e09:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104e0c:	89 04 24             	mov    %eax,(%esp)
80104e0f:	e8 5c ce ff ff       	call   80101c70 <ilock>
  ip->major = major;
80104e14:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
80104e18:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104e1c:	0f b7 4d c0          	movzwl -0x40(%ebp),%ecx
  ip->nlink = 1;
80104e20:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
80104e26:	66 89 4b 54          	mov    %cx,0x54(%ebx)
  ip->nlink = 1;
  iupdate(ip);
80104e2a:	89 1c 24             	mov    %ebx,(%esp)
80104e2d:	e8 8e c4 ff ff       	call   801012c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104e32:	66 83 ff 01          	cmp    $0x1,%di
80104e36:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104e39:	74 3d                	je     80104e78 <create+0x138>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104e3b:	8b 43 04             	mov    0x4(%ebx),%eax
80104e3e:	89 14 24             	mov    %edx,(%esp)
80104e41:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104e44:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e48:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e4c:	e8 ef cb ff ff       	call   80101a40 <dirlink>
80104e51:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104e54:	85 c0                	test   %eax,%eax
80104e56:	0f 88 84 00 00 00    	js     80104ee0 <create+0x1a0>
    panic("create: dirlink");

  iunlockput(dp);
80104e5c:	89 14 24             	mov    %edx,(%esp)
80104e5f:	e8 ec cd ff ff       	call   80101c50 <iunlockput>

  return ip;
}
80104e64:	89 d8                	mov    %ebx,%eax
80104e66:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104e69:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104e6c:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104e6f:	89 ec                	mov    %ebp,%esp
80104e71:	5d                   	pop    %ebp
80104e72:	c3                   	ret    
80104e73:	90                   	nop
80104e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104e78:	66 83 42 56 01       	addw   $0x1,0x56(%edx)
    iupdate(dp);
80104e7d:	89 14 24             	mov    %edx,(%esp)
80104e80:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104e83:	e8 38 c4 ff ff       	call   801012c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e88:	8b 43 04             	mov    0x4(%ebx),%eax
80104e8b:	c7 44 24 04 d4 78 10 	movl   $0x801078d4,0x4(%esp)
80104e92:	80 
80104e93:	89 1c 24             	mov    %ebx,(%esp)
80104e96:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e9a:	e8 a1 cb ff ff       	call   80101a40 <dirlink>
80104e9f:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104ea2:	85 c0                	test   %eax,%eax
80104ea4:	78 22                	js     80104ec8 <create+0x188>
80104ea6:	8b 42 04             	mov    0x4(%edx),%eax
80104ea9:	c7 44 24 04 d3 78 10 	movl   $0x801078d3,0x4(%esp)
80104eb0:	80 
80104eb1:	89 1c 24             	mov    %ebx,(%esp)
80104eb4:	89 44 24 08          	mov    %eax,0x8(%esp)
80104eb8:	e8 83 cb ff ff       	call   80101a40 <dirlink>
80104ebd:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	0f 89 73 ff ff ff    	jns    80104e3b <create+0xfb>
      panic("create dots");
80104ec8:	c7 04 24 d6 78 10 80 	movl   $0x801078d6,(%esp)
80104ecf:	e8 fc b4 ff ff       	call   801003d0 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104ed4:	c7 04 24 c4 78 10 80 	movl   $0x801078c4,(%esp)
80104edb:	e8 f0 b4 ff ff       	call   801003d0 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104ee0:	c7 04 24 e2 78 10 80 	movl   $0x801078e2,(%esp)
80104ee7:	e8 e4 b4 ff ff       	call   801003d0 <panic>
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104ef6:	e8 c5 de ff ff       	call   80102dc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104efb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104efe:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f09:	e8 d2 fa ff ff       	call   801049e0 <argstr>
80104f0e:	85 c0                	test   %eax,%eax
80104f10:	78 5e                	js     80104f70 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104f12:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f15:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f20:	e8 2b fa ff ff       	call   80104950 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f25:	85 c0                	test   %eax,%eax
80104f27:	78 47                	js     80104f70 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104f29:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104f2c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f30:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104f37:	e8 14 fa ff ff       	call   80104950 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f3c:	85 c0                	test   %eax,%eax
80104f3e:	78 30                	js     80104f70 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80104f40:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
80104f44:	ba 03 00 00 00       	mov    $0x3,%edx
80104f49:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104f4d:	89 04 24             	mov    %eax,(%esp)
80104f50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f53:	e8 e8 fd ff ff       	call   80104d40 <create>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f58:	85 c0                	test   %eax,%eax
80104f5a:	74 14                	je     80104f70 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
80104f5c:	89 04 24             	mov    %eax,(%esp)
80104f5f:	e8 ec cc ff ff       	call   80101c50 <iunlockput>
  end_op();
80104f64:	e8 27 dd ff ff       	call   80102c90 <end_op>
80104f69:	31 c0                	xor    %eax,%eax
  return 0;
}
80104f6b:	c9                   	leave  
80104f6c:	c3                   	ret    
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80104f70:	e8 1b dd ff ff       	call   80102c90 <end_op>
80104f75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104f7a:	c9                   	leave  
80104f7b:	c3                   	ret    
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f80 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104f86:	e8 35 de ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104f8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f8e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f99:	e8 42 fa ff ff       	call   801049e0 <argstr>
80104f9e:	85 c0                	test   %eax,%eax
80104fa0:	78 2e                	js     80104fd0 <sys_mkdir+0x50>
80104fa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fa5:	31 c9                	xor    %ecx,%ecx
80104fa7:	ba 01 00 00 00       	mov    $0x1,%edx
80104fac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fb3:	e8 88 fd ff ff       	call   80104d40 <create>
80104fb8:	85 c0                	test   %eax,%eax
80104fba:	74 14                	je     80104fd0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104fbc:	89 04 24             	mov    %eax,(%esp)
80104fbf:	e8 8c cc ff ff       	call   80101c50 <iunlockput>
  end_op();
80104fc4:	e8 c7 dc ff ff       	call   80102c90 <end_op>
80104fc9:	31 c0                	xor    %eax,%eax
  return 0;
}
80104fcb:	c9                   	leave  
80104fcc:	c3                   	ret    
80104fcd:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80104fd0:	e8 bb dc ff ff       	call   80102c90 <end_op>
80104fd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104fda:	c9                   	leave  
80104fdb:	c3                   	ret    
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fe0 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	83 ec 48             	sub    $0x48,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fe6:	8d 45 e0             	lea    -0x20(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104fe9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104fec:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104fef:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ff2:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ff6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ffd:	e8 de f9 ff ff       	call   801049e0 <argstr>
80105002:	85 c0                	test   %eax,%eax
80105004:	79 12                	jns    80105018 <sys_link+0x38>
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80105006:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010500b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010500e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105011:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105014:	89 ec                	mov    %ebp,%esp
80105016:	5d                   	pop    %ebp
80105017:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105018:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010501b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010501f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105026:	e8 b5 f9 ff ff       	call   801049e0 <argstr>
8010502b:	85 c0                	test   %eax,%eax
8010502d:	78 d7                	js     80105006 <sys_link+0x26>
    return -1;

  begin_op();
8010502f:	e8 8c dd ff ff       	call   80102dc0 <begin_op>
  if((ip = namei(old)) == 0){
80105034:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105037:	89 04 24             	mov    %eax,(%esp)
8010503a:	e8 91 ce ff ff       	call   80101ed0 <namei>
8010503f:	85 c0                	test   %eax,%eax
80105041:	89 c3                	mov    %eax,%ebx
80105043:	0f 84 a6 00 00 00    	je     801050ef <sys_link+0x10f>
    end_op();
    return -1;
  }

  ilock(ip);
80105049:	89 04 24             	mov    %eax,(%esp)
8010504c:	e8 1f cc ff ff       	call   80101c70 <ilock>
  if(ip->type == T_DIR){
80105051:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105056:	0f 84 8b 00 00 00    	je     801050e7 <sys_link+0x107>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010505c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105061:	8d 7d d2             	lea    -0x2e(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105064:	89 1c 24             	mov    %ebx,(%esp)
80105067:	e8 54 c2 ff ff       	call   801012c0 <iupdate>
  iunlock(ip);
8010506c:	89 1c 24             	mov    %ebx,(%esp)
8010506f:	e8 8c cb ff ff       	call   80101c00 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105074:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105077:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010507b:	89 04 24             	mov    %eax,(%esp)
8010507e:	e8 2d ce ff ff       	call   80101eb0 <nameiparent>
80105083:	85 c0                	test   %eax,%eax
80105085:	89 c6                	mov    %eax,%esi
80105087:	74 49                	je     801050d2 <sys_link+0xf2>
    goto bad;
  ilock(dp);
80105089:	89 04 24             	mov    %eax,(%esp)
8010508c:	e8 df cb ff ff       	call   80101c70 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105091:	8b 06                	mov    (%esi),%eax
80105093:	3b 03                	cmp    (%ebx),%eax
80105095:	75 33                	jne    801050ca <sys_link+0xea>
80105097:	8b 43 04             	mov    0x4(%ebx),%eax
8010509a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010509e:	89 34 24             	mov    %esi,(%esp)
801050a1:	89 44 24 08          	mov    %eax,0x8(%esp)
801050a5:	e8 96 c9 ff ff       	call   80101a40 <dirlink>
801050aa:	85 c0                	test   %eax,%eax
801050ac:	78 1c                	js     801050ca <sys_link+0xea>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801050ae:	89 34 24             	mov    %esi,(%esp)
801050b1:	e8 9a cb ff ff       	call   80101c50 <iunlockput>
  iput(ip);
801050b6:	89 1c 24             	mov    %ebx,(%esp)
801050b9:	e8 82 c3 ff ff       	call   80101440 <iput>

  end_op();
801050be:	e8 cd db ff ff       	call   80102c90 <end_op>
801050c3:	31 c0                	xor    %eax,%eax

  return 0;
801050c5:	e9 41 ff ff ff       	jmp    8010500b <sys_link+0x2b>

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
801050ca:	89 34 24             	mov    %esi,(%esp)
801050cd:	e8 7e cb ff ff       	call   80101c50 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
801050d2:	89 1c 24             	mov    %ebx,(%esp)
801050d5:	e8 96 cb ff ff       	call   80101c70 <ilock>
  ip->nlink--;
801050da:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050df:	89 1c 24             	mov    %ebx,(%esp)
801050e2:	e8 d9 c1 ff ff       	call   801012c0 <iupdate>
  iunlockput(ip);
801050e7:	89 1c 24             	mov    %ebx,(%esp)
801050ea:	e8 61 cb ff ff       	call   80101c50 <iunlockput>
  end_op();
801050ef:	e8 9c db ff ff       	call   80102c90 <end_op>
801050f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
801050f9:	e9 0d ff ff ff       	jmp    8010500b <sys_link+0x2b>
801050fe:	66 90                	xchg   %ax,%ax

80105100 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105106:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105109:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010510c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010510f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105113:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010511a:	e8 c1 f8 ff ff       	call   801049e0 <argstr>
8010511f:	85 c0                	test   %eax,%eax
80105121:	79 15                	jns    80105138 <sys_open+0x38>
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105123:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105128:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010512b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010512e:	89 ec                	mov    %ebp,%esp
80105130:	5d                   	pop    %ebp
80105131:	c3                   	ret    
80105132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105138:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010513b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010513f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105146:	e8 05 f8 ff ff       	call   80104950 <argint>
8010514b:	85 c0                	test   %eax,%eax
8010514d:	78 d4                	js     80105123 <sys_open+0x23>
    return -1;

  begin_op();
8010514f:	e8 6c dc ff ff       	call   80102dc0 <begin_op>

  if(omode & O_CREATE){
80105154:	f6 45 f1 02          	testb  $0x2,-0xf(%ebp)
80105158:	74 66                	je     801051c0 <sys_open+0xc0>
    ip = create(path, T_FILE, 0, 0);
8010515a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010515d:	31 c9                	xor    %ecx,%ecx
8010515f:	ba 02 00 00 00       	mov    $0x2,%edx
80105164:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010516b:	e8 d0 fb ff ff       	call   80104d40 <create>
    if(ip == 0){
80105170:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105172:	89 c3                	mov    %eax,%ebx
    if(ip == 0){
80105174:	74 3a                	je     801051b0 <sys_open+0xb0>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105176:	e8 75 be ff ff       	call   80100ff0 <filealloc>
8010517b:	85 c0                	test   %eax,%eax
8010517d:	89 c6                	mov    %eax,%esi
8010517f:	74 27                	je     801051a8 <sys_open+0xa8>
80105181:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105188:	31 c0                	xor    %eax,%eax
8010518a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105190:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80105194:	85 c9                	test   %ecx,%ecx
80105196:	74 58                	je     801051f0 <sys_open+0xf0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105198:	83 c0 01             	add    $0x1,%eax
8010519b:	83 f8 10             	cmp    $0x10,%eax
8010519e:	75 f0                	jne    80105190 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801051a0:	89 34 24             	mov    %esi,(%esp)
801051a3:	e8 c8 be ff ff       	call   80101070 <fileclose>
    iunlockput(ip);
801051a8:	89 1c 24             	mov    %ebx,(%esp)
801051ab:	e8 a0 ca ff ff       	call   80101c50 <iunlockput>
    end_op();
801051b0:	e8 db da ff ff       	call   80102c90 <end_op>
801051b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
801051ba:	e9 69 ff ff ff       	jmp    80105128 <sys_open+0x28>
801051bf:	90                   	nop
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c3:	89 04 24             	mov    %eax,(%esp)
801051c6:	e8 05 cd ff ff       	call   80101ed0 <namei>
801051cb:	85 c0                	test   %eax,%eax
801051cd:	89 c3                	mov    %eax,%ebx
801051cf:	74 df                	je     801051b0 <sys_open+0xb0>
      end_op();
      return -1;
    }
    ilock(ip);
801051d1:	89 04 24             	mov    %eax,(%esp)
801051d4:	e8 97 ca ff ff       	call   80101c70 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051d9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051de:	75 96                	jne    80105176 <sys_open+0x76>
801051e0:	8b 75 f0             	mov    -0x10(%ebp),%esi
801051e3:	85 f6                	test   %esi,%esi
801051e5:	74 8f                	je     80105176 <sys_open+0x76>
801051e7:	eb bf                	jmp    801051a8 <sys_open+0xa8>
801051e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801051f0:	89 74 82 28          	mov    %esi,0x28(%edx,%eax,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801051f7:	89 1c 24             	mov    %ebx,(%esp)
801051fa:	e8 01 ca ff ff       	call   80101c00 <iunlock>
  end_op();
801051ff:	e8 8c da ff ff       	call   80102c90 <end_op>

  f->type = FD_INODE;
80105204:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
8010520a:	89 5e 10             	mov    %ebx,0x10(%esi)
  f->off = 0;
8010520d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105214:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105217:	83 f2 01             	xor    $0x1,%edx
8010521a:	83 e2 01             	and    $0x1,%edx
8010521d:	88 56 08             	mov    %dl,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105220:	f6 45 f0 03          	testb  $0x3,-0x10(%ebp)
80105224:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
80105228:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010522b:	e9 f8 fe ff ff       	jmp    80105128 <sys_open+0x28>

80105230 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	56                   	push   %esi
80105235:	53                   	push   %ebx
80105236:	83 ec 6c             	sub    $0x6c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105239:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010523c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105240:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105247:	e8 94 f7 ff ff       	call   801049e0 <argstr>
8010524c:	89 c2                	mov    %eax,%edx
8010524e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105253:	85 d2                	test   %edx,%edx
80105255:	0f 88 0b 01 00 00    	js     80105366 <sys_unlink+0x136>
    return -1;

  begin_op();
8010525b:	e8 60 db ff ff       	call   80102dc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105260:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105263:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
80105266:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010526a:	89 04 24             	mov    %eax,(%esp)
8010526d:	e8 3e cc ff ff       	call   80101eb0 <nameiparent>
80105272:	85 c0                	test   %eax,%eax
80105274:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80105277:	0f 84 4e 01 00 00    	je     801053cb <sys_unlink+0x19b>
    end_op();
    return -1;
  }

  ilock(dp);
8010527d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105280:	89 04 24             	mov    %eax,(%esp)
80105283:	e8 e8 c9 ff ff       	call   80101c70 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105288:	c7 44 24 04 d4 78 10 	movl   $0x801078d4,0x4(%esp)
8010528f:	80 
80105290:	89 1c 24             	mov    %ebx,(%esp)
80105293:	e8 f8 bf ff ff       	call   80101290 <namecmp>
80105298:	85 c0                	test   %eax,%eax
8010529a:	0f 84 20 01 00 00    	je     801053c0 <sys_unlink+0x190>
801052a0:	c7 44 24 04 d3 78 10 	movl   $0x801078d3,0x4(%esp)
801052a7:	80 
801052a8:	89 1c 24             	mov    %ebx,(%esp)
801052ab:	e8 e0 bf ff ff       	call   80101290 <namecmp>
801052b0:	85 c0                	test   %eax,%eax
801052b2:	0f 84 08 01 00 00    	je     801053c0 <sys_unlink+0x190>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801052b8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801052bb:	89 44 24 08          	mov    %eax,0x8(%esp)
801052bf:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801052c2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801052c6:	89 04 24             	mov    %eax,(%esp)
801052c9:	e8 c2 c6 ff ff       	call   80101990 <dirlookup>
801052ce:	85 c0                	test   %eax,%eax
801052d0:	89 c6                	mov    %eax,%esi
801052d2:	0f 84 e8 00 00 00    	je     801053c0 <sys_unlink+0x190>
    goto bad;
  ilock(ip);
801052d8:	89 04 24             	mov    %eax,(%esp)
801052db:	e8 90 c9 ff ff       	call   80101c70 <ilock>

  if(ip->nlink < 1)
801052e0:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801052e5:	0f 8e 22 01 00 00    	jle    8010540d <sys_unlink+0x1dd>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801052eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052f0:	74 7e                	je     80105370 <sys_unlink+0x140>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801052f2:	8d 5d c2             	lea    -0x3e(%ebp),%ebx
801052f5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801052fc:	00 
801052fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105304:	00 
80105305:	89 1c 24             	mov    %ebx,(%esp)
80105308:	e8 33 f3 ff ff       	call   80104640 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010530d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105310:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105317:	00 
80105318:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010531c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105320:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105323:	89 04 24             	mov    %eax,(%esp)
80105326:	e8 35 c4 ff ff       	call   80101760 <writei>
8010532b:	83 f8 10             	cmp    $0x10,%eax
8010532e:	0f 85 cd 00 00 00    	jne    80105401 <sys_unlink+0x1d1>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105334:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105339:	0f 84 a1 00 00 00    	je     801053e0 <sys_unlink+0x1b0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010533f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105342:	89 04 24             	mov    %eax,(%esp)
80105345:	e8 06 c9 ff ff       	call   80101c50 <iunlockput>

  ip->nlink--;
8010534a:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
  iupdate(ip);
8010534f:	89 34 24             	mov    %esi,(%esp)
80105352:	e8 69 bf ff ff       	call   801012c0 <iupdate>
  iunlockput(ip);
80105357:	89 34 24             	mov    %esi,(%esp)
8010535a:	e8 f1 c8 ff ff       	call   80101c50 <iunlockput>

  end_op();
8010535f:	e8 2c d9 ff ff       	call   80102c90 <end_op>
80105364:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105366:	83 c4 6c             	add    $0x6c,%esp
80105369:	5b                   	pop    %ebx
8010536a:	5e                   	pop    %esi
8010536b:	5f                   	pop    %edi
8010536c:	5d                   	pop    %ebp
8010536d:	c3                   	ret    
8010536e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105370:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105374:	0f 86 78 ff ff ff    	jbe    801052f2 <sys_unlink+0xc2>
8010537a:	8d 7d b2             	lea    -0x4e(%ebp),%edi
8010537d:	bb 20 00 00 00       	mov    $0x20,%ebx
80105382:	eb 10                	jmp    80105394 <sys_unlink+0x164>
80105384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105388:	83 c3 10             	add    $0x10,%ebx
8010538b:	3b 5e 58             	cmp    0x58(%esi),%ebx
8010538e:	0f 83 5e ff ff ff    	jae    801052f2 <sys_unlink+0xc2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105394:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010539b:	00 
8010539c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801053a0:	89 7c 24 04          	mov    %edi,0x4(%esp)
801053a4:	89 34 24             	mov    %esi,(%esp)
801053a7:	e8 d4 c4 ff ff       	call   80101880 <readi>
801053ac:	83 f8 10             	cmp    $0x10,%eax
801053af:	75 44                	jne    801053f5 <sys_unlink+0x1c5>
      panic("isdirempty: readi");
    if(de.inum != 0)
801053b1:	66 83 7d b2 00       	cmpw   $0x0,-0x4e(%ebp)
801053b6:	74 d0                	je     80105388 <sys_unlink+0x158>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801053b8:	89 34 24             	mov    %esi,(%esp)
801053bb:	e8 90 c8 ff ff       	call   80101c50 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
801053c0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801053c3:	89 04 24             	mov    %eax,(%esp)
801053c6:	e8 85 c8 ff ff       	call   80101c50 <iunlockput>
  end_op();
801053cb:	e8 c0 d8 ff ff       	call   80102c90 <end_op>
  return -1;
}
801053d0:	83 c4 6c             	add    $0x6c,%esp

  return 0;

bad:
  iunlockput(dp);
  end_op();
801053d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
801053d8:	5b                   	pop    %ebx
801053d9:	5e                   	pop    %esi
801053da:	5f                   	pop    %edi
801053db:	5d                   	pop    %ebp
801053dc:	c3                   	ret    
801053dd:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801053e0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801053e3:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801053e8:	89 04 24             	mov    %eax,(%esp)
801053eb:	e8 d0 be ff ff       	call   801012c0 <iupdate>
801053f0:	e9 4a ff ff ff       	jmp    8010533f <sys_unlink+0x10f>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801053f5:	c7 04 24 04 79 10 80 	movl   $0x80107904,(%esp)
801053fc:	e8 cf af ff ff       	call   801003d0 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105401:	c7 04 24 16 79 10 80 	movl   $0x80107916,(%esp)
80105408:	e8 c3 af ff ff       	call   801003d0 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
8010540d:	c7 04 24 f2 78 10 80 	movl   $0x801078f2,(%esp)
80105414:	e8 b7 af ff ff       	call   801003d0 <panic>
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105420 <argfd.clone.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 28             	sub    $0x28,%esp
80105426:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105429:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010542b:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010542e:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105431:	89 d6                	mov    %edx,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105433:	89 44 24 04          	mov    %eax,0x4(%esp)
80105437:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010543e:	e8 0d f5 ff ff       	call   80104950 <argint>
80105443:	85 c0                	test   %eax,%eax
80105445:	79 11                	jns    80105458 <argfd.clone.0+0x38>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
80105447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
8010544c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010544f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105452:	89 ec                	mov    %ebp,%esp
80105454:	5d                   	pop    %ebp
80105455:	c3                   	ret    
80105456:	66 90                	xchg   %ax,%ax
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105458:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010545b:	83 f8 0f             	cmp    $0xf,%eax
8010545e:	77 e7                	ja     80105447 <argfd.clone.0+0x27>
80105460:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105467:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
8010546b:	85 d2                	test   %edx,%edx
8010546d:	74 d8                	je     80105447 <argfd.clone.0+0x27>
    return -1;
  if(pfd)
8010546f:	85 db                	test   %ebx,%ebx
80105471:	74 02                	je     80105475 <argfd.clone.0+0x55>
    *pfd = fd;
80105473:	89 03                	mov    %eax,(%ebx)
  if(pf)
80105475:	31 c0                	xor    %eax,%eax
80105477:	85 f6                	test   %esi,%esi
80105479:	74 d1                	je     8010544c <argfd.clone.0+0x2c>
    *pf = f;
8010547b:	89 16                	mov    %edx,(%esi)
8010547d:	eb cd                	jmp    8010544c <argfd.clone.0+0x2c>
8010547f:	90                   	nop

80105480 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105480:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105481:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80105483:	89 e5                	mov    %esp,%ebp
80105485:	53                   	push   %ebx
80105486:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105489:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010548c:	e8 8f ff ff ff       	call   80105420 <argfd.clone.0>
80105491:	85 c0                	test   %eax,%eax
80105493:	79 13                	jns    801054a8 <sys_dup+0x28>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105495:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
8010549a:	89 d8                	mov    %ebx,%eax
8010549c:	83 c4 24             	add    $0x24,%esp
8010549f:	5b                   	pop    %ebx
801054a0:	5d                   	pop    %ebp
801054a1:	c3                   	ret    
801054a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
801054a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054ab:	31 db                	xor    %ebx,%ebx
801054ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054b3:	eb 0b                	jmp    801054c0 <sys_dup+0x40>
801054b5:	8d 76 00             	lea    0x0(%esi),%esi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801054b8:	83 c3 01             	add    $0x1,%ebx
801054bb:	83 fb 10             	cmp    $0x10,%ebx
801054be:	74 d5                	je     80105495 <sys_dup+0x15>
    if(proc->ofile[fd] == 0){
801054c0:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
801054c4:	85 c9                	test   %ecx,%ecx
801054c6:	75 f0                	jne    801054b8 <sys_dup+0x38>
      proc->ofile[fd] = f;
801054c8:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801054cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054cf:	89 04 24             	mov    %eax,(%esp)
801054d2:	e8 c9 ba ff ff       	call   80100fa0 <filedup>
  return fd;
801054d7:	eb c1                	jmp    8010549a <sys_dup+0x1a>
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_read>:
}

int
sys_read(void)
{
801054e0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054e1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
801054e3:	89 e5                	mov    %esp,%ebp
801054e5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054e8:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054eb:	e8 30 ff ff ff       	call   80105420 <argfd.clone.0>
801054f0:	85 c0                	test   %eax,%eax
801054f2:	79 0c                	jns    80105500 <sys_read+0x20>
    return -1;
  return fileread(f, p, n);
801054f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f9:	c9                   	leave  
801054fa:	c3                   	ret    
801054fb:	90                   	nop
801054fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105500:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105503:	89 44 24 04          	mov    %eax,0x4(%esp)
80105507:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010550e:	e8 3d f4 ff ff       	call   80104950 <argint>
80105513:	85 c0                	test   %eax,%eax
80105515:	78 dd                	js     801054f4 <sys_read+0x14>
80105517:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010551a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105521:	89 44 24 08          	mov    %eax,0x8(%esp)
80105525:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105528:	89 44 24 04          	mov    %eax,0x4(%esp)
8010552c:	e8 5f f4 ff ff       	call   80104990 <argptr>
80105531:	85 c0                	test   %eax,%eax
80105533:	78 bf                	js     801054f4 <sys_read+0x14>
    return -1;
  return fileread(f, p, n);
80105535:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105538:	89 44 24 08          	mov    %eax,0x8(%esp)
8010553c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010553f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105543:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105546:	89 04 24             	mov    %eax,(%esp)
80105549:	e8 42 b9 ff ff       	call   80100e90 <fileread>
}
8010554e:	c9                   	leave  
8010554f:	c3                   	ret    

80105550 <sys_write>:

int
sys_write(void)
{
80105550:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105551:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105553:	89 e5                	mov    %esp,%ebp
80105555:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105558:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010555b:	e8 c0 fe ff ff       	call   80105420 <argfd.clone.0>
80105560:	85 c0                	test   %eax,%eax
80105562:	79 0c                	jns    80105570 <sys_write+0x20>
    return -1;
  return filewrite(f, p, n);
80105564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105569:	c9                   	leave  
8010556a:	c3                   	ret    
8010556b:	90                   	nop
8010556c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105570:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105573:	89 44 24 04          	mov    %eax,0x4(%esp)
80105577:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010557e:	e8 cd f3 ff ff       	call   80104950 <argint>
80105583:	85 c0                	test   %eax,%eax
80105585:	78 dd                	js     80105564 <sys_write+0x14>
80105587:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010558a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105591:	89 44 24 08          	mov    %eax,0x8(%esp)
80105595:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105598:	89 44 24 04          	mov    %eax,0x4(%esp)
8010559c:	e8 ef f3 ff ff       	call   80104990 <argptr>
801055a1:	85 c0                	test   %eax,%eax
801055a3:	78 bf                	js     80105564 <sys_write+0x14>
    return -1;
  return filewrite(f, p, n);
801055a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055a8:	89 44 24 08          	mov    %eax,0x8(%esp)
801055ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055af:	89 44 24 04          	mov    %eax,0x4(%esp)
801055b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055b6:	89 04 24             	mov    %eax,(%esp)
801055b9:	e8 b2 b7 ff ff       	call   80100d70 <filewrite>
}
801055be:	c9                   	leave  
801055bf:	c3                   	ret    

801055c0 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
801055c0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055c1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
801055c3:	89 e5                	mov    %esp,%ebp
801055c5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055c8:	8d 55 f4             	lea    -0xc(%ebp),%edx
801055cb:	e8 50 fe ff ff       	call   80105420 <argfd.clone.0>
801055d0:	85 c0                	test   %eax,%eax
801055d2:	79 0c                	jns    801055e0 <sys_fstat+0x20>
    return -1;
  return filestat(f, st);
801055d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055d9:	c9                   	leave  
801055da:	c3                   	ret    
801055db:	90                   	nop
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055e3:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801055ea:	00 
801055eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055f6:	e8 95 f3 ff ff       	call   80104990 <argptr>
801055fb:	85 c0                	test   %eax,%eax
801055fd:	78 d5                	js     801055d4 <sys_fstat+0x14>
    return -1;
  return filestat(f, st);
801055ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105602:	89 44 24 04          	mov    %eax,0x4(%esp)
80105606:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105609:	89 04 24             	mov    %eax,(%esp)
8010560c:	e8 3f b9 ff ff       	call   80100f50 <filestat>
}
80105611:	c9                   	leave  
80105612:	c3                   	ret    
80105613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105620 <sys_close>:
  return filewrite(f, p, n);
}

int
sys_close(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105626:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105629:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010562c:	e8 ef fd ff ff       	call   80105420 <argfd.clone.0>
80105631:	89 c2                	mov    %eax,%edx
80105633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105638:	85 d2                	test   %edx,%edx
8010563a:	78 1e                	js     8010565a <sys_close+0x3a>
    return -1;
  proc->ofile[fd] = 0;
8010563c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105642:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105645:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010564c:	00 
  fileclose(f);
8010564d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105650:	89 04 24             	mov    %eax,(%esp)
80105653:	e8 18 ba ff ff       	call   80101070 <fileclose>
80105658:	31 c0                	xor    %eax,%eax
  return 0;
}
8010565a:	c9                   	leave  
8010565b:	c3                   	ret    
8010565c:	00 00                	add    %al,(%eax)
	...

80105660 <sys_getpid>:
  return kill(pid);
}

int
sys_getpid(void)
{
80105660:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105666:	55                   	push   %ebp
80105667:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
80105669:	5d                   	pop    %ebp
  return kill(pid);
}

int
sys_getpid(void)
{
8010566a:	8b 40 10             	mov    0x10(%eax),%eax
  return proc->pid;
}
8010566d:	c3                   	ret    
8010566e:	66 90                	xchg   %ax,%ax

80105670 <sys_hello>:
  release(&tickslock);
  return xticks;
}
int
sys_hello(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
  hello();
80105676:	e8 b5 e0 ff ff       	call   80103730 <hello>
  return 0;
}
8010567b:	31 c0                	xor    %eax,%eax
8010567d:	c9                   	leave  
8010567e:	c3                   	ret    
8010567f:	90                   	nop

80105680 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	53                   	push   %ebx
80105684:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105687:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
8010568e:	e8 0d ef ff ff       	call   801045a0 <acquire>
  xticks = ticks;
80105693:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  release(&tickslock);
80105699:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
801056a0:	e8 ab ee ff ff       	call   80104550 <release>
  return xticks;
}
801056a5:	83 c4 14             	add    $0x14,%esp
801056a8:	89 d8                	mov    %ebx,%eax
801056aa:	5b                   	pop    %ebx
801056ab:	5d                   	pop    %ebp
801056ac:	c3                   	ret    
801056ad:	8d 76 00             	lea    0x0(%esi),%esi

801056b0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	53                   	push   %ebx
801056b4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056b7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ba:	89 44 24 04          	mov    %eax,0x4(%esp)
801056be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056c5:	e8 86 f2 ff ff       	call   80104950 <argint>
801056ca:	89 c2                	mov    %eax,%edx
801056cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d1:	85 d2                	test   %edx,%edx
801056d3:	78 59                	js     8010572e <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
801056d5:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
801056dc:	e8 bf ee ff ff       	call   801045a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801056e4:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  while(ticks - ticks0 < n){
801056ea:	85 d2                	test   %edx,%edx
801056ec:	75 22                	jne    80105710 <sys_sleep+0x60>
801056ee:	eb 48                	jmp    80105738 <sys_sleep+0x88>
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801056f0:	c7 44 24 04 e0 4e 11 	movl   $0x80114ee0,0x4(%esp)
801056f7:	80 
801056f8:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
801056ff:	e8 0c e3 ff ff       	call   80103a10 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105704:	a1 20 57 11 80       	mov    0x80115720,%eax
80105709:	29 d8                	sub    %ebx,%eax
8010570b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010570e:	73 28                	jae    80105738 <sys_sleep+0x88>
    if(proc->killed){
80105710:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105716:	8b 40 24             	mov    0x24(%eax),%eax
80105719:	85 c0                	test   %eax,%eax
8010571b:	74 d3                	je     801056f0 <sys_sleep+0x40>
      release(&tickslock);
8010571d:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105724:	e8 27 ee ff ff       	call   80104550 <release>
80105729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
8010572e:	83 c4 24             	add    $0x24,%esp
80105731:	5b                   	pop    %ebx
80105732:	5d                   	pop    %ebp
80105733:	c3                   	ret    
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105738:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
8010573f:	e8 0c ee ff ff       	call   80104550 <release>
  return 0;
}
80105744:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105747:	31 c0                	xor    %eax,%eax
  return 0;
}
80105749:	5b                   	pop    %ebx
8010574a:	5d                   	pop    %ebp
8010574b:	c3                   	ret    
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
80105754:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105757:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010575e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105765:	e8 e6 f1 ff ff       	call   80104950 <argint>
8010576a:	85 c0                	test   %eax,%eax
8010576c:	79 12                	jns    80105780 <sys_sbrk+0x30>
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
8010576e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105773:	83 c4 24             	add    $0x24,%esp
80105776:	5b                   	pop    %ebx
80105777:	5d                   	pop    %ebp
80105778:	c3                   	ret    
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105780:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105786:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010578b:	89 04 24             	mov    %eax,(%esp)
8010578e:	e8 cd e9 ff ff       	call   80104160 <growproc>
80105793:	89 c2                	mov    %eax,%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105795:	89 d8                	mov    %ebx,%eax
  if(growproc(n) < 0)
80105797:	85 d2                	test   %edx,%edx
80105799:	79 d8                	jns    80105773 <sys_sbrk+0x23>
8010579b:	eb d1                	jmp    8010576e <sys_sbrk+0x1e>
8010579d:	8d 76 00             	lea    0x0(%esi),%esi

801057a0 <sys_kill>:
	return 0;
}

int
sys_kill(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801057a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801057ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057b4:	e8 97 f1 ff ff       	call   80104950 <argint>
801057b9:	89 c2                	mov    %eax,%edx
801057bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c0:	85 d2                	test   %edx,%edx
801057c2:	78 0b                	js     801057cf <sys_kill+0x2f>
    return -1;
  return kill(pid);
801057c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057c7:	89 04 24             	mov    %eax,(%esp)
801057ca:	e8 51 e0 ff ff       	call   80103820 <kill>
}
801057cf:	c9                   	leave  
801057d0:	c3                   	ret    
801057d1:	eb 0d                	jmp    801057e0 <sys_setpriority>
801057d3:	90                   	nop
801057d4:	90                   	nop
801057d5:	90                   	nop
801057d6:	90                   	nop
801057d7:	90                   	nop
801057d8:	90                   	nop
801057d9:	90                   	nop
801057da:	90                   	nop
801057db:	90                   	nop
801057dc:	90                   	nop
801057dd:	90                   	nop
801057de:	90                   	nop
801057df:	90                   	nop

801057e0 <sys_setpriority>:

	return(waitpid(pid,waitStatus,arg));
}

int 
sys_setpriority(void) { //added the setpriority system call so that it takes 2 arguments. (lab1 part2)
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 28             	sub    $0x28,%esp
	//int pid;
	int priority;
	if(argint(0, &priority) < 0){
801057e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801057ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057f4:	e8 57 f1 ff ff       	call   80104950 <argint>
801057f9:	89 c2                	mov    %eax,%edx
801057fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105800:	85 d2                	test   %edx,%edx
80105802:	78 0d                	js     80105811 <sys_setpriority+0x31>
		return -1;
	}
	setpriority(priority);
80105804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105807:	89 04 24             	mov    %eax,(%esp)
8010580a:	e8 01 df ff ff       	call   80103710 <setpriority>
8010580f:	31 c0                	xor    %eax,%eax
	return 0;
}
80105811:	c9                   	leave  
80105812:	c3                   	ret    
80105813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105820 <sys_waitpid>:
  return wait(waitStatus);
}

int
sys_waitpid(void) //  Added waitpid sstem call which waits for a process with a pid that is equal to the pid provided by the argumet handles errors
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	83 ec 28             	sub    $0x28,%esp
	int pid;
	int *waitStatus;
	int arg;
	
	if(argint(0, &pid) < 0) {
80105826:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105829:	89 44 24 04          	mov    %eax,0x4(%esp)
8010582d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105834:	e8 17 f1 ff ff       	call   80104950 <argint>
80105839:	85 c0                	test   %eax,%eax
8010583b:	79 0b                	jns    80105848 <sys_waitpid+0x28>
	}
	if(argint(2, &arg) > 100) {
		return -1;
	}

	return(waitpid(pid,waitStatus,arg));
8010583d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105842:	c9                   	leave  
80105843:	c3                   	ret    
80105844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int arg;
	
	if(argint(0, &pid) < 0) {
		return -1;
	}
	if(argptr(1, (char**)&waitStatus, sizeof(int)) > 0){
80105848:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010584b:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105852:	00 
80105853:	89 44 24 04          	mov    %eax,0x4(%esp)
80105857:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010585e:	e8 2d f1 ff ff       	call   80104990 <argptr>
80105863:	85 c0                	test   %eax,%eax
80105865:	7f d6                	jg     8010583d <sys_waitpid+0x1d>
		return -1;
	}
	if(argint(2, &arg) > 100) {
80105867:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010586a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010586e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105875:	e8 d6 f0 ff ff       	call   80104950 <argint>
8010587a:	83 f8 64             	cmp    $0x64,%eax
8010587d:	7f be                	jg     8010583d <sys_waitpid+0x1d>
		return -1;
	}

	return(waitpid(pid,waitStatus,arg));
8010587f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105882:	89 44 24 08          	mov    %eax,0x8(%esp)
80105886:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105889:	89 44 24 04          	mov    %eax,0x4(%esp)
8010588d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105890:	89 04 24             	mov    %eax,(%esp)
80105893:	e8 68 e3 ff ff       	call   80103c00 <waitpid>
}
80105898:	c9                   	leave  
80105899:	c3                   	ret    
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058a0 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void) // update sys_wait to wiat for a process with a pod that equals the one provided by the waitStatus argument (lab1 part1b)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 28             	sub    $0x28,%esp
  int *waitStatus;

  if (argptr(0, (char**)&waitStatus, sizeof(int)) > 0) {
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801058b0:	00 
801058b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801058b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058bc:	e8 cf f0 ff ff       	call   80104990 <argptr>
801058c1:	89 c2                	mov    %eax,%edx
801058c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c8:	85 d2                	test   %edx,%edx
801058ca:	7e 04                	jle    801058d0 <sys_wait+0x30>
	  return -1;
  }
  return wait(waitStatus);
}
801058cc:	c9                   	leave  
801058cd:	c3                   	ret    
801058ce:	66 90                	xchg   %ax,%ax
  int *waitStatus;

  if (argptr(0, (char**)&waitStatus, sizeof(int)) > 0) {
	  return -1;
  }
  return wait(waitStatus);
801058d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058d3:	89 04 24             	mov    %eax,(%esp)
801058d6:	e8 25 e4 ff ff       	call   80103d00 <wait>
}
801058db:	c9                   	leave  
801058dc:	c3                   	ret    
801058dd:	8d 76 00             	lea    0x0(%esi),%esi

801058e0 <sys_exit>:
  return fork();
}

int
sys_exit(void) // modified exit to handle a exit status (lab1 part1: a)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 28             	sub    $0x28,%esp
  int status;
  
  if (argint(0, &status) > 0) {
801058e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801058ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058f4:	e8 57 f0 ff ff       	call   80104950 <argint>
801058f9:	89 c2                	mov    %eax,%edx
801058fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105900:	85 d2                	test   %edx,%edx
80105902:	7e 04                	jle    80105908 <sys_exit+0x28>
  }
  else{
	 exit(status);   
  }
  return 0;  // not reached
}
80105904:	c9                   	leave  
80105905:	c3                   	ret    
80105906:	66 90                	xchg   %ax,%ax
  
  if (argint(0, &status) > 0) {
	  return -1;  
  }
  else{
	 exit(status);   
80105908:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010590b:	89 04 24             	mov    %eax,(%esp)
8010590e:	e8 ed e4 ff ff       	call   80103e00 <exit>
80105913:	31 c0                	xor    %eax,%eax
  }
  return 0;  // not reached
}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  return fork();
}
80105926:	c9                   	leave  
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105927:	e9 14 e7 ff ff       	jmp    80104040 <fork>
8010592c:	00 00                	add    %al,(%eax)
	...

80105930 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105930:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105931:	ba 43 00 00 00       	mov    $0x43,%edx
80105936:	89 e5                	mov    %esp,%ebp
80105938:	83 ec 18             	sub    $0x18,%esp
8010593b:	b8 34 00 00 00       	mov    $0x34,%eax
80105940:	ee                   	out    %al,(%dx)
80105941:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105946:	b2 40                	mov    $0x40,%dl
80105948:	ee                   	out    %al,(%dx)
80105949:	b8 2e 00 00 00       	mov    $0x2e,%eax
8010594e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
8010594f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105956:	e8 75 d9 ff ff       	call   801032d0 <picenable>
}
8010595b:	c9                   	leave  
8010595c:	c3                   	ret    
8010595d:	00 00                	add    %al,(%eax)
	...

80105960 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105960:	1e                   	push   %ds
  pushl %es
80105961:	06                   	push   %es
  pushl %fs
80105962:	0f a0                	push   %fs
  pushl %gs
80105964:	0f a8                	push   %gs
  pushal
80105966:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105967:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010596b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010596d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010596f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105973:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105975:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105977:	54                   	push   %esp
  call trap
80105978:	e8 43 00 00 00       	call   801059c0 <trap>
  addl $4, %esp
8010597d:	83 c4 04             	add    $0x4,%esp

80105980 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105980:	61                   	popa   
  popl %gs
80105981:	0f a9                	pop    %gs
  popl %fs
80105983:	0f a1                	pop    %fs
  popl %es
80105985:	07                   	pop    %es
  popl %ds
80105986:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105987:	83 c4 08             	add    $0x8,%esp
  iret
8010598a:	cf                   	iret   
8010598b:	00 00                	add    %al,(%eax)
8010598d:	00 00                	add    %al,(%eax)
	...

80105990 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
80105990:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80105991:	b8 20 4f 11 80       	mov    $0x80114f20,%eax
80105996:	89 e5                	mov    %esp,%ebp
80105998:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010599b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
801059a1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059a5:	c1 e8 10             	shr    $0x10,%eax
801059a8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801059ac:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059af:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059b2:	c9                   	leave  
801059b3:	c3                   	ret    
801059b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801059c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	83 ec 38             	sub    $0x38,%esp
801059c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801059c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801059cf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
801059d2:	8b 43 30             	mov    0x30(%ebx),%eax
801059d5:	83 f8 40             	cmp    $0x40,%eax
801059d8:	0f 84 d2 00 00 00    	je     80105ab0 <trap+0xf0>
    if(proc->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
801059de:	83 e8 20             	sub    $0x20,%eax
801059e1:	83 f8 1f             	cmp    $0x1f,%eax
801059e4:	0f 86 be 00 00 00    	jbe    80105aa8 <trap+0xe8>
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801059ea:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
801059f1:	85 c9                	test   %ecx,%ecx
801059f3:	0f 84 fe 01 00 00    	je     80105bf7 <trap+0x237>
801059f9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801059fd:	0f 84 f4 01 00 00    	je     80105bf7 <trap+0x237>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a03:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a06:	8b 73 38             	mov    0x38(%ebx),%esi
80105a09:	e8 22 d0 ff ff       	call   80102a30 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105a0e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a15:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
80105a19:	89 74 24 18          	mov    %esi,0x18(%esp)
80105a1d:	89 44 24 14          	mov    %eax,0x14(%esp)
80105a21:	8b 43 34             	mov    0x34(%ebx),%eax
80105a24:	89 44 24 10          	mov    %eax,0x10(%esp)
80105a28:	8b 43 30             	mov    0x30(%ebx),%eax
80105a2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
80105a2f:	8d 42 6c             	lea    0x6c(%edx),%eax
80105a32:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a36:	8b 42 10             	mov    0x10(%edx),%eax
80105a39:	c7 04 24 80 79 10 80 	movl   $0x80107980,(%esp)
80105a40:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a44:	e8 27 ae ff ff       	call   80100870 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105a49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a4f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105a56:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a5e:	85 c0                	test   %eax,%eax
80105a60:	74 34                	je     80105a96 <trap+0xd6>
80105a62:	8b 50 24             	mov    0x24(%eax),%edx
80105a65:	85 d2                	test   %edx,%edx
80105a67:	74 10                	je     80105a79 <trap+0xb9>
80105a69:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105a6d:	83 e2 03             	and    $0x3,%edx
80105a70:	83 fa 03             	cmp    $0x3,%edx
80105a73:	0f 84 5f 01 00 00    	je     80105bd8 <trap+0x218>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105a79:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a7d:	0f 84 2d 01 00 00    	je     80105bb0 <trap+0x1f0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a83:	8b 40 24             	mov    0x24(%eax),%eax
80105a86:	85 c0                	test   %eax,%eax
80105a88:	74 0c                	je     80105a96 <trap+0xd6>
80105a8a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a8e:	83 e0 03             	and    $0x3,%eax
80105a91:	83 f8 03             	cmp    $0x3,%eax
80105a94:	74 3c                	je     80105ad2 <trap+0x112>
    exit(0);
}
80105a96:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105a99:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105a9c:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105a9f:	89 ec                	mov    %ebp,%esp
80105aa1:	5d                   	pop    %ebp
80105aa2:	c3                   	ret    
80105aa3:	90                   	nop
80105aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80105aa8:	ff 24 85 d0 79 10 80 	jmp    *-0x7fef8630(,%eax,4)
80105aaf:	90                   	nop
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105ab0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ab6:	8b 70 24             	mov    0x24(%eax),%esi
80105ab9:	85 f6                	test   %esi,%esi
80105abb:	75 33                	jne    80105af0 <trap+0x130>
      exit(0);
    proc->tf = tf;
80105abd:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105ac0:	e8 9b ef ff ff       	call   80104a60 <syscall>
    if(proc->killed)
80105ac5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105acb:	8b 58 24             	mov    0x24(%eax),%ebx
80105ace:	85 db                	test   %ebx,%ebx
80105ad0:	74 c4                	je     80105a96 <trap+0xd6>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105ad2:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80105ad9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105adc:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105adf:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ae2:	89 ec                	mov    %ebp,%esp
80105ae4:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105ae5:	e9 16 e3 ff ff       	jmp    80103e00 <exit>
80105aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit(0);
80105af0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105af7:	e8 04 e3 ff ff       	call   80103e00 <exit>
80105afc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b02:	eb b9                	jmp    80105abd <trap+0xfd>
80105b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105b08:	e8 23 c6 ff ff       	call   80102130 <ideintr>
    lapiceoi();
80105b0d:	e8 4e cc ff ff       	call   80102760 <lapiceoi>
    break;
80105b12:	e9 41 ff ff ff       	jmp    80105a58 <trap+0x98>
80105b17:	90                   	nop
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b18:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b1b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b1f:	e8 0c cf ff ff       	call   80102a30 <cpunum>
80105b24:	c7 04 24 28 79 10 80 	movl   $0x80107928,(%esp)
80105b2b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105b2f:	89 74 24 08          	mov    %esi,0x8(%esp)
80105b33:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b37:	e8 34 ad ff ff       	call   80100870 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105b3c:	e8 1f cc ff ff       	call   80102760 <lapiceoi>
    break;
80105b41:	e9 12 ff ff ff       	jmp    80105a58 <trap+0x98>
80105b46:	66 90                	xchg   %ax,%ax
80105b48:	90                   	nop
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b50:	e8 9b 01 00 00       	call   80105cf0 <uartintr>
    lapiceoi();
80105b55:	e8 06 cc ff ff       	call   80102760 <lapiceoi>
    break;
80105b5a:	e9 f9 fe ff ff       	jmp    80105a58 <trap+0x98>
80105b5f:	90                   	nop
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b60:	e8 9b ca ff ff       	call   80102600 <kbdintr>
    lapiceoi();
80105b65:	e8 f6 cb ff ff       	call   80102760 <lapiceoi>
    break;
80105b6a:	e9 e9 fe ff ff       	jmp    80105a58 <trap+0x98>
80105b6f:	90                   	nop
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b70:	e8 bb ce ff ff       	call   80102a30 <cpunum>
80105b75:	85 c0                	test   %eax,%eax
80105b77:	75 94                	jne    80105b0d <trap+0x14d>
      acquire(&tickslock);
80105b79:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105b80:	e8 1b ea ff ff       	call   801045a0 <acquire>
      ticks++;
80105b85:	83 05 20 57 11 80 01 	addl   $0x1,0x80115720
      wakeup(&ticks);
80105b8c:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
80105b93:	e8 18 dd ff ff       	call   801038b0 <wakeup>
      release(&tickslock);
80105b98:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105b9f:	e8 ac e9 ff ff       	call   80104550 <release>
80105ba4:	e9 64 ff ff ff       	jmp    80105b0d <trap+0x14d>
80105ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105bb0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105bb4:	0f 85 c9 fe ff ff    	jne    80105a83 <trap+0xc3>
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    yield();
80105bc0:	e8 1b df ff ff       	call   80103ae0 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bcb:	85 c0                	test   %eax,%eax
80105bcd:	0f 85 b0 fe ff ff    	jne    80105a83 <trap+0xc3>
80105bd3:	e9 be fe ff ff       	jmp    80105a96 <trap+0xd6>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105bd8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105bdf:	e8 1c e2 ff ff       	call   80103e00 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105be4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bea:	85 c0                	test   %eax,%eax
80105bec:	0f 85 87 fe ff ff    	jne    80105a79 <trap+0xb9>
80105bf2:	e9 9f fe ff ff       	jmp    80105a96 <trap+0xd6>
80105bf7:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105bfa:	8b 73 38             	mov    0x38(%ebx),%esi
80105bfd:	e8 2e ce ff ff       	call   80102a30 <cpunum>
80105c02:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105c06:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105c0a:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c0e:	8b 43 30             	mov    0x30(%ebx),%eax
80105c11:	c7 04 24 4c 79 10 80 	movl   $0x8010794c,(%esp)
80105c18:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c1c:	e8 4f ac ff ff       	call   80100870 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80105c21:	c7 04 24 c3 79 10 80 	movl   $0x801079c3,(%esp)
80105c28:	e8 a3 a7 ff ff       	call   801003d0 <panic>
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi

80105c30 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c30:	55                   	push   %ebp
80105c31:	31 c0                	xor    %eax,%eax
80105c33:	89 e5                	mov    %esp,%ebp
80105c35:	ba 20 4f 11 80       	mov    $0x80114f20,%edx
80105c3a:	83 ec 18             	sub    $0x18,%esp
80105c3d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c40:	8b 0c 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%ecx
80105c47:	66 89 0c c5 20 4f 11 	mov    %cx,-0x7feeb0e0(,%eax,8)
80105c4e:	80 
80105c4f:	c1 e9 10             	shr    $0x10,%ecx
80105c52:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
80105c59:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
80105c5e:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
80105c63:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105c68:	83 c0 01             	add    $0x1,%eax
80105c6b:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c70:	75 ce                	jne    80105c40 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c72:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105c77:	c7 44 24 04 c8 79 10 	movl   $0x801079c8,0x4(%esp)
80105c7e:	80 
80105c7f:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c86:	66 c7 05 22 51 11 80 	movw   $0x8,0x80115122
80105c8d:	08 00 
80105c8f:	66 a3 20 51 11 80    	mov    %ax,0x80115120
80105c95:	c1 e8 10             	shr    $0x10,%eax
80105c98:	c6 05 24 51 11 80 00 	movb   $0x0,0x80115124
80105c9f:	c6 05 25 51 11 80 ef 	movb   $0xef,0x80115125
80105ca6:	66 a3 26 51 11 80    	mov    %ax,0x80115126

  initlock(&tickslock, "time");
80105cac:	e8 5f e7 ff ff       	call   80104410 <initlock>
}
80105cb1:	c9                   	leave  
80105cb2:	c3                   	ret    
	...

80105cc0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105cc0:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105cc5:	55                   	push   %ebp
80105cc6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105cc8:	85 c0                	test   %eax,%eax
80105cca:	75 0c                	jne    80105cd8 <uartgetc+0x18>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
80105ccc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cd1:	5d                   	pop    %ebp
80105cd2:	c3                   	ret    
80105cd3:	90                   	nop
80105cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cd8:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cdd:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cde:	a8 01                	test   $0x1,%al
80105ce0:	74 ea                	je     80105ccc <uartgetc+0xc>
80105ce2:	b2 f8                	mov    $0xf8,%dl
80105ce4:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ce5:	0f b6 c0             	movzbl %al,%eax
}
80105ce8:	5d                   	pop    %ebp
80105ce9:	c3                   	ret    
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cf0 <uartintr>:

void
uartintr(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105cf6:	c7 04 24 c0 5c 10 80 	movl   $0x80105cc0,(%esp)
80105cfd:	e8 3e a9 ff ff       	call   80100640 <consoleintr>
}
80105d02:	c9                   	leave  
80105d03:	c3                   	ret    
80105d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105d10 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	56                   	push   %esi
80105d14:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d19:	53                   	push   %ebx
  int i;

  if(!uart)
80105d1a:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d1c:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
80105d1f:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
80105d25:	85 d2                	test   %edx,%edx
80105d27:	75 1e                	jne    80105d47 <uartputc+0x37>
80105d29:	eb 2c                	jmp    80105d57 <uartputc+0x47>
80105d2b:	90                   	nop
80105d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d30:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
80105d33:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105d3a:	e8 41 ca ff ff       	call   80102780 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d3f:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80105d45:	74 07                	je     80105d4e <uartputc+0x3e>
80105d47:	89 f2                	mov    %esi,%edx
80105d49:	ec                   	in     (%dx),%al
80105d4a:	a8 20                	test   $0x20,%al
80105d4c:	74 e2                	je     80105d30 <uartputc+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d4e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d53:	8b 45 08             	mov    0x8(%ebp),%eax
80105d56:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d57:	83 c4 10             	add    $0x10,%esp
80105d5a:	5b                   	pop    %ebx
80105d5b:	5e                   	pop    %esi
80105d5c:	5d                   	pop    %ebp
80105d5d:	c3                   	ret    
80105d5e:	66 90                	xchg   %ax,%ax

80105d60 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d60:	55                   	push   %ebp
80105d61:	31 c9                	xor    %ecx,%ecx
80105d63:	89 e5                	mov    %esp,%ebp
80105d65:	89 c8                	mov    %ecx,%eax
80105d67:	57                   	push   %edi
80105d68:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105d6d:	56                   	push   %esi
80105d6e:	89 fa                	mov    %edi,%edx
80105d70:	53                   	push   %ebx
80105d71:	83 ec 1c             	sub    $0x1c,%esp
80105d74:	ee                   	out    %al,(%dx)
80105d75:	bb fb 03 00 00       	mov    $0x3fb,%ebx
80105d7a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d7f:	89 da                	mov    %ebx,%edx
80105d81:	ee                   	out    %al,(%dx)
80105d82:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d87:	b2 f8                	mov    $0xf8,%dl
80105d89:	ee                   	out    %al,(%dx)
80105d8a:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d8f:	89 c8                	mov    %ecx,%eax
80105d91:	89 f2                	mov    %esi,%edx
80105d93:	ee                   	out    %al,(%dx)
80105d94:	b8 03 00 00 00       	mov    $0x3,%eax
80105d99:	89 da                	mov    %ebx,%edx
80105d9b:	ee                   	out    %al,(%dx)
80105d9c:	b2 fc                	mov    $0xfc,%dl
80105d9e:	89 c8                	mov    %ecx,%eax
80105da0:	ee                   	out    %al,(%dx)
80105da1:	b8 01 00 00 00       	mov    $0x1,%eax
80105da6:	89 f2                	mov    %esi,%edx
80105da8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105da9:	b2 fd                	mov    $0xfd,%dl
80105dab:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105dac:	3c ff                	cmp    $0xff,%al
80105dae:	74 55                	je     80105e05 <uartinit+0xa5>
    return;
  uart = 1;
80105db0:	c7 05 c8 a5 10 80 01 	movl   $0x1,0x8010a5c8
80105db7:	00 00 00 
80105dba:	89 fa                	mov    %edi,%edx
80105dbc:	ec                   	in     (%dx),%al
80105dbd:	b2 f8                	mov    $0xf8,%dl
80105dbf:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
80105dc0:	bb 50 7a 10 80       	mov    $0x80107a50,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105dc5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105dcc:	e8 ff d4 ff ff       	call   801032d0 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105dd1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105dd8:	00 
80105dd9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105de0:	e8 7b c4 ff ff       	call   80102260 <ioapicenable>
80105de5:	b8 78 00 00 00       	mov    $0x78,%eax
80105dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
80105df0:	0f be c0             	movsbl %al,%eax
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105df3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105df6:	89 04 24             	mov    %eax,(%esp)
80105df9:	e8 12 ff ff ff       	call   80105d10 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105dfe:	0f b6 03             	movzbl (%ebx),%eax
80105e01:	84 c0                	test   %al,%al
80105e03:	75 eb                	jne    80105df0 <uartinit+0x90>
    uartputc(*p);
}
80105e05:	83 c4 1c             	add    $0x1c,%esp
80105e08:	5b                   	pop    %ebx
80105e09:	5e                   	pop    %esi
80105e0a:	5f                   	pop    %edi
80105e0b:	5d                   	pop    %ebp
80105e0c:	c3                   	ret    
80105e0d:	00 00                	add    %al,(%eax)
	...

80105e10 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $0
80105e12:	6a 00                	push   $0x0
  jmp alltraps
80105e14:	e9 47 fb ff ff       	jmp    80105960 <alltraps>

80105e19 <vector1>:
.globl vector1
vector1:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $1
80105e1b:	6a 01                	push   $0x1
  jmp alltraps
80105e1d:	e9 3e fb ff ff       	jmp    80105960 <alltraps>

80105e22 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $2
80105e24:	6a 02                	push   $0x2
  jmp alltraps
80105e26:	e9 35 fb ff ff       	jmp    80105960 <alltraps>

80105e2b <vector3>:
.globl vector3
vector3:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $3
80105e2d:	6a 03                	push   $0x3
  jmp alltraps
80105e2f:	e9 2c fb ff ff       	jmp    80105960 <alltraps>

80105e34 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $4
80105e36:	6a 04                	push   $0x4
  jmp alltraps
80105e38:	e9 23 fb ff ff       	jmp    80105960 <alltraps>

80105e3d <vector5>:
.globl vector5
vector5:
  pushl $0
80105e3d:	6a 00                	push   $0x0
  pushl $5
80105e3f:	6a 05                	push   $0x5
  jmp alltraps
80105e41:	e9 1a fb ff ff       	jmp    80105960 <alltraps>

80105e46 <vector6>:
.globl vector6
vector6:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $6
80105e48:	6a 06                	push   $0x6
  jmp alltraps
80105e4a:	e9 11 fb ff ff       	jmp    80105960 <alltraps>

80105e4f <vector7>:
.globl vector7
vector7:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $7
80105e51:	6a 07                	push   $0x7
  jmp alltraps
80105e53:	e9 08 fb ff ff       	jmp    80105960 <alltraps>

80105e58 <vector8>:
.globl vector8
vector8:
  pushl $8
80105e58:	6a 08                	push   $0x8
  jmp alltraps
80105e5a:	e9 01 fb ff ff       	jmp    80105960 <alltraps>

80105e5f <vector9>:
.globl vector9
vector9:
  pushl $0
80105e5f:	6a 00                	push   $0x0
  pushl $9
80105e61:	6a 09                	push   $0x9
  jmp alltraps
80105e63:	e9 f8 fa ff ff       	jmp    80105960 <alltraps>

80105e68 <vector10>:
.globl vector10
vector10:
  pushl $10
80105e68:	6a 0a                	push   $0xa
  jmp alltraps
80105e6a:	e9 f1 fa ff ff       	jmp    80105960 <alltraps>

80105e6f <vector11>:
.globl vector11
vector11:
  pushl $11
80105e6f:	6a 0b                	push   $0xb
  jmp alltraps
80105e71:	e9 ea fa ff ff       	jmp    80105960 <alltraps>

80105e76 <vector12>:
.globl vector12
vector12:
  pushl $12
80105e76:	6a 0c                	push   $0xc
  jmp alltraps
80105e78:	e9 e3 fa ff ff       	jmp    80105960 <alltraps>

80105e7d <vector13>:
.globl vector13
vector13:
  pushl $13
80105e7d:	6a 0d                	push   $0xd
  jmp alltraps
80105e7f:	e9 dc fa ff ff       	jmp    80105960 <alltraps>

80105e84 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e84:	6a 0e                	push   $0xe
  jmp alltraps
80105e86:	e9 d5 fa ff ff       	jmp    80105960 <alltraps>

80105e8b <vector15>:
.globl vector15
vector15:
  pushl $0
80105e8b:	6a 00                	push   $0x0
  pushl $15
80105e8d:	6a 0f                	push   $0xf
  jmp alltraps
80105e8f:	e9 cc fa ff ff       	jmp    80105960 <alltraps>

80105e94 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $16
80105e96:	6a 10                	push   $0x10
  jmp alltraps
80105e98:	e9 c3 fa ff ff       	jmp    80105960 <alltraps>

80105e9d <vector17>:
.globl vector17
vector17:
  pushl $17
80105e9d:	6a 11                	push   $0x11
  jmp alltraps
80105e9f:	e9 bc fa ff ff       	jmp    80105960 <alltraps>

80105ea4 <vector18>:
.globl vector18
vector18:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $18
80105ea6:	6a 12                	push   $0x12
  jmp alltraps
80105ea8:	e9 b3 fa ff ff       	jmp    80105960 <alltraps>

80105ead <vector19>:
.globl vector19
vector19:
  pushl $0
80105ead:	6a 00                	push   $0x0
  pushl $19
80105eaf:	6a 13                	push   $0x13
  jmp alltraps
80105eb1:	e9 aa fa ff ff       	jmp    80105960 <alltraps>

80105eb6 <vector20>:
.globl vector20
vector20:
  pushl $0
80105eb6:	6a 00                	push   $0x0
  pushl $20
80105eb8:	6a 14                	push   $0x14
  jmp alltraps
80105eba:	e9 a1 fa ff ff       	jmp    80105960 <alltraps>

80105ebf <vector21>:
.globl vector21
vector21:
  pushl $0
80105ebf:	6a 00                	push   $0x0
  pushl $21
80105ec1:	6a 15                	push   $0x15
  jmp alltraps
80105ec3:	e9 98 fa ff ff       	jmp    80105960 <alltraps>

80105ec8 <vector22>:
.globl vector22
vector22:
  pushl $0
80105ec8:	6a 00                	push   $0x0
  pushl $22
80105eca:	6a 16                	push   $0x16
  jmp alltraps
80105ecc:	e9 8f fa ff ff       	jmp    80105960 <alltraps>

80105ed1 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ed1:	6a 00                	push   $0x0
  pushl $23
80105ed3:	6a 17                	push   $0x17
  jmp alltraps
80105ed5:	e9 86 fa ff ff       	jmp    80105960 <alltraps>

80105eda <vector24>:
.globl vector24
vector24:
  pushl $0
80105eda:	6a 00                	push   $0x0
  pushl $24
80105edc:	6a 18                	push   $0x18
  jmp alltraps
80105ede:	e9 7d fa ff ff       	jmp    80105960 <alltraps>

80105ee3 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ee3:	6a 00                	push   $0x0
  pushl $25
80105ee5:	6a 19                	push   $0x19
  jmp alltraps
80105ee7:	e9 74 fa ff ff       	jmp    80105960 <alltraps>

80105eec <vector26>:
.globl vector26
vector26:
  pushl $0
80105eec:	6a 00                	push   $0x0
  pushl $26
80105eee:	6a 1a                	push   $0x1a
  jmp alltraps
80105ef0:	e9 6b fa ff ff       	jmp    80105960 <alltraps>

80105ef5 <vector27>:
.globl vector27
vector27:
  pushl $0
80105ef5:	6a 00                	push   $0x0
  pushl $27
80105ef7:	6a 1b                	push   $0x1b
  jmp alltraps
80105ef9:	e9 62 fa ff ff       	jmp    80105960 <alltraps>

80105efe <vector28>:
.globl vector28
vector28:
  pushl $0
80105efe:	6a 00                	push   $0x0
  pushl $28
80105f00:	6a 1c                	push   $0x1c
  jmp alltraps
80105f02:	e9 59 fa ff ff       	jmp    80105960 <alltraps>

80105f07 <vector29>:
.globl vector29
vector29:
  pushl $0
80105f07:	6a 00                	push   $0x0
  pushl $29
80105f09:	6a 1d                	push   $0x1d
  jmp alltraps
80105f0b:	e9 50 fa ff ff       	jmp    80105960 <alltraps>

80105f10 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f10:	6a 00                	push   $0x0
  pushl $30
80105f12:	6a 1e                	push   $0x1e
  jmp alltraps
80105f14:	e9 47 fa ff ff       	jmp    80105960 <alltraps>

80105f19 <vector31>:
.globl vector31
vector31:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $31
80105f1b:	6a 1f                	push   $0x1f
  jmp alltraps
80105f1d:	e9 3e fa ff ff       	jmp    80105960 <alltraps>

80105f22 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $32
80105f24:	6a 20                	push   $0x20
  jmp alltraps
80105f26:	e9 35 fa ff ff       	jmp    80105960 <alltraps>

80105f2b <vector33>:
.globl vector33
vector33:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $33
80105f2d:	6a 21                	push   $0x21
  jmp alltraps
80105f2f:	e9 2c fa ff ff       	jmp    80105960 <alltraps>

80105f34 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $34
80105f36:	6a 22                	push   $0x22
  jmp alltraps
80105f38:	e9 23 fa ff ff       	jmp    80105960 <alltraps>

80105f3d <vector35>:
.globl vector35
vector35:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $35
80105f3f:	6a 23                	push   $0x23
  jmp alltraps
80105f41:	e9 1a fa ff ff       	jmp    80105960 <alltraps>

80105f46 <vector36>:
.globl vector36
vector36:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $36
80105f48:	6a 24                	push   $0x24
  jmp alltraps
80105f4a:	e9 11 fa ff ff       	jmp    80105960 <alltraps>

80105f4f <vector37>:
.globl vector37
vector37:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $37
80105f51:	6a 25                	push   $0x25
  jmp alltraps
80105f53:	e9 08 fa ff ff       	jmp    80105960 <alltraps>

80105f58 <vector38>:
.globl vector38
vector38:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $38
80105f5a:	6a 26                	push   $0x26
  jmp alltraps
80105f5c:	e9 ff f9 ff ff       	jmp    80105960 <alltraps>

80105f61 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $39
80105f63:	6a 27                	push   $0x27
  jmp alltraps
80105f65:	e9 f6 f9 ff ff       	jmp    80105960 <alltraps>

80105f6a <vector40>:
.globl vector40
vector40:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $40
80105f6c:	6a 28                	push   $0x28
  jmp alltraps
80105f6e:	e9 ed f9 ff ff       	jmp    80105960 <alltraps>

80105f73 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $41
80105f75:	6a 29                	push   $0x29
  jmp alltraps
80105f77:	e9 e4 f9 ff ff       	jmp    80105960 <alltraps>

80105f7c <vector42>:
.globl vector42
vector42:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $42
80105f7e:	6a 2a                	push   $0x2a
  jmp alltraps
80105f80:	e9 db f9 ff ff       	jmp    80105960 <alltraps>

80105f85 <vector43>:
.globl vector43
vector43:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $43
80105f87:	6a 2b                	push   $0x2b
  jmp alltraps
80105f89:	e9 d2 f9 ff ff       	jmp    80105960 <alltraps>

80105f8e <vector44>:
.globl vector44
vector44:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $44
80105f90:	6a 2c                	push   $0x2c
  jmp alltraps
80105f92:	e9 c9 f9 ff ff       	jmp    80105960 <alltraps>

80105f97 <vector45>:
.globl vector45
vector45:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $45
80105f99:	6a 2d                	push   $0x2d
  jmp alltraps
80105f9b:	e9 c0 f9 ff ff       	jmp    80105960 <alltraps>

80105fa0 <vector46>:
.globl vector46
vector46:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $46
80105fa2:	6a 2e                	push   $0x2e
  jmp alltraps
80105fa4:	e9 b7 f9 ff ff       	jmp    80105960 <alltraps>

80105fa9 <vector47>:
.globl vector47
vector47:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $47
80105fab:	6a 2f                	push   $0x2f
  jmp alltraps
80105fad:	e9 ae f9 ff ff       	jmp    80105960 <alltraps>

80105fb2 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $48
80105fb4:	6a 30                	push   $0x30
  jmp alltraps
80105fb6:	e9 a5 f9 ff ff       	jmp    80105960 <alltraps>

80105fbb <vector49>:
.globl vector49
vector49:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $49
80105fbd:	6a 31                	push   $0x31
  jmp alltraps
80105fbf:	e9 9c f9 ff ff       	jmp    80105960 <alltraps>

80105fc4 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $50
80105fc6:	6a 32                	push   $0x32
  jmp alltraps
80105fc8:	e9 93 f9 ff ff       	jmp    80105960 <alltraps>

80105fcd <vector51>:
.globl vector51
vector51:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $51
80105fcf:	6a 33                	push   $0x33
  jmp alltraps
80105fd1:	e9 8a f9 ff ff       	jmp    80105960 <alltraps>

80105fd6 <vector52>:
.globl vector52
vector52:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $52
80105fd8:	6a 34                	push   $0x34
  jmp alltraps
80105fda:	e9 81 f9 ff ff       	jmp    80105960 <alltraps>

80105fdf <vector53>:
.globl vector53
vector53:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $53
80105fe1:	6a 35                	push   $0x35
  jmp alltraps
80105fe3:	e9 78 f9 ff ff       	jmp    80105960 <alltraps>

80105fe8 <vector54>:
.globl vector54
vector54:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $54
80105fea:	6a 36                	push   $0x36
  jmp alltraps
80105fec:	e9 6f f9 ff ff       	jmp    80105960 <alltraps>

80105ff1 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $55
80105ff3:	6a 37                	push   $0x37
  jmp alltraps
80105ff5:	e9 66 f9 ff ff       	jmp    80105960 <alltraps>

80105ffa <vector56>:
.globl vector56
vector56:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $56
80105ffc:	6a 38                	push   $0x38
  jmp alltraps
80105ffe:	e9 5d f9 ff ff       	jmp    80105960 <alltraps>

80106003 <vector57>:
.globl vector57
vector57:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $57
80106005:	6a 39                	push   $0x39
  jmp alltraps
80106007:	e9 54 f9 ff ff       	jmp    80105960 <alltraps>

8010600c <vector58>:
.globl vector58
vector58:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $58
8010600e:	6a 3a                	push   $0x3a
  jmp alltraps
80106010:	e9 4b f9 ff ff       	jmp    80105960 <alltraps>

80106015 <vector59>:
.globl vector59
vector59:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $59
80106017:	6a 3b                	push   $0x3b
  jmp alltraps
80106019:	e9 42 f9 ff ff       	jmp    80105960 <alltraps>

8010601e <vector60>:
.globl vector60
vector60:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $60
80106020:	6a 3c                	push   $0x3c
  jmp alltraps
80106022:	e9 39 f9 ff ff       	jmp    80105960 <alltraps>

80106027 <vector61>:
.globl vector61
vector61:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $61
80106029:	6a 3d                	push   $0x3d
  jmp alltraps
8010602b:	e9 30 f9 ff ff       	jmp    80105960 <alltraps>

80106030 <vector62>:
.globl vector62
vector62:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $62
80106032:	6a 3e                	push   $0x3e
  jmp alltraps
80106034:	e9 27 f9 ff ff       	jmp    80105960 <alltraps>

80106039 <vector63>:
.globl vector63
vector63:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $63
8010603b:	6a 3f                	push   $0x3f
  jmp alltraps
8010603d:	e9 1e f9 ff ff       	jmp    80105960 <alltraps>

80106042 <vector64>:
.globl vector64
vector64:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $64
80106044:	6a 40                	push   $0x40
  jmp alltraps
80106046:	e9 15 f9 ff ff       	jmp    80105960 <alltraps>

8010604b <vector65>:
.globl vector65
vector65:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $65
8010604d:	6a 41                	push   $0x41
  jmp alltraps
8010604f:	e9 0c f9 ff ff       	jmp    80105960 <alltraps>

80106054 <vector66>:
.globl vector66
vector66:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $66
80106056:	6a 42                	push   $0x42
  jmp alltraps
80106058:	e9 03 f9 ff ff       	jmp    80105960 <alltraps>

8010605d <vector67>:
.globl vector67
vector67:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $67
8010605f:	6a 43                	push   $0x43
  jmp alltraps
80106061:	e9 fa f8 ff ff       	jmp    80105960 <alltraps>

80106066 <vector68>:
.globl vector68
vector68:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $68
80106068:	6a 44                	push   $0x44
  jmp alltraps
8010606a:	e9 f1 f8 ff ff       	jmp    80105960 <alltraps>

8010606f <vector69>:
.globl vector69
vector69:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $69
80106071:	6a 45                	push   $0x45
  jmp alltraps
80106073:	e9 e8 f8 ff ff       	jmp    80105960 <alltraps>

80106078 <vector70>:
.globl vector70
vector70:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $70
8010607a:	6a 46                	push   $0x46
  jmp alltraps
8010607c:	e9 df f8 ff ff       	jmp    80105960 <alltraps>

80106081 <vector71>:
.globl vector71
vector71:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $71
80106083:	6a 47                	push   $0x47
  jmp alltraps
80106085:	e9 d6 f8 ff ff       	jmp    80105960 <alltraps>

8010608a <vector72>:
.globl vector72
vector72:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $72
8010608c:	6a 48                	push   $0x48
  jmp alltraps
8010608e:	e9 cd f8 ff ff       	jmp    80105960 <alltraps>

80106093 <vector73>:
.globl vector73
vector73:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $73
80106095:	6a 49                	push   $0x49
  jmp alltraps
80106097:	e9 c4 f8 ff ff       	jmp    80105960 <alltraps>

8010609c <vector74>:
.globl vector74
vector74:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $74
8010609e:	6a 4a                	push   $0x4a
  jmp alltraps
801060a0:	e9 bb f8 ff ff       	jmp    80105960 <alltraps>

801060a5 <vector75>:
.globl vector75
vector75:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $75
801060a7:	6a 4b                	push   $0x4b
  jmp alltraps
801060a9:	e9 b2 f8 ff ff       	jmp    80105960 <alltraps>

801060ae <vector76>:
.globl vector76
vector76:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $76
801060b0:	6a 4c                	push   $0x4c
  jmp alltraps
801060b2:	e9 a9 f8 ff ff       	jmp    80105960 <alltraps>

801060b7 <vector77>:
.globl vector77
vector77:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $77
801060b9:	6a 4d                	push   $0x4d
  jmp alltraps
801060bb:	e9 a0 f8 ff ff       	jmp    80105960 <alltraps>

801060c0 <vector78>:
.globl vector78
vector78:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $78
801060c2:	6a 4e                	push   $0x4e
  jmp alltraps
801060c4:	e9 97 f8 ff ff       	jmp    80105960 <alltraps>

801060c9 <vector79>:
.globl vector79
vector79:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $79
801060cb:	6a 4f                	push   $0x4f
  jmp alltraps
801060cd:	e9 8e f8 ff ff       	jmp    80105960 <alltraps>

801060d2 <vector80>:
.globl vector80
vector80:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $80
801060d4:	6a 50                	push   $0x50
  jmp alltraps
801060d6:	e9 85 f8 ff ff       	jmp    80105960 <alltraps>

801060db <vector81>:
.globl vector81
vector81:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $81
801060dd:	6a 51                	push   $0x51
  jmp alltraps
801060df:	e9 7c f8 ff ff       	jmp    80105960 <alltraps>

801060e4 <vector82>:
.globl vector82
vector82:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $82
801060e6:	6a 52                	push   $0x52
  jmp alltraps
801060e8:	e9 73 f8 ff ff       	jmp    80105960 <alltraps>

801060ed <vector83>:
.globl vector83
vector83:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $83
801060ef:	6a 53                	push   $0x53
  jmp alltraps
801060f1:	e9 6a f8 ff ff       	jmp    80105960 <alltraps>

801060f6 <vector84>:
.globl vector84
vector84:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $84
801060f8:	6a 54                	push   $0x54
  jmp alltraps
801060fa:	e9 61 f8 ff ff       	jmp    80105960 <alltraps>

801060ff <vector85>:
.globl vector85
vector85:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $85
80106101:	6a 55                	push   $0x55
  jmp alltraps
80106103:	e9 58 f8 ff ff       	jmp    80105960 <alltraps>

80106108 <vector86>:
.globl vector86
vector86:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $86
8010610a:	6a 56                	push   $0x56
  jmp alltraps
8010610c:	e9 4f f8 ff ff       	jmp    80105960 <alltraps>

80106111 <vector87>:
.globl vector87
vector87:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $87
80106113:	6a 57                	push   $0x57
  jmp alltraps
80106115:	e9 46 f8 ff ff       	jmp    80105960 <alltraps>

8010611a <vector88>:
.globl vector88
vector88:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $88
8010611c:	6a 58                	push   $0x58
  jmp alltraps
8010611e:	e9 3d f8 ff ff       	jmp    80105960 <alltraps>

80106123 <vector89>:
.globl vector89
vector89:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $89
80106125:	6a 59                	push   $0x59
  jmp alltraps
80106127:	e9 34 f8 ff ff       	jmp    80105960 <alltraps>

8010612c <vector90>:
.globl vector90
vector90:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $90
8010612e:	6a 5a                	push   $0x5a
  jmp alltraps
80106130:	e9 2b f8 ff ff       	jmp    80105960 <alltraps>

80106135 <vector91>:
.globl vector91
vector91:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $91
80106137:	6a 5b                	push   $0x5b
  jmp alltraps
80106139:	e9 22 f8 ff ff       	jmp    80105960 <alltraps>

8010613e <vector92>:
.globl vector92
vector92:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $92
80106140:	6a 5c                	push   $0x5c
  jmp alltraps
80106142:	e9 19 f8 ff ff       	jmp    80105960 <alltraps>

80106147 <vector93>:
.globl vector93
vector93:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $93
80106149:	6a 5d                	push   $0x5d
  jmp alltraps
8010614b:	e9 10 f8 ff ff       	jmp    80105960 <alltraps>

80106150 <vector94>:
.globl vector94
vector94:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $94
80106152:	6a 5e                	push   $0x5e
  jmp alltraps
80106154:	e9 07 f8 ff ff       	jmp    80105960 <alltraps>

80106159 <vector95>:
.globl vector95
vector95:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $95
8010615b:	6a 5f                	push   $0x5f
  jmp alltraps
8010615d:	e9 fe f7 ff ff       	jmp    80105960 <alltraps>

80106162 <vector96>:
.globl vector96
vector96:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $96
80106164:	6a 60                	push   $0x60
  jmp alltraps
80106166:	e9 f5 f7 ff ff       	jmp    80105960 <alltraps>

8010616b <vector97>:
.globl vector97
vector97:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $97
8010616d:	6a 61                	push   $0x61
  jmp alltraps
8010616f:	e9 ec f7 ff ff       	jmp    80105960 <alltraps>

80106174 <vector98>:
.globl vector98
vector98:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $98
80106176:	6a 62                	push   $0x62
  jmp alltraps
80106178:	e9 e3 f7 ff ff       	jmp    80105960 <alltraps>

8010617d <vector99>:
.globl vector99
vector99:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $99
8010617f:	6a 63                	push   $0x63
  jmp alltraps
80106181:	e9 da f7 ff ff       	jmp    80105960 <alltraps>

80106186 <vector100>:
.globl vector100
vector100:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $100
80106188:	6a 64                	push   $0x64
  jmp alltraps
8010618a:	e9 d1 f7 ff ff       	jmp    80105960 <alltraps>

8010618f <vector101>:
.globl vector101
vector101:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $101
80106191:	6a 65                	push   $0x65
  jmp alltraps
80106193:	e9 c8 f7 ff ff       	jmp    80105960 <alltraps>

80106198 <vector102>:
.globl vector102
vector102:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $102
8010619a:	6a 66                	push   $0x66
  jmp alltraps
8010619c:	e9 bf f7 ff ff       	jmp    80105960 <alltraps>

801061a1 <vector103>:
.globl vector103
vector103:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $103
801061a3:	6a 67                	push   $0x67
  jmp alltraps
801061a5:	e9 b6 f7 ff ff       	jmp    80105960 <alltraps>

801061aa <vector104>:
.globl vector104
vector104:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $104
801061ac:	6a 68                	push   $0x68
  jmp alltraps
801061ae:	e9 ad f7 ff ff       	jmp    80105960 <alltraps>

801061b3 <vector105>:
.globl vector105
vector105:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $105
801061b5:	6a 69                	push   $0x69
  jmp alltraps
801061b7:	e9 a4 f7 ff ff       	jmp    80105960 <alltraps>

801061bc <vector106>:
.globl vector106
vector106:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $106
801061be:	6a 6a                	push   $0x6a
  jmp alltraps
801061c0:	e9 9b f7 ff ff       	jmp    80105960 <alltraps>

801061c5 <vector107>:
.globl vector107
vector107:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $107
801061c7:	6a 6b                	push   $0x6b
  jmp alltraps
801061c9:	e9 92 f7 ff ff       	jmp    80105960 <alltraps>

801061ce <vector108>:
.globl vector108
vector108:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $108
801061d0:	6a 6c                	push   $0x6c
  jmp alltraps
801061d2:	e9 89 f7 ff ff       	jmp    80105960 <alltraps>

801061d7 <vector109>:
.globl vector109
vector109:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $109
801061d9:	6a 6d                	push   $0x6d
  jmp alltraps
801061db:	e9 80 f7 ff ff       	jmp    80105960 <alltraps>

801061e0 <vector110>:
.globl vector110
vector110:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $110
801061e2:	6a 6e                	push   $0x6e
  jmp alltraps
801061e4:	e9 77 f7 ff ff       	jmp    80105960 <alltraps>

801061e9 <vector111>:
.globl vector111
vector111:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $111
801061eb:	6a 6f                	push   $0x6f
  jmp alltraps
801061ed:	e9 6e f7 ff ff       	jmp    80105960 <alltraps>

801061f2 <vector112>:
.globl vector112
vector112:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $112
801061f4:	6a 70                	push   $0x70
  jmp alltraps
801061f6:	e9 65 f7 ff ff       	jmp    80105960 <alltraps>

801061fb <vector113>:
.globl vector113
vector113:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $113
801061fd:	6a 71                	push   $0x71
  jmp alltraps
801061ff:	e9 5c f7 ff ff       	jmp    80105960 <alltraps>

80106204 <vector114>:
.globl vector114
vector114:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $114
80106206:	6a 72                	push   $0x72
  jmp alltraps
80106208:	e9 53 f7 ff ff       	jmp    80105960 <alltraps>

8010620d <vector115>:
.globl vector115
vector115:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $115
8010620f:	6a 73                	push   $0x73
  jmp alltraps
80106211:	e9 4a f7 ff ff       	jmp    80105960 <alltraps>

80106216 <vector116>:
.globl vector116
vector116:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $116
80106218:	6a 74                	push   $0x74
  jmp alltraps
8010621a:	e9 41 f7 ff ff       	jmp    80105960 <alltraps>

8010621f <vector117>:
.globl vector117
vector117:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $117
80106221:	6a 75                	push   $0x75
  jmp alltraps
80106223:	e9 38 f7 ff ff       	jmp    80105960 <alltraps>

80106228 <vector118>:
.globl vector118
vector118:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $118
8010622a:	6a 76                	push   $0x76
  jmp alltraps
8010622c:	e9 2f f7 ff ff       	jmp    80105960 <alltraps>

80106231 <vector119>:
.globl vector119
vector119:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $119
80106233:	6a 77                	push   $0x77
  jmp alltraps
80106235:	e9 26 f7 ff ff       	jmp    80105960 <alltraps>

8010623a <vector120>:
.globl vector120
vector120:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $120
8010623c:	6a 78                	push   $0x78
  jmp alltraps
8010623e:	e9 1d f7 ff ff       	jmp    80105960 <alltraps>

80106243 <vector121>:
.globl vector121
vector121:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $121
80106245:	6a 79                	push   $0x79
  jmp alltraps
80106247:	e9 14 f7 ff ff       	jmp    80105960 <alltraps>

8010624c <vector122>:
.globl vector122
vector122:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $122
8010624e:	6a 7a                	push   $0x7a
  jmp alltraps
80106250:	e9 0b f7 ff ff       	jmp    80105960 <alltraps>

80106255 <vector123>:
.globl vector123
vector123:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $123
80106257:	6a 7b                	push   $0x7b
  jmp alltraps
80106259:	e9 02 f7 ff ff       	jmp    80105960 <alltraps>

8010625e <vector124>:
.globl vector124
vector124:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $124
80106260:	6a 7c                	push   $0x7c
  jmp alltraps
80106262:	e9 f9 f6 ff ff       	jmp    80105960 <alltraps>

80106267 <vector125>:
.globl vector125
vector125:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $125
80106269:	6a 7d                	push   $0x7d
  jmp alltraps
8010626b:	e9 f0 f6 ff ff       	jmp    80105960 <alltraps>

80106270 <vector126>:
.globl vector126
vector126:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $126
80106272:	6a 7e                	push   $0x7e
  jmp alltraps
80106274:	e9 e7 f6 ff ff       	jmp    80105960 <alltraps>

80106279 <vector127>:
.globl vector127
vector127:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $127
8010627b:	6a 7f                	push   $0x7f
  jmp alltraps
8010627d:	e9 de f6 ff ff       	jmp    80105960 <alltraps>

80106282 <vector128>:
.globl vector128
vector128:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $128
80106284:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106289:	e9 d2 f6 ff ff       	jmp    80105960 <alltraps>

8010628e <vector129>:
.globl vector129
vector129:
  pushl $0
8010628e:	6a 00                	push   $0x0
  pushl $129
80106290:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106295:	e9 c6 f6 ff ff       	jmp    80105960 <alltraps>

8010629a <vector130>:
.globl vector130
vector130:
  pushl $0
8010629a:	6a 00                	push   $0x0
  pushl $130
8010629c:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062a1:	e9 ba f6 ff ff       	jmp    80105960 <alltraps>

801062a6 <vector131>:
.globl vector131
vector131:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $131
801062a8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062ad:	e9 ae f6 ff ff       	jmp    80105960 <alltraps>

801062b2 <vector132>:
.globl vector132
vector132:
  pushl $0
801062b2:	6a 00                	push   $0x0
  pushl $132
801062b4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062b9:	e9 a2 f6 ff ff       	jmp    80105960 <alltraps>

801062be <vector133>:
.globl vector133
vector133:
  pushl $0
801062be:	6a 00                	push   $0x0
  pushl $133
801062c0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062c5:	e9 96 f6 ff ff       	jmp    80105960 <alltraps>

801062ca <vector134>:
.globl vector134
vector134:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $134
801062cc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062d1:	e9 8a f6 ff ff       	jmp    80105960 <alltraps>

801062d6 <vector135>:
.globl vector135
vector135:
  pushl $0
801062d6:	6a 00                	push   $0x0
  pushl $135
801062d8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062dd:	e9 7e f6 ff ff       	jmp    80105960 <alltraps>

801062e2 <vector136>:
.globl vector136
vector136:
  pushl $0
801062e2:	6a 00                	push   $0x0
  pushl $136
801062e4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062e9:	e9 72 f6 ff ff       	jmp    80105960 <alltraps>

801062ee <vector137>:
.globl vector137
vector137:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $137
801062f0:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062f5:	e9 66 f6 ff ff       	jmp    80105960 <alltraps>

801062fa <vector138>:
.globl vector138
vector138:
  pushl $0
801062fa:	6a 00                	push   $0x0
  pushl $138
801062fc:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106301:	e9 5a f6 ff ff       	jmp    80105960 <alltraps>

80106306 <vector139>:
.globl vector139
vector139:
  pushl $0
80106306:	6a 00                	push   $0x0
  pushl $139
80106308:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010630d:	e9 4e f6 ff ff       	jmp    80105960 <alltraps>

80106312 <vector140>:
.globl vector140
vector140:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $140
80106314:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106319:	e9 42 f6 ff ff       	jmp    80105960 <alltraps>

8010631e <vector141>:
.globl vector141
vector141:
  pushl $0
8010631e:	6a 00                	push   $0x0
  pushl $141
80106320:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106325:	e9 36 f6 ff ff       	jmp    80105960 <alltraps>

8010632a <vector142>:
.globl vector142
vector142:
  pushl $0
8010632a:	6a 00                	push   $0x0
  pushl $142
8010632c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106331:	e9 2a f6 ff ff       	jmp    80105960 <alltraps>

80106336 <vector143>:
.globl vector143
vector143:
  pushl $0
80106336:	6a 00                	push   $0x0
  pushl $143
80106338:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010633d:	e9 1e f6 ff ff       	jmp    80105960 <alltraps>

80106342 <vector144>:
.globl vector144
vector144:
  pushl $0
80106342:	6a 00                	push   $0x0
  pushl $144
80106344:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106349:	e9 12 f6 ff ff       	jmp    80105960 <alltraps>

8010634e <vector145>:
.globl vector145
vector145:
  pushl $0
8010634e:	6a 00                	push   $0x0
  pushl $145
80106350:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106355:	e9 06 f6 ff ff       	jmp    80105960 <alltraps>

8010635a <vector146>:
.globl vector146
vector146:
  pushl $0
8010635a:	6a 00                	push   $0x0
  pushl $146
8010635c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106361:	e9 fa f5 ff ff       	jmp    80105960 <alltraps>

80106366 <vector147>:
.globl vector147
vector147:
  pushl $0
80106366:	6a 00                	push   $0x0
  pushl $147
80106368:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010636d:	e9 ee f5 ff ff       	jmp    80105960 <alltraps>

80106372 <vector148>:
.globl vector148
vector148:
  pushl $0
80106372:	6a 00                	push   $0x0
  pushl $148
80106374:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106379:	e9 e2 f5 ff ff       	jmp    80105960 <alltraps>

8010637e <vector149>:
.globl vector149
vector149:
  pushl $0
8010637e:	6a 00                	push   $0x0
  pushl $149
80106380:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106385:	e9 d6 f5 ff ff       	jmp    80105960 <alltraps>

8010638a <vector150>:
.globl vector150
vector150:
  pushl $0
8010638a:	6a 00                	push   $0x0
  pushl $150
8010638c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106391:	e9 ca f5 ff ff       	jmp    80105960 <alltraps>

80106396 <vector151>:
.globl vector151
vector151:
  pushl $0
80106396:	6a 00                	push   $0x0
  pushl $151
80106398:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010639d:	e9 be f5 ff ff       	jmp    80105960 <alltraps>

801063a2 <vector152>:
.globl vector152
vector152:
  pushl $0
801063a2:	6a 00                	push   $0x0
  pushl $152
801063a4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063a9:	e9 b2 f5 ff ff       	jmp    80105960 <alltraps>

801063ae <vector153>:
.globl vector153
vector153:
  pushl $0
801063ae:	6a 00                	push   $0x0
  pushl $153
801063b0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063b5:	e9 a6 f5 ff ff       	jmp    80105960 <alltraps>

801063ba <vector154>:
.globl vector154
vector154:
  pushl $0
801063ba:	6a 00                	push   $0x0
  pushl $154
801063bc:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063c1:	e9 9a f5 ff ff       	jmp    80105960 <alltraps>

801063c6 <vector155>:
.globl vector155
vector155:
  pushl $0
801063c6:	6a 00                	push   $0x0
  pushl $155
801063c8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063cd:	e9 8e f5 ff ff       	jmp    80105960 <alltraps>

801063d2 <vector156>:
.globl vector156
vector156:
  pushl $0
801063d2:	6a 00                	push   $0x0
  pushl $156
801063d4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063d9:	e9 82 f5 ff ff       	jmp    80105960 <alltraps>

801063de <vector157>:
.globl vector157
vector157:
  pushl $0
801063de:	6a 00                	push   $0x0
  pushl $157
801063e0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063e5:	e9 76 f5 ff ff       	jmp    80105960 <alltraps>

801063ea <vector158>:
.globl vector158
vector158:
  pushl $0
801063ea:	6a 00                	push   $0x0
  pushl $158
801063ec:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063f1:	e9 6a f5 ff ff       	jmp    80105960 <alltraps>

801063f6 <vector159>:
.globl vector159
vector159:
  pushl $0
801063f6:	6a 00                	push   $0x0
  pushl $159
801063f8:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063fd:	e9 5e f5 ff ff       	jmp    80105960 <alltraps>

80106402 <vector160>:
.globl vector160
vector160:
  pushl $0
80106402:	6a 00                	push   $0x0
  pushl $160
80106404:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106409:	e9 52 f5 ff ff       	jmp    80105960 <alltraps>

8010640e <vector161>:
.globl vector161
vector161:
  pushl $0
8010640e:	6a 00                	push   $0x0
  pushl $161
80106410:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106415:	e9 46 f5 ff ff       	jmp    80105960 <alltraps>

8010641a <vector162>:
.globl vector162
vector162:
  pushl $0
8010641a:	6a 00                	push   $0x0
  pushl $162
8010641c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106421:	e9 3a f5 ff ff       	jmp    80105960 <alltraps>

80106426 <vector163>:
.globl vector163
vector163:
  pushl $0
80106426:	6a 00                	push   $0x0
  pushl $163
80106428:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010642d:	e9 2e f5 ff ff       	jmp    80105960 <alltraps>

80106432 <vector164>:
.globl vector164
vector164:
  pushl $0
80106432:	6a 00                	push   $0x0
  pushl $164
80106434:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106439:	e9 22 f5 ff ff       	jmp    80105960 <alltraps>

8010643e <vector165>:
.globl vector165
vector165:
  pushl $0
8010643e:	6a 00                	push   $0x0
  pushl $165
80106440:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106445:	e9 16 f5 ff ff       	jmp    80105960 <alltraps>

8010644a <vector166>:
.globl vector166
vector166:
  pushl $0
8010644a:	6a 00                	push   $0x0
  pushl $166
8010644c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106451:	e9 0a f5 ff ff       	jmp    80105960 <alltraps>

80106456 <vector167>:
.globl vector167
vector167:
  pushl $0
80106456:	6a 00                	push   $0x0
  pushl $167
80106458:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010645d:	e9 fe f4 ff ff       	jmp    80105960 <alltraps>

80106462 <vector168>:
.globl vector168
vector168:
  pushl $0
80106462:	6a 00                	push   $0x0
  pushl $168
80106464:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106469:	e9 f2 f4 ff ff       	jmp    80105960 <alltraps>

8010646e <vector169>:
.globl vector169
vector169:
  pushl $0
8010646e:	6a 00                	push   $0x0
  pushl $169
80106470:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106475:	e9 e6 f4 ff ff       	jmp    80105960 <alltraps>

8010647a <vector170>:
.globl vector170
vector170:
  pushl $0
8010647a:	6a 00                	push   $0x0
  pushl $170
8010647c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106481:	e9 da f4 ff ff       	jmp    80105960 <alltraps>

80106486 <vector171>:
.globl vector171
vector171:
  pushl $0
80106486:	6a 00                	push   $0x0
  pushl $171
80106488:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010648d:	e9 ce f4 ff ff       	jmp    80105960 <alltraps>

80106492 <vector172>:
.globl vector172
vector172:
  pushl $0
80106492:	6a 00                	push   $0x0
  pushl $172
80106494:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106499:	e9 c2 f4 ff ff       	jmp    80105960 <alltraps>

8010649e <vector173>:
.globl vector173
vector173:
  pushl $0
8010649e:	6a 00                	push   $0x0
  pushl $173
801064a0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064a5:	e9 b6 f4 ff ff       	jmp    80105960 <alltraps>

801064aa <vector174>:
.globl vector174
vector174:
  pushl $0
801064aa:	6a 00                	push   $0x0
  pushl $174
801064ac:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064b1:	e9 aa f4 ff ff       	jmp    80105960 <alltraps>

801064b6 <vector175>:
.globl vector175
vector175:
  pushl $0
801064b6:	6a 00                	push   $0x0
  pushl $175
801064b8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064bd:	e9 9e f4 ff ff       	jmp    80105960 <alltraps>

801064c2 <vector176>:
.globl vector176
vector176:
  pushl $0
801064c2:	6a 00                	push   $0x0
  pushl $176
801064c4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064c9:	e9 92 f4 ff ff       	jmp    80105960 <alltraps>

801064ce <vector177>:
.globl vector177
vector177:
  pushl $0
801064ce:	6a 00                	push   $0x0
  pushl $177
801064d0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064d5:	e9 86 f4 ff ff       	jmp    80105960 <alltraps>

801064da <vector178>:
.globl vector178
vector178:
  pushl $0
801064da:	6a 00                	push   $0x0
  pushl $178
801064dc:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064e1:	e9 7a f4 ff ff       	jmp    80105960 <alltraps>

801064e6 <vector179>:
.globl vector179
vector179:
  pushl $0
801064e6:	6a 00                	push   $0x0
  pushl $179
801064e8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064ed:	e9 6e f4 ff ff       	jmp    80105960 <alltraps>

801064f2 <vector180>:
.globl vector180
vector180:
  pushl $0
801064f2:	6a 00                	push   $0x0
  pushl $180
801064f4:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064f9:	e9 62 f4 ff ff       	jmp    80105960 <alltraps>

801064fe <vector181>:
.globl vector181
vector181:
  pushl $0
801064fe:	6a 00                	push   $0x0
  pushl $181
80106500:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106505:	e9 56 f4 ff ff       	jmp    80105960 <alltraps>

8010650a <vector182>:
.globl vector182
vector182:
  pushl $0
8010650a:	6a 00                	push   $0x0
  pushl $182
8010650c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106511:	e9 4a f4 ff ff       	jmp    80105960 <alltraps>

80106516 <vector183>:
.globl vector183
vector183:
  pushl $0
80106516:	6a 00                	push   $0x0
  pushl $183
80106518:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010651d:	e9 3e f4 ff ff       	jmp    80105960 <alltraps>

80106522 <vector184>:
.globl vector184
vector184:
  pushl $0
80106522:	6a 00                	push   $0x0
  pushl $184
80106524:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106529:	e9 32 f4 ff ff       	jmp    80105960 <alltraps>

8010652e <vector185>:
.globl vector185
vector185:
  pushl $0
8010652e:	6a 00                	push   $0x0
  pushl $185
80106530:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106535:	e9 26 f4 ff ff       	jmp    80105960 <alltraps>

8010653a <vector186>:
.globl vector186
vector186:
  pushl $0
8010653a:	6a 00                	push   $0x0
  pushl $186
8010653c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106541:	e9 1a f4 ff ff       	jmp    80105960 <alltraps>

80106546 <vector187>:
.globl vector187
vector187:
  pushl $0
80106546:	6a 00                	push   $0x0
  pushl $187
80106548:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010654d:	e9 0e f4 ff ff       	jmp    80105960 <alltraps>

80106552 <vector188>:
.globl vector188
vector188:
  pushl $0
80106552:	6a 00                	push   $0x0
  pushl $188
80106554:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106559:	e9 02 f4 ff ff       	jmp    80105960 <alltraps>

8010655e <vector189>:
.globl vector189
vector189:
  pushl $0
8010655e:	6a 00                	push   $0x0
  pushl $189
80106560:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106565:	e9 f6 f3 ff ff       	jmp    80105960 <alltraps>

8010656a <vector190>:
.globl vector190
vector190:
  pushl $0
8010656a:	6a 00                	push   $0x0
  pushl $190
8010656c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106571:	e9 ea f3 ff ff       	jmp    80105960 <alltraps>

80106576 <vector191>:
.globl vector191
vector191:
  pushl $0
80106576:	6a 00                	push   $0x0
  pushl $191
80106578:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010657d:	e9 de f3 ff ff       	jmp    80105960 <alltraps>

80106582 <vector192>:
.globl vector192
vector192:
  pushl $0
80106582:	6a 00                	push   $0x0
  pushl $192
80106584:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106589:	e9 d2 f3 ff ff       	jmp    80105960 <alltraps>

8010658e <vector193>:
.globl vector193
vector193:
  pushl $0
8010658e:	6a 00                	push   $0x0
  pushl $193
80106590:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106595:	e9 c6 f3 ff ff       	jmp    80105960 <alltraps>

8010659a <vector194>:
.globl vector194
vector194:
  pushl $0
8010659a:	6a 00                	push   $0x0
  pushl $194
8010659c:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065a1:	e9 ba f3 ff ff       	jmp    80105960 <alltraps>

801065a6 <vector195>:
.globl vector195
vector195:
  pushl $0
801065a6:	6a 00                	push   $0x0
  pushl $195
801065a8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065ad:	e9 ae f3 ff ff       	jmp    80105960 <alltraps>

801065b2 <vector196>:
.globl vector196
vector196:
  pushl $0
801065b2:	6a 00                	push   $0x0
  pushl $196
801065b4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065b9:	e9 a2 f3 ff ff       	jmp    80105960 <alltraps>

801065be <vector197>:
.globl vector197
vector197:
  pushl $0
801065be:	6a 00                	push   $0x0
  pushl $197
801065c0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065c5:	e9 96 f3 ff ff       	jmp    80105960 <alltraps>

801065ca <vector198>:
.globl vector198
vector198:
  pushl $0
801065ca:	6a 00                	push   $0x0
  pushl $198
801065cc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065d1:	e9 8a f3 ff ff       	jmp    80105960 <alltraps>

801065d6 <vector199>:
.globl vector199
vector199:
  pushl $0
801065d6:	6a 00                	push   $0x0
  pushl $199
801065d8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065dd:	e9 7e f3 ff ff       	jmp    80105960 <alltraps>

801065e2 <vector200>:
.globl vector200
vector200:
  pushl $0
801065e2:	6a 00                	push   $0x0
  pushl $200
801065e4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065e9:	e9 72 f3 ff ff       	jmp    80105960 <alltraps>

801065ee <vector201>:
.globl vector201
vector201:
  pushl $0
801065ee:	6a 00                	push   $0x0
  pushl $201
801065f0:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065f5:	e9 66 f3 ff ff       	jmp    80105960 <alltraps>

801065fa <vector202>:
.globl vector202
vector202:
  pushl $0
801065fa:	6a 00                	push   $0x0
  pushl $202
801065fc:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106601:	e9 5a f3 ff ff       	jmp    80105960 <alltraps>

80106606 <vector203>:
.globl vector203
vector203:
  pushl $0
80106606:	6a 00                	push   $0x0
  pushl $203
80106608:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010660d:	e9 4e f3 ff ff       	jmp    80105960 <alltraps>

80106612 <vector204>:
.globl vector204
vector204:
  pushl $0
80106612:	6a 00                	push   $0x0
  pushl $204
80106614:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106619:	e9 42 f3 ff ff       	jmp    80105960 <alltraps>

8010661e <vector205>:
.globl vector205
vector205:
  pushl $0
8010661e:	6a 00                	push   $0x0
  pushl $205
80106620:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106625:	e9 36 f3 ff ff       	jmp    80105960 <alltraps>

8010662a <vector206>:
.globl vector206
vector206:
  pushl $0
8010662a:	6a 00                	push   $0x0
  pushl $206
8010662c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106631:	e9 2a f3 ff ff       	jmp    80105960 <alltraps>

80106636 <vector207>:
.globl vector207
vector207:
  pushl $0
80106636:	6a 00                	push   $0x0
  pushl $207
80106638:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010663d:	e9 1e f3 ff ff       	jmp    80105960 <alltraps>

80106642 <vector208>:
.globl vector208
vector208:
  pushl $0
80106642:	6a 00                	push   $0x0
  pushl $208
80106644:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106649:	e9 12 f3 ff ff       	jmp    80105960 <alltraps>

8010664e <vector209>:
.globl vector209
vector209:
  pushl $0
8010664e:	6a 00                	push   $0x0
  pushl $209
80106650:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106655:	e9 06 f3 ff ff       	jmp    80105960 <alltraps>

8010665a <vector210>:
.globl vector210
vector210:
  pushl $0
8010665a:	6a 00                	push   $0x0
  pushl $210
8010665c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106661:	e9 fa f2 ff ff       	jmp    80105960 <alltraps>

80106666 <vector211>:
.globl vector211
vector211:
  pushl $0
80106666:	6a 00                	push   $0x0
  pushl $211
80106668:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010666d:	e9 ee f2 ff ff       	jmp    80105960 <alltraps>

80106672 <vector212>:
.globl vector212
vector212:
  pushl $0
80106672:	6a 00                	push   $0x0
  pushl $212
80106674:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106679:	e9 e2 f2 ff ff       	jmp    80105960 <alltraps>

8010667e <vector213>:
.globl vector213
vector213:
  pushl $0
8010667e:	6a 00                	push   $0x0
  pushl $213
80106680:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106685:	e9 d6 f2 ff ff       	jmp    80105960 <alltraps>

8010668a <vector214>:
.globl vector214
vector214:
  pushl $0
8010668a:	6a 00                	push   $0x0
  pushl $214
8010668c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106691:	e9 ca f2 ff ff       	jmp    80105960 <alltraps>

80106696 <vector215>:
.globl vector215
vector215:
  pushl $0
80106696:	6a 00                	push   $0x0
  pushl $215
80106698:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010669d:	e9 be f2 ff ff       	jmp    80105960 <alltraps>

801066a2 <vector216>:
.globl vector216
vector216:
  pushl $0
801066a2:	6a 00                	push   $0x0
  pushl $216
801066a4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066a9:	e9 b2 f2 ff ff       	jmp    80105960 <alltraps>

801066ae <vector217>:
.globl vector217
vector217:
  pushl $0
801066ae:	6a 00                	push   $0x0
  pushl $217
801066b0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066b5:	e9 a6 f2 ff ff       	jmp    80105960 <alltraps>

801066ba <vector218>:
.globl vector218
vector218:
  pushl $0
801066ba:	6a 00                	push   $0x0
  pushl $218
801066bc:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066c1:	e9 9a f2 ff ff       	jmp    80105960 <alltraps>

801066c6 <vector219>:
.globl vector219
vector219:
  pushl $0
801066c6:	6a 00                	push   $0x0
  pushl $219
801066c8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066cd:	e9 8e f2 ff ff       	jmp    80105960 <alltraps>

801066d2 <vector220>:
.globl vector220
vector220:
  pushl $0
801066d2:	6a 00                	push   $0x0
  pushl $220
801066d4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066d9:	e9 82 f2 ff ff       	jmp    80105960 <alltraps>

801066de <vector221>:
.globl vector221
vector221:
  pushl $0
801066de:	6a 00                	push   $0x0
  pushl $221
801066e0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066e5:	e9 76 f2 ff ff       	jmp    80105960 <alltraps>

801066ea <vector222>:
.globl vector222
vector222:
  pushl $0
801066ea:	6a 00                	push   $0x0
  pushl $222
801066ec:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066f1:	e9 6a f2 ff ff       	jmp    80105960 <alltraps>

801066f6 <vector223>:
.globl vector223
vector223:
  pushl $0
801066f6:	6a 00                	push   $0x0
  pushl $223
801066f8:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066fd:	e9 5e f2 ff ff       	jmp    80105960 <alltraps>

80106702 <vector224>:
.globl vector224
vector224:
  pushl $0
80106702:	6a 00                	push   $0x0
  pushl $224
80106704:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106709:	e9 52 f2 ff ff       	jmp    80105960 <alltraps>

8010670e <vector225>:
.globl vector225
vector225:
  pushl $0
8010670e:	6a 00                	push   $0x0
  pushl $225
80106710:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106715:	e9 46 f2 ff ff       	jmp    80105960 <alltraps>

8010671a <vector226>:
.globl vector226
vector226:
  pushl $0
8010671a:	6a 00                	push   $0x0
  pushl $226
8010671c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106721:	e9 3a f2 ff ff       	jmp    80105960 <alltraps>

80106726 <vector227>:
.globl vector227
vector227:
  pushl $0
80106726:	6a 00                	push   $0x0
  pushl $227
80106728:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010672d:	e9 2e f2 ff ff       	jmp    80105960 <alltraps>

80106732 <vector228>:
.globl vector228
vector228:
  pushl $0
80106732:	6a 00                	push   $0x0
  pushl $228
80106734:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106739:	e9 22 f2 ff ff       	jmp    80105960 <alltraps>

8010673e <vector229>:
.globl vector229
vector229:
  pushl $0
8010673e:	6a 00                	push   $0x0
  pushl $229
80106740:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106745:	e9 16 f2 ff ff       	jmp    80105960 <alltraps>

8010674a <vector230>:
.globl vector230
vector230:
  pushl $0
8010674a:	6a 00                	push   $0x0
  pushl $230
8010674c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106751:	e9 0a f2 ff ff       	jmp    80105960 <alltraps>

80106756 <vector231>:
.globl vector231
vector231:
  pushl $0
80106756:	6a 00                	push   $0x0
  pushl $231
80106758:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010675d:	e9 fe f1 ff ff       	jmp    80105960 <alltraps>

80106762 <vector232>:
.globl vector232
vector232:
  pushl $0
80106762:	6a 00                	push   $0x0
  pushl $232
80106764:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106769:	e9 f2 f1 ff ff       	jmp    80105960 <alltraps>

8010676e <vector233>:
.globl vector233
vector233:
  pushl $0
8010676e:	6a 00                	push   $0x0
  pushl $233
80106770:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106775:	e9 e6 f1 ff ff       	jmp    80105960 <alltraps>

8010677a <vector234>:
.globl vector234
vector234:
  pushl $0
8010677a:	6a 00                	push   $0x0
  pushl $234
8010677c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106781:	e9 da f1 ff ff       	jmp    80105960 <alltraps>

80106786 <vector235>:
.globl vector235
vector235:
  pushl $0
80106786:	6a 00                	push   $0x0
  pushl $235
80106788:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010678d:	e9 ce f1 ff ff       	jmp    80105960 <alltraps>

80106792 <vector236>:
.globl vector236
vector236:
  pushl $0
80106792:	6a 00                	push   $0x0
  pushl $236
80106794:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106799:	e9 c2 f1 ff ff       	jmp    80105960 <alltraps>

8010679e <vector237>:
.globl vector237
vector237:
  pushl $0
8010679e:	6a 00                	push   $0x0
  pushl $237
801067a0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067a5:	e9 b6 f1 ff ff       	jmp    80105960 <alltraps>

801067aa <vector238>:
.globl vector238
vector238:
  pushl $0
801067aa:	6a 00                	push   $0x0
  pushl $238
801067ac:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067b1:	e9 aa f1 ff ff       	jmp    80105960 <alltraps>

801067b6 <vector239>:
.globl vector239
vector239:
  pushl $0
801067b6:	6a 00                	push   $0x0
  pushl $239
801067b8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067bd:	e9 9e f1 ff ff       	jmp    80105960 <alltraps>

801067c2 <vector240>:
.globl vector240
vector240:
  pushl $0
801067c2:	6a 00                	push   $0x0
  pushl $240
801067c4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067c9:	e9 92 f1 ff ff       	jmp    80105960 <alltraps>

801067ce <vector241>:
.globl vector241
vector241:
  pushl $0
801067ce:	6a 00                	push   $0x0
  pushl $241
801067d0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067d5:	e9 86 f1 ff ff       	jmp    80105960 <alltraps>

801067da <vector242>:
.globl vector242
vector242:
  pushl $0
801067da:	6a 00                	push   $0x0
  pushl $242
801067dc:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067e1:	e9 7a f1 ff ff       	jmp    80105960 <alltraps>

801067e6 <vector243>:
.globl vector243
vector243:
  pushl $0
801067e6:	6a 00                	push   $0x0
  pushl $243
801067e8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067ed:	e9 6e f1 ff ff       	jmp    80105960 <alltraps>

801067f2 <vector244>:
.globl vector244
vector244:
  pushl $0
801067f2:	6a 00                	push   $0x0
  pushl $244
801067f4:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067f9:	e9 62 f1 ff ff       	jmp    80105960 <alltraps>

801067fe <vector245>:
.globl vector245
vector245:
  pushl $0
801067fe:	6a 00                	push   $0x0
  pushl $245
80106800:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106805:	e9 56 f1 ff ff       	jmp    80105960 <alltraps>

8010680a <vector246>:
.globl vector246
vector246:
  pushl $0
8010680a:	6a 00                	push   $0x0
  pushl $246
8010680c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106811:	e9 4a f1 ff ff       	jmp    80105960 <alltraps>

80106816 <vector247>:
.globl vector247
vector247:
  pushl $0
80106816:	6a 00                	push   $0x0
  pushl $247
80106818:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010681d:	e9 3e f1 ff ff       	jmp    80105960 <alltraps>

80106822 <vector248>:
.globl vector248
vector248:
  pushl $0
80106822:	6a 00                	push   $0x0
  pushl $248
80106824:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106829:	e9 32 f1 ff ff       	jmp    80105960 <alltraps>

8010682e <vector249>:
.globl vector249
vector249:
  pushl $0
8010682e:	6a 00                	push   $0x0
  pushl $249
80106830:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106835:	e9 26 f1 ff ff       	jmp    80105960 <alltraps>

8010683a <vector250>:
.globl vector250
vector250:
  pushl $0
8010683a:	6a 00                	push   $0x0
  pushl $250
8010683c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106841:	e9 1a f1 ff ff       	jmp    80105960 <alltraps>

80106846 <vector251>:
.globl vector251
vector251:
  pushl $0
80106846:	6a 00                	push   $0x0
  pushl $251
80106848:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010684d:	e9 0e f1 ff ff       	jmp    80105960 <alltraps>

80106852 <vector252>:
.globl vector252
vector252:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $252
80106854:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106859:	e9 02 f1 ff ff       	jmp    80105960 <alltraps>

8010685e <vector253>:
.globl vector253
vector253:
  pushl $0
8010685e:	6a 00                	push   $0x0
  pushl $253
80106860:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106865:	e9 f6 f0 ff ff       	jmp    80105960 <alltraps>

8010686a <vector254>:
.globl vector254
vector254:
  pushl $0
8010686a:	6a 00                	push   $0x0
  pushl $254
8010686c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106871:	e9 ea f0 ff ff       	jmp    80105960 <alltraps>

80106876 <vector255>:
.globl vector255
vector255:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $255
80106878:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010687d:	e9 de f0 ff ff       	jmp    80105960 <alltraps>
	...

80106890 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106890:	a1 24 57 11 80       	mov    0x80115724,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106895:	55                   	push   %ebp
80106896:	89 e5                	mov    %esp,%ebp
80106898:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010689d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
801068a0:	5d                   	pop    %ebp
801068a1:	c3                   	ret    
801068a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068b0:	55                   	push   %ebp
801068b1:	89 e5                	mov    %esp,%ebp
801068b3:	83 ec 28             	sub    $0x28,%esp
801068b6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068b9:	89 d3                	mov    %edx,%ebx
801068bb:	c1 eb 16             	shr    $0x16,%ebx
801068be:	8d 1c 98             	lea    (%eax,%ebx,4),%ebx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068c1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801068c4:	8b 33                	mov    (%ebx),%esi
801068c6:	f7 c6 01 00 00 00    	test   $0x1,%esi
801068cc:	74 22                	je     801068f0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068ce:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801068d4:	81 ee 00 00 00 80    	sub    $0x80000000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068da:	c1 ea 0a             	shr    $0xa,%edx
801068dd:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801068e3:	8d 04 16             	lea    (%esi,%edx,1),%eax
}
801068e6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801068e9:	8b 75 fc             	mov    -0x4(%ebp),%esi
801068ec:	89 ec                	mov    %ebp,%esp
801068ee:	5d                   	pop    %ebp
801068ef:	c3                   	ret    

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068f0:	85 c9                	test   %ecx,%ecx
801068f2:	75 04                	jne    801068f8 <walkpgdir+0x48>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068f4:	31 c0                	xor    %eax,%eax
801068f6:	eb ee                	jmp    801068e6 <walkpgdir+0x36>

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
801068fb:	e8 70 ba ff ff       	call   80102370 <kalloc>
80106900:	85 c0                	test   %eax,%eax
80106902:	89 c6                	mov    %eax,%esi
80106904:	74 ee                	je     801068f4 <walkpgdir+0x44>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80106906:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010690d:	00 
8010690e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106915:	00 
80106916:	89 04 24             	mov    %eax,(%esp)
80106919:	e8 22 dd ff ff       	call   80104640 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010691e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106924:	83 c8 07             	or     $0x7,%eax
80106927:	89 03                	mov    %eax,(%ebx)
80106929:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010692c:	eb ac                	jmp    801068da <walkpgdir+0x2a>
8010692e:	66 90                	xchg   %ax,%ax

80106930 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106930:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106931:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106933:	89 e5                	mov    %esp,%ebp
80106935:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106938:	8b 55 0c             	mov    0xc(%ebp),%edx
8010693b:	8b 45 08             	mov    0x8(%ebp),%eax
8010693e:	e8 6d ff ff ff       	call   801068b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106943:	8b 00                	mov    (%eax),%eax
80106945:	a8 01                	test   $0x1,%al
80106947:	75 07                	jne    80106950 <uva2ka+0x20>
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106949:	31 c0                	xor    %eax,%eax
}
8010694b:	c9                   	leave  
8010694c:	c3                   	ret    
8010694d:	8d 76 00             	lea    0x0(%esi),%esi
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
80106950:	a8 04                	test   $0x4,%al
80106952:	74 f5                	je     80106949 <uva2ka+0x19>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106954:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106959:	2d 00 00 00 80       	sub    $0x80000000,%eax
}
8010695e:	c9                   	leave  
8010695f:	c3                   	ret    

80106960 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	57                   	push   %edi
80106964:	56                   	push   %esi
80106965:	53                   	push   %ebx
80106966:	83 ec 2c             	sub    $0x2c,%esp
80106969:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010696c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010696f:	85 db                	test   %ebx,%ebx
80106971:	74 75                	je     801069e8 <copyout+0x88>
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80106973:	8b 45 10             	mov    0x10(%ebp),%eax
80106976:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106979:	eb 39                	jmp    801069b4 <copyout+0x54>
8010697b:	90                   	nop
8010697c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106980:	89 f7                	mov    %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106982:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106985:	29 d7                	sub    %edx,%edi
80106987:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010698d:	39 df                	cmp    %ebx,%edi
8010698f:	0f 47 fb             	cmova  %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106992:	29 f2                	sub    %esi,%edx
80106994:	8d 14 10             	lea    (%eax,%edx,1),%edx
80106997:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010699b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010699f:	89 14 24             	mov    %edx,(%esp)
801069a2:	e8 69 dd ff ff       	call   80104710 <memmove>
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801069a7:	29 fb                	sub    %edi,%ebx
801069a9:	74 3d                	je     801069e8 <copyout+0x88>
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801069ab:	01 7d e4             	add    %edi,-0x1c(%ebp)
    va = va0 + PGSIZE;
801069ae:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
801069b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801069b7:	89 d6                	mov    %edx,%esi
801069b9:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801069bf:	89 55 e0             	mov    %edx,-0x20(%ebp)
801069c2:	89 74 24 04          	mov    %esi,0x4(%esp)
801069c6:	89 0c 24             	mov    %ecx,(%esp)
801069c9:	e8 62 ff ff ff       	call   80106930 <uva2ka>
    if(pa0 == 0)
801069ce:	8b 55 e0             	mov    -0x20(%ebp),%edx
801069d1:	85 c0                	test   %eax,%eax
801069d3:	75 ab                	jne    80106980 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801069d5:	83 c4 2c             	add    $0x2c,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801069d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801069dd:	5b                   	pop    %ebx
801069de:	5e                   	pop    %esi
801069df:	5f                   	pop    %edi
801069e0:	5d                   	pop    %ebp
801069e1:	c3                   	ret    
801069e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069e8:	83 c4 2c             	add    $0x2c,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801069eb:	31 c0                	xor    %eax,%eax
  }
  return 0;
}
801069ed:	5b                   	pop    %ebx
801069ee:	5e                   	pop    %esi
801069ef:	5f                   	pop    %edi
801069f0:	5d                   	pop    %ebp
801069f1:	c3                   	ret    
801069f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a00 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	57                   	push   %edi
80106a04:	56                   	push   %esi
80106a05:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a06:	89 d3                	mov    %edx,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a08:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a0c:	83 ec 2c             	sub    $0x2c,%esp
80106a0f:	8b 75 08             	mov    0x8(%ebp),%esi
80106a12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a15:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a1b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a21:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
80106a25:	eb 1d                	jmp    80106a44 <mappages+0x44>
80106a27:	90                   	nop
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a28:	f6 00 01             	testb  $0x1,(%eax)
80106a2b:	75 45                	jne    80106a72 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a2d:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a30:	09 f2                	or     %esi,%edx
    if(a == last)
80106a32:	39 fb                	cmp    %edi,%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a34:	89 10                	mov    %edx,(%eax)
    if(a == last)
80106a36:	74 30                	je     80106a68 <mappages+0x68>
      break;
    a += PGSIZE;
80106a38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
80106a3e:	81 c6 00 10 00 00    	add    $0x1000,%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a47:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a4c:	89 da                	mov    %ebx,%edx
80106a4e:	e8 5d fe ff ff       	call   801068b0 <walkpgdir>
80106a53:	85 c0                	test   %eax,%eax
80106a55:	75 d1                	jne    80106a28 <mappages+0x28>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a57:	83 c4 2c             	add    $0x2c,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
80106a5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
80106a5f:	5b                   	pop    %ebx
80106a60:	5e                   	pop    %esi
80106a61:	5f                   	pop    %edi
80106a62:	5d                   	pop    %ebp
80106a63:	c3                   	ret    
80106a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a68:	83 c4 2c             	add    $0x2c,%esp
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
80106a6b:	31 c0                	xor    %eax,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a6d:	5b                   	pop    %ebx
80106a6e:	5e                   	pop    %esi
80106a6f:	5f                   	pop    %edi
80106a70:	5d                   	pop    %ebp
80106a71:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a72:	c7 04 24 58 7a 10 80 	movl   $0x80107a58,(%esp)
80106a79:	e8 52 99 ff ff       	call   801003d0 <panic>
80106a7e:	66 90                	xchg   %ax,%ax

80106a80 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	56                   	push   %esi
80106a84:	53                   	push   %ebx
80106a85:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106a88:	e8 e3 b8 ff ff       	call   80102370 <kalloc>
80106a8d:	85 c0                	test   %eax,%eax
80106a8f:	89 c6                	mov    %eax,%esi
80106a91:	74 53                	je     80106ae6 <setupkvm+0x66>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106a93:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a9a:	00 
80106a9b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106aa2:	00 
80106aa3:	89 04 24             	mov    %eax,(%esp)
80106aa6:	e8 95 db ff ff       	call   80104640 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106aab:	b8 60 a4 10 80       	mov    $0x8010a460,%eax
80106ab0:	3d 20 a4 10 80       	cmp    $0x8010a420,%eax
80106ab5:	76 2f                	jbe    80106ae6 <setupkvm+0x66>
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
80106ab7:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106abc:	8b 53 0c             	mov    0xc(%ebx),%edx
80106abf:	8b 43 04             	mov    0x4(%ebx),%eax
80106ac2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ac5:	89 54 24 04          	mov    %edx,0x4(%esp)
80106ac9:	8b 13                	mov    (%ebx),%edx
80106acb:	89 04 24             	mov    %eax,(%esp)
80106ace:	29 c1                	sub    %eax,%ecx
80106ad0:	89 f0                	mov    %esi,%eax
80106ad2:	e8 29 ff ff ff       	call   80106a00 <mappages>
80106ad7:	85 c0                	test   %eax,%eax
80106ad9:	78 15                	js     80106af0 <setupkvm+0x70>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106adb:	83 c3 10             	add    $0x10,%ebx
80106ade:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ae4:	75 d6                	jne    80106abc <setupkvm+0x3c>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106ae6:	83 c4 10             	add    $0x10,%esp
80106ae9:	89 f0                	mov    %esi,%eax
80106aeb:	5b                   	pop    %ebx
80106aec:	5e                   	pop    %esi
80106aed:	5d                   	pop    %ebp
80106aee:	c3                   	ret    
80106aef:	90                   	nop
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106af0:	31 f6                	xor    %esi,%esi
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106af2:	83 c4 10             	add    $0x10,%esp
80106af5:	89 f0                	mov    %esi,%eax
80106af7:	5b                   	pop    %ebx
80106af8:	5e                   	pop    %esi
80106af9:	5d                   	pop    %ebp
80106afa:	c3                   	ret    
80106afb:	90                   	nop
80106afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b00 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b06:	e8 75 ff ff ff       	call   80106a80 <setupkvm>
80106b0b:	a3 24 57 11 80       	mov    %eax,0x80115724
80106b10:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106b15:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106b18:	c9                   	leave  
80106b19:	c3                   	ret    
80106b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b20 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b20:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b21:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b23:	89 e5                	mov    %esp,%ebp
80106b25:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b28:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b2b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2e:	e8 7d fd ff ff       	call   801068b0 <walkpgdir>
  if(pte == 0)
80106b33:	85 c0                	test   %eax,%eax
80106b35:	74 05                	je     80106b3c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b37:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b3a:	c9                   	leave  
80106b3b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106b3c:	c7 04 24 5e 7a 10 80 	movl   $0x80107a5e,(%esp)
80106b43:	e8 88 98 ff ff       	call   801003d0 <panic>
80106b48:	90                   	nop
80106b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b50 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	83 ec 38             	sub    $0x38,%esp
80106b56:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106b59:	8b 75 10             	mov    0x10(%ebp),%esi
80106b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106b62:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106b65:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106b68:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106b6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106b71:	77 59                	ja     80106bcc <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
80106b73:	e8 f8 b7 ff ff       	call   80102370 <kalloc>
  memset(mem, 0, PGSIZE);
80106b78:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b7f:	00 
80106b80:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b87:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106b88:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b8a:	89 04 24             	mov    %eax,(%esp)
80106b8d:	e8 ae da ff ff       	call   80104640 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b92:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b98:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b9d:	89 04 24             	mov    %eax,(%esp)
80106ba0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ba3:	31 d2                	xor    %edx,%edx
80106ba5:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106bac:	00 
80106bad:	e8 4e fe ff ff       	call   80106a00 <mappages>
  memmove(mem, init, sz);
80106bb2:	89 75 10             	mov    %esi,0x10(%ebp)
}
80106bb5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106bb8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
80106bbb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106bbe:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106bc1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106bc4:	89 ec                	mov    %ebp,%esp
80106bc6:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106bc7:	e9 44 db ff ff       	jmp    80104710 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106bcc:	c7 04 24 68 7a 10 80 	movl   $0x80107a68,(%esp)
80106bd3:	e8 f8 97 ff ff       	call   801003d0 <panic>
80106bd8:	90                   	nop
80106bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106be0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 2c             	sub    $0x2c,%esp
80106be9:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bec:	39 75 10             	cmp    %esi,0x10(%ebp)
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106bef:	8b 7d 08             	mov    0x8(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;
80106bf2:	89 f0                	mov    %esi,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bf4:	73 75                	jae    80106c6b <deallocuvm+0x8b>
    return oldsz;

  a = PGROUNDUP(newsz);
80106bf6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80106bf9:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80106bff:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106c05:	39 de                	cmp    %ebx,%esi
80106c07:	77 3a                	ja     80106c43 <deallocuvm+0x63>
80106c09:	eb 5d                	jmp    80106c68 <deallocuvm+0x88>
80106c0b:	90                   	nop
80106c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106c10:	8b 10                	mov    (%eax),%edx
80106c12:	f6 c2 01             	test   $0x1,%dl
80106c15:	74 22                	je     80106c39 <deallocuvm+0x59>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106c17:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106c1d:	74 54                	je     80106c73 <deallocuvm+0x93>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106c1f:	81 ea 00 00 00 80    	sub    $0x80000000,%edx
80106c25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c28:	89 14 24             	mov    %edx,(%esp)
80106c2b:	e8 90 b7 ff ff       	call   801023c0 <kfree>
      *pte = 0;
80106c30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c33:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106c39:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c3f:	39 de                	cmp    %ebx,%esi
80106c41:	76 25                	jbe    80106c68 <deallocuvm+0x88>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106c43:	31 c9                	xor    %ecx,%ecx
80106c45:	89 da                	mov    %ebx,%edx
80106c47:	89 f8                	mov    %edi,%eax
80106c49:	e8 62 fc ff ff       	call   801068b0 <walkpgdir>
    if(!pte)
80106c4e:	85 c0                	test   %eax,%eax
80106c50:	75 be                	jne    80106c10 <deallocuvm+0x30>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106c52:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106c58:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106c5e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c64:	39 de                	cmp    %ebx,%esi
80106c66:	77 db                	ja     80106c43 <deallocuvm+0x63>
      char *v = P2V(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80106c68:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106c6b:	83 c4 2c             	add    $0x2c,%esp
80106c6e:	5b                   	pop    %ebx
80106c6f:	5e                   	pop    %esi
80106c70:	5f                   	pop    %edi
80106c71:	5d                   	pop    %ebp
80106c72:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106c73:	c7 04 24 12 74 10 80 	movl   $0x80107412,(%esp)
80106c7a:	e8 51 97 ff ff       	call   801003d0 <panic>
80106c7f:	90                   	nop

80106c80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	56                   	push   %esi
80106c84:	53                   	push   %ebx
80106c85:	83 ec 10             	sub    $0x10,%esp
80106c88:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint i;

  if(pgdir == 0)
80106c8b:	85 db                	test   %ebx,%ebx
80106c8d:	74 5e                	je     80106ced <freevm+0x6d>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106c8f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106c96:	00 
80106c97:	31 f6                	xor    %esi,%esi
80106c99:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80106ca0:	80 
80106ca1:	89 1c 24             	mov    %ebx,(%esp)
80106ca4:	e8 37 ff ff ff       	call   80106be0 <deallocuvm>
80106ca9:	eb 10                	jmp    80106cbb <freevm+0x3b>
80106cab:	90                   	nop
80106cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NPDENTRIES; i++){
80106cb0:	83 c6 01             	add    $0x1,%esi
80106cb3:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106cb9:	74 24                	je     80106cdf <freevm+0x5f>
    if(pgdir[i] & PTE_P){
80106cbb:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
80106cbe:	a8 01                	test   $0x1,%al
80106cc0:	74 ee                	je     80106cb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cc2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cc7:	83 c6 01             	add    $0x1,%esi
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cca:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106ccf:	89 04 24             	mov    %eax,(%esp)
80106cd2:	e8 e9 b6 ff ff       	call   801023c0 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cd7:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106cdd:	75 dc                	jne    80106cbb <freevm+0x3b>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106cdf:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106ce2:	83 c4 10             	add    $0x10,%esp
80106ce5:	5b                   	pop    %ebx
80106ce6:	5e                   	pop    %esi
80106ce7:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106ce8:	e9 d3 b6 ff ff       	jmp    801023c0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106ced:	c7 04 24 82 7a 10 80 	movl   $0x80107a82,(%esp)
80106cf4:	e8 d7 96 ff ff       	call   801003d0 <panic>
80106cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106d09:	e8 72 fd ff ff       	call   80106a80 <setupkvm>
80106d0e:	85 c0                	test   %eax,%eax
80106d10:	89 c6                	mov    %eax,%esi
80106d12:	0f 84 91 00 00 00    	je     80106da9 <copyuvm+0xa9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d18:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d1b:	85 c0                	test   %eax,%eax
80106d1d:	0f 84 86 00 00 00    	je     80106da9 <copyuvm+0xa9>
80106d23:	31 db                	xor    %ebx,%ebx
80106d25:	eb 54                	jmp    80106d7b <copyuvm+0x7b>
80106d27:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d2b:	89 3c 24             	mov    %edi,(%esp)
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106d2e:	81 ef 00 00 00 80    	sub    $0x80000000,%edi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d34:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106d3b:	00 
80106d3c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d41:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106d46:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d4a:	e8 c1 d9 ff ff       	call   80104710 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106d4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d52:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d57:	89 da                	mov    %ebx,%edx
80106d59:	89 3c 24             	mov    %edi,(%esp)
80106d5c:	25 ff 0f 00 00       	and    $0xfff,%eax
80106d61:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d65:	89 f0                	mov    %esi,%eax
80106d67:	e8 94 fc ff ff       	call   80106a00 <mappages>
80106d6c:	85 c0                	test   %eax,%eax
80106d6e:	78 2f                	js     80106d9f <copyuvm+0x9f>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d70:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d76:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106d79:	76 2e                	jbe    80106da9 <copyuvm+0xa9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7e:	31 c9                	xor    %ecx,%ecx
80106d80:	89 da                	mov    %ebx,%edx
80106d82:	e8 29 fb ff ff       	call   801068b0 <walkpgdir>
80106d87:	85 c0                	test   %eax,%eax
80106d89:	74 28                	je     80106db3 <copyuvm+0xb3>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106d8b:	8b 00                	mov    (%eax),%eax
80106d8d:	a8 01                	test   $0x1,%al
80106d8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d92:	74 2b                	je     80106dbf <copyuvm+0xbf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106d94:	e8 d7 b5 ff ff       	call   80102370 <kalloc>
80106d99:	85 c0                	test   %eax,%eax
80106d9b:	89 c7                	mov    %eax,%edi
80106d9d:	75 89                	jne    80106d28 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106d9f:	89 34 24             	mov    %esi,(%esp)
80106da2:	31 f6                	xor    %esi,%esi
80106da4:	e8 d7 fe ff ff       	call   80106c80 <freevm>
  return 0;
}
80106da9:	83 c4 2c             	add    $0x2c,%esp
80106dac:	89 f0                	mov    %esi,%eax
80106dae:	5b                   	pop    %ebx
80106daf:	5e                   	pop    %esi
80106db0:	5f                   	pop    %edi
80106db1:	5d                   	pop    %ebp
80106db2:	c3                   	ret    

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106db3:	c7 04 24 93 7a 10 80 	movl   $0x80107a93,(%esp)
80106dba:	e8 11 96 ff ff       	call   801003d0 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106dbf:	c7 04 24 ad 7a 10 80 	movl   $0x80107aad,(%esp)
80106dc6:	e8 05 96 ff ff       	call   801003d0 <panic>
80106dcb:	90                   	nop
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106dd0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	57                   	push   %edi
80106dd4:	56                   	push   %esi
80106dd5:	53                   	push   %ebx
80106dd6:	83 ec 2c             	sub    $0x2c,%esp
80106dd9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106ddc:	85 ff                	test   %edi,%edi
80106dde:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106de1:	0f 88 9c 00 00 00    	js     80106e83 <allocuvm+0xb3>
    return 0;
  if(newsz < oldsz)
80106de7:	8b 45 0c             	mov    0xc(%ebp),%eax
80106dea:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80106ded:	0f 82 a5 00 00 00    	jb     80106e98 <allocuvm+0xc8>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106df3:	8b 75 0c             	mov    0xc(%ebp),%esi
80106df6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80106dfc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106e02:	39 f7                	cmp    %esi,%edi
80106e04:	77 50                	ja     80106e56 <allocuvm+0x86>
80106e06:	e9 90 00 00 00       	jmp    80106e9b <allocuvm+0xcb>
80106e0b:	90                   	nop
80106e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e10:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106e17:	00 
80106e18:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106e1f:	00 
80106e20:	89 04 24             	mov    %eax,(%esp)
80106e23:	e8 18 d8 ff ff       	call   80104640 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e28:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e2e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e33:	89 04 24             	mov    %eax,(%esp)
80106e36:	8b 45 08             	mov    0x8(%ebp),%eax
80106e39:	89 f2                	mov    %esi,%edx
80106e3b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106e42:	00 
80106e43:	e8 b8 fb ff ff       	call   80106a00 <mappages>
80106e48:	85 c0                	test   %eax,%eax
80106e4a:	78 5c                	js     80106ea8 <allocuvm+0xd8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e4c:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106e52:	39 f7                	cmp    %esi,%edi
80106e54:	76 45                	jbe    80106e9b <allocuvm+0xcb>
    mem = kalloc();
80106e56:	e8 15 b5 ff ff       	call   80102370 <kalloc>
    if(mem == 0){
80106e5b:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e5d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106e5f:	75 af                	jne    80106e10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e61:	c7 04 24 c7 7a 10 80 	movl   $0x80107ac7,(%esp)
80106e68:	e8 03 9a ff ff       	call   80100870 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e70:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106e74:	89 44 24 08          	mov    %eax,0x8(%esp)
80106e78:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7b:	89 04 24             	mov    %eax,(%esp)
80106e7e:	e8 5d fd ff ff       	call   80106be0 <deallocuvm>
80106e83:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e8d:	83 c4 2c             	add    $0x2c,%esp
80106e90:	5b                   	pop    %ebx
80106e91:	5e                   	pop    %esi
80106e92:	5f                   	pop    %edi
80106e93:	5d                   	pop    %ebp
80106e94:	c3                   	ret    
80106e95:	8d 76 00             	lea    0x0(%esi),%esi
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;
80106e98:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e9e:	83 c4 2c             	add    $0x2c,%esp
80106ea1:	5b                   	pop    %ebx
80106ea2:	5e                   	pop    %esi
80106ea3:	5f                   	pop    %edi
80106ea4:	5d                   	pop    %ebp
80106ea5:	c3                   	ret    
80106ea6:	66 90                	xchg   %ax,%ax
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ea8:	c7 04 24 df 7a 10 80 	movl   $0x80107adf,(%esp)
80106eaf:	e8 bc 99 ff ff       	call   80100870 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
80106eb7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106ebb:	89 44 24 08          	mov    %eax,0x8(%esp)
80106ebf:	8b 45 08             	mov    0x8(%ebp),%eax
80106ec2:	89 04 24             	mov    %eax,(%esp)
80106ec5:	e8 16 fd ff ff       	call   80106be0 <deallocuvm>
      kfree(mem);
80106eca:	89 1c 24             	mov    %ebx,(%esp)
80106ecd:	e8 ee b4 ff ff       	call   801023c0 <kfree>
80106ed2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      return 0;
    }
  }
  return newsz;
}
80106ed9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106edc:	83 c4 2c             	add    $0x2c,%esp
80106edf:	5b                   	pop    %ebx
80106ee0:	5e                   	pop    %esi
80106ee1:	5f                   	pop    %edi
80106ee2:	5d                   	pop    %ebp
80106ee3:	c3                   	ret    
80106ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ef0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
80106ef6:	83 ec 2c             	sub    $0x2c,%esp
80106ef9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106efc:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
80106f02:	0f 85 96 00 00 00    	jne    80106f9e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
80106f08:	8b 75 18             	mov    0x18(%ebp),%esi
80106f0b:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < sz; i += PGSIZE){
80106f0d:	85 f6                	test   %esi,%esi
80106f0f:	75 18                	jne    80106f29 <loaduvm+0x39>
80106f11:	eb 75                	jmp    80106f88 <loaduvm+0x98>
80106f13:	90                   	nop
80106f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f18:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f1e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106f24:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106f27:	76 5f                	jbe    80106f88 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106f29:	8b 45 08             	mov    0x8(%ebp),%eax
80106f2c:	31 c9                	xor    %ecx,%ecx
80106f2e:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80106f31:	e8 7a f9 ff ff       	call   801068b0 <walkpgdir>
80106f36:	85 c0                	test   %eax,%eax
80106f38:	74 58                	je     80106f92 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106f3a:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
80106f3c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106f42:	ba 00 10 00 00       	mov    $0x1000,%edx
80106f47:	0f 42 d6             	cmovb  %esi,%edx
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f4a:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106f4d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80106f51:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f54:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f59:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106f5e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f62:	8b 45 10             	mov    0x10(%ebp),%eax
80106f65:	8d 0c 0b             	lea    (%ebx,%ecx,1),%ecx
80106f68:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106f6c:	89 04 24             	mov    %eax,(%esp)
80106f6f:	e8 0c a9 ff ff       	call   80101880 <readi>
80106f74:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f77:	39 d0                	cmp    %edx,%eax
80106f79:	74 9d                	je     80106f18 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106f7b:	83 c4 2c             	add    $0x2c,%esp
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  return 0;
}
80106f83:	5b                   	pop    %ebx
80106f84:	5e                   	pop    %esi
80106f85:	5f                   	pop    %edi
80106f86:	5d                   	pop    %ebp
80106f87:	c3                   	ret    
80106f88:	83 c4 2c             	add    $0x2c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106f8b:	31 c0                	xor    %eax,%eax
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}
80106f8d:	5b                   	pop    %ebx
80106f8e:	5e                   	pop    %esi
80106f8f:	5f                   	pop    %edi
80106f90:	5d                   	pop    %ebp
80106f91:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106f92:	c7 04 24 fb 7a 10 80 	movl   $0x80107afb,(%esp)
80106f99:	e8 32 94 ff ff       	call   801003d0 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106f9e:	c7 04 24 58 7b 10 80 	movl   $0x80107b58,(%esp)
80106fa5:	e8 26 94 ff ff       	call   801003d0 <panic>
80106faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fb0 <switchuvm>:
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	53                   	push   %ebx
80106fb4:	83 ec 14             	sub    $0x14,%esp
80106fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106fba:	85 db                	test   %ebx,%ebx
80106fbc:	0f 84 aa 00 00 00    	je     8010706c <switchuvm+0xbc>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106fc2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106fc5:	85 c9                	test   %ecx,%ecx
80106fc7:	0f 84 b7 00 00 00    	je     80107084 <switchuvm+0xd4>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106fcd:	8b 53 04             	mov    0x4(%ebx),%edx
80106fd0:	85 d2                	test   %edx,%edx
80106fd2:	0f 84 a0 00 00 00    	je     80107078 <switchuvm+0xc8>
    panic("switchuvm: no pgdir");

  pushcli();
80106fd8:	e8 d3 d4 ff ff       	call   801044b0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106fdd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106fe3:	8d 50 08             	lea    0x8(%eax),%edx
80106fe6:	89 d1                	mov    %edx,%ecx
80106fe8:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106fef:	c1 e9 10             	shr    $0x10,%ecx
80106ff2:	c1 ea 18             	shr    $0x18,%edx
80106ff5:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80106ffb:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
80107002:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107009:	67 00 
8010700b:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
80107012:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107018:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010701e:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107025:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010702b:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107031:	8b 53 08             	mov    0x8(%ebx),%edx
80107034:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010703a:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107040:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80107043:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107049:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
8010704f:	b8 30 00 00 00       	mov    $0x30,%eax
80107054:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107057:	8b 43 04             	mov    0x4(%ebx),%eax
8010705a:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010705f:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80107062:	83 c4 14             	add    $0x14,%esp
80107065:	5b                   	pop    %ebx
80107066:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80107067:	e9 84 d4 ff ff       	jmp    801044f0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
8010706c:	c7 04 24 19 7b 10 80 	movl   $0x80107b19,(%esp)
80107073:	e8 58 93 ff ff       	call   801003d0 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80107078:	c7 04 24 44 7b 10 80 	movl   $0x80107b44,(%esp)
8010707f:	e8 4c 93 ff ff       	call   801003d0 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80107084:	c7 04 24 2f 7b 10 80 	movl   $0x80107b2f,(%esp)
8010708b:	e8 40 93 ff ff       	call   801003d0 <panic>

80107090 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107096:	e8 95 b9 ff ff       	call   80102a30 <cpunum>
8010709b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801070a1:	05 a0 27 11 80       	add    $0x801127a0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801070a6:	8d 90 b4 00 00 00    	lea    0xb4(%eax),%edx
801070ac:	66 89 90 8a 00 00 00 	mov    %dx,0x8a(%eax)
801070b3:	89 d1                	mov    %edx,%ecx
801070b5:	c1 ea 18             	shr    $0x18,%edx
801070b8:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
801070be:	c1 e9 10             	shr    $0x10,%ecx

  lgdt(c->gdt, sizeof(c->gdt));
801070c1:	8d 50 70             	lea    0x70(%eax),%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070c4:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801070ca:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801070d0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801070d4:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
801070d8:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
801070dc:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070e0:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801070e7:	ff ff 
801070e9:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801070f0:	00 00 
801070f2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801070f9:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
80107100:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
80107107:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010710e:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107115:	ff ff 
80107117:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010711e:	00 00 
80107120:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107127:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
8010712e:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
80107135:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010713c:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107143:	ff ff 
80107145:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010714c:	00 00 
8010714e:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107155:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
8010715c:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
80107163:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010716a:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107171:	00 00 
80107173:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107179:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
80107180:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107187:	66 c7 45 f2 37 00    	movw   $0x37,-0xe(%ebp)
  pd[1] = (uint)p;
8010718d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107191:	c1 ea 10             	shr    $0x10,%edx
80107194:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107198:	8d 55 f2             	lea    -0xe(%ebp),%edx
8010719b:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
8010719e:	ba 18 00 00 00       	mov    $0x18,%edx
801071a3:	8e ea                	mov    %edx,%gs

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
801071a5:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801071ab:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801071b2:	00 00 00 00 
}
801071b6:	c9                   	leave  
801071b7:	c3                   	ret    
