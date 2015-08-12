package im.actor.core.api.rpc;
/*
 *  Generated by the Actor API Scheme generator.  DO NOT EDIT!
 */

import im.actor.runtime.bser.*;
import im.actor.core.network.parser.*;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;

import im.actor.core.api.*;

public class RequestTyping extends Request<ResponseVoid> {

    public static final int HEADER = 0x1b;
    public static RequestTyping fromBytes(byte[] data) throws IOException {
        return Bser.parse(new RequestTyping(), data);
    }

    private OutPeer peer;
    private TypingType typingType;

    public RequestTyping(@NotNull OutPeer peer, @NotNull TypingType typingType) {
        this.peer = peer;
        this.typingType = typingType;
    }

    public RequestTyping() {

    }

    @NotNull
    public OutPeer getPeer() {
        return this.peer;
    }

    @NotNull
    public TypingType getTypingType() {
        return this.typingType;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        this.peer = values.getObj(1, new OutPeer());
        this.typingType = TypingType.parse(values.getInt(3));
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        if (this.peer == null) {
            throw new IOException();
        }
        writer.writeObject(1, this.peer);
        if (this.typingType == null) {
            throw new IOException();
        }
        writer.writeInt(3, this.typingType.getValue());
    }

    @Override
    public String toString() {
        String res = "rpc Typing{";
        res += "peer=" + this.peer;
        res += ", typingType=" + this.typingType;
        res += "}";
        return res;
    }

    @Override
    public int getHeaderKey() {
        return HEADER;
    }
}